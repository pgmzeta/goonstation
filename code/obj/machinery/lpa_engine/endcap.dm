TYPEINFO(/obj/machinery/atmospherics/binary/lpa_endcap)
	mats = list(
		"metal" = 10, // TODO: balance mats
	)
/obj/machinery/atmospherics/binary/lpa_endcap
	name = "LPA Magnetic Endcap"
	desc = "Safetly completes the circuit for a lpa engine beam."
	icon = 'icons/obj/machines/nuclear.dmi'
	icon_state = "neutinj"
	density = TRUE

	/// Three heatsink slots for thermal dispersal
	var/list/heat_sinks = null

	var/temperature = T20C
	var/list/connected_lpa_beams = null

/obj/machinery/atmospherics/binary/lpa_endcap/New(new_loc)
	. = ..()
	heat_sinks = list(null, null, null)
	connected_lpa_beams = list()
	AddComponent(/datum/component/laser_sink)
	RegisterSignal(src, COMSIG_LASER_CONNECTED, PROC_REF(on_laser_incident))
	RegisterSignal(src, COMSIG_LASER_DISCONNECTED, PROC_REF(on_laser_exident))
	RegisterSignal(src, COMSIG_LASER_TRAVERSE, PROC_REF(on_laser_traverse))

/obj/machinery/atmospherics/binary/lpa_endcap/disposing()
	. = ..()
	UnregisterSignal(src, COMSIG_LASER_CONNECTED)
	UnregisterSignal(src, COMSIG_LASER_DISCONNECTED)
	UnregisterSignal(src, COMSIG_LASER_TRAVERSE)

/obj/machinery/atmospherics/binary/lpa_endcap/process(mult)
	. = ..()
	for (var/obj/linked_laser/lpa/beam in connected_lpa_beams)
		temperature += beam.get_source_power() * 0.001 // TODO: balance

	// Transfer heat to air2 through all installed heatsinks
	if (air2 && length(heat_sinks))
		var/sum_conductivity = 0
		var/sum_thermal_mass = 0
		for (var/obj/item/heat_sink/hs in heat_sinks)
			if (hs)
				sum_conductivity += calculateHeatTransferCoefficient(hs.material, null)
				sum_thermal_mass += hs.thermal_mass || 100

		if (sum_thermal_mass > 0)
			var/deltaT = temperature - air2.temperature
			if (deltaT != 0)
				var/transfer = sum_conductivity * deltaT / sum_thermal_mass // TODO: balance
				temperature -= transfer
				air2.temperature += transfer * (air2.volume / sum_thermal_mass)

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_incident(datum/source, obj/linked_laser/laser)
	if (!istype(laser, /obj/linked_laser/lpa) || laser.dir != src.dir)
		return COMPONENT_LASER_BLOCKED
	connected_lpa_beams += laser
	var/obj/linked_laser/lpa/lpa_laser = laser
	if (lpa_laser.source && !QDELETED(lpa_laser.source))
		lpa_laser.source.on_endcap_connected(src)

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_exident(datum/source, obj/linked_laser/laser)
	if (istype(laser, /obj/linked_laser/lpa))
		var/obj/linked_laser/lpa/lpa_laser = laser
		if (lpa_laser.source && !QDELETED(lpa_laser.source))
			lpa_laser.source.on_endcap_disconnected(src)
	connected_lpa_beams -= laser

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_traverse(datum/source, proc_to_call)

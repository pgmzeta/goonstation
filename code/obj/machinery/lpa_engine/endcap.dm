TYPEINFO(/obj/machinery/atmospherics/binary/lpa_endcap)
	mats = list(
		"metal" = 10, // TODO: balance mats
	)
/obj/machinery/atmospherics/binary/lpa_endcap
	name = "LPA Magnetic Endcap"
	desc = "Safetly completes the circuit for a lpa engine beam."

	var/obj/item/coil/heat_sink = null

/obj/machinery/atmospherics/binary/lpa_endcap/New(new_loc)
	. = ..()
	RegisterSignal(src, COMSIG_LASER_CONNECTED, PROC_REF(on_laser_incident))
	RegisterSignal(src, COMSIG_LASER_DISCONNECTED, PROC_REF(on_laser_exident))
	RegisterSignal(src, COMSIG_LASER_TRAVERSE, PROC_REF(on_laser_traverse))


/obj/machinery/atmospherics/binary/lpa_endcap/disposing()
	. = ..()
	UnregisterSignal(src, COMSIG_LASER_CONNECTED)
	UnregisterSignal(src, COMSIG_LASER_DISCONNECTED)
	UnregisterSignal(src, COMSIG_LASER_TRAVERSE)

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_incident(datum/source, obj/linked_laser/laser)

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_exident(datum/source, obj/linked_laser/laser)

/obj/machinery/atmospherics/binary/lpa_endcap/proc/on_laser_traverse(datum/source, proc_to_call)

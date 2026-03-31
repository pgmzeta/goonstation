/// Accumulated beam power (W·ticks) at which an unterminated beam fires a failure projectile. TODO: balance
#define LPA_FAILURE_THRESHOLD 1e6

TYPEINFO(/obj/machinery/atmospherics/unary/lpa_emitter)
	// TODO: balance mats
	mats = list(
		"metal" = 10,
	)
/obj/machinery/atmospherics/unary/lpa_emitter
	name = "Ionized Plasma Filamenter"
	desc = "Ionizes a gas into a plasma filament beam, used to generate power with related equipment."
	icon = 'icons/obj/machines/fusion.dmi'
	icon_state = "laser-premade"

	var/obj/linked_laser/lpa/beam = null
	var/is_firing = FALSE
	/// Drive frequency of the AC waveform in Hz. Must exceed the plasma cutoff frequency of the gas mix.
	/// Default 400 THz (4e14 Hz) is just above the ~318 THz cutoff for 1 atm pure plasma at room temperature.
	var/frequency = 4e14
	/// Peak drive current of the AC waveform in amps. Power output scales as I². Coil draw scales the same way.
	var/drive_current = 100
	/// Number of endcaps currently terminating active beam branches. Supports splitters producing multiple paths.
	var/endcap_connections = 0
	/// Ticks the current beam has been alive. Delays termination check by one tick to allow SPAWN(0) propagation.
	var/beam_age = 0
	/// Accumulated beam power (W per tick) from unterminated segments. Drives the failure escalation.
	var/unstable_energy = 0.0
	/// Tank of filament fuel gas slotted into the emitter. Its gas properties drive beam physics (plasma frequency, wave impedance).
	/// Separate from the pipe gas, which supplies the pre-ionizing channel pulse.
	var/obj/item/tank/fuel_tank = null


/obj/machinery/atmospherics/unary/lpa_emitter/disposing()
	if (beam && !QDELETED(beam))
		qdel(beam)
	beam = null
	beam_age = 0
	endcap_connections = 0
	unstable_energy = 0
	if (fuel_tank && !QDELETED(fuel_tank) && !isnull(src.loc))
		fuel_tank.set_loc(src.loc)
	fuel_tank = null
	..()

/// Returns the filament fuel tank's gas mixture, or null if no tank is slotted.
/// Used by the beam for plasma frequency and wave impedance calculations.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/get_fuel_gas()
	if (fuel_tank && !QDELETED(fuel_tank))
		return fuel_tank.air_contents
	return null

/// Derives channel quality (0.0–1.0) from the pipe gas state.
/// Quality scales with pressure and ionization efficiency (electron yield per kJ of ionization energy).
/// Reference: toxins at 1 atm → efficiency = 50/500 = 0.1 → quality = 1.0.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/compute_channel_quality()
	if (!air_contents || TOTAL_MOLES(air_contents) <= 0)
		return 0.0
	var/ion_energy = air_contents.enthalpy_of_ionization()
	if (ion_energy <= 0)
		return 0.0
	var/efficiency = air_contents.electron_moles() / ion_energy
	var/pressure_norm = MIXTURE_PRESSURE(air_contents)
	return clamp(efficiency * pressure_norm * 10, 0.0, 1.0)

/// Called by an endcap when it accepts a beam segment whose source is this emitter.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/on_endcap_connected(obj/machinery/atmospherics/binary/lpa_endcap/endcap)
	endcap_connections++
	unstable_energy = 0

/// Called by an endcap when it loses a beam segment whose source is this emitter.
/// Escalation is handled in process() rather than here to allow graceful rebuilds.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/on_endcap_disconnected(obj/machinery/atmospherics/binary/lpa_endcap/endcap)
	endcap_connections = max(0, endcap_connections - 1)

/// Walks the beam chain to find the last (endpoint) segment.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/get_beam_endpoint()
	var/obj/linked_laser/lpa/seg = beam
	while (seg && !QDELETED(seg) && seg.next && !QDELETED(seg.next))
		seg = seg.next
	return seg

/// Spawns a plasma projectile at the unterminated beam endpoint, scaled to the accumulated unstable_energy.
/obj/machinery/atmospherics/unary/lpa_emitter/proc/spawn_failure_projectile()
	var/obj/linked_laser/lpa/endpoint = get_beam_endpoint()
	if (!endpoint)
		return
	var/turf/fire_from = endpoint.current_turf
	var/datum/projectile/lpa_plasma_bolt/proj_data = new()
	proj_data.set_power_from_energy(unstable_energy)
	var/dx = (endpoint.dir & EAST) ? 1 : (endpoint.dir & WEST) ? -1 : 0
	var/dy = (endpoint.dir & NORTH) ? 1 : (endpoint.dir & SOUTH) ? -1 : 0
	var/obj/projectile/P = initialize_projectile(fire_from, proj_data, dx, dy, src)
	if (P)
		P.launch()

/obj/machinery/atmospherics/unary/lpa_emitter/attack_hand(mob/user)
	if (!src.anchored)
		boutput(user, SPAN_ALERT("\The [src] must be anchored before firing."))
		return
	var/fire_label = is_firing ? "Shut Down" : "Initiate Beam"
	var/fuel_status = fuel_tank ? "\The [fuel_tank]" : "none"
	var/list/alert_options = list(fire_label, "Set Drive Current")
	if (fuel_tank)
		alert_options += "Eject Fuel Tank"
	alert_options += "Cancel"
	var/choice = tgui_alert(user, \
		"Drive current: [drive_current] A | Frequency: [round(frequency / 1e12, 0.1)] THz | Fuel tank: [fuel_status]", \
		"Ionized Plasma Filamenter", \
		alert_options)
	switch(choice)
		if("Initiate Beam")
			src.set_firing(TRUE, user)
		if("Shut Down")
			src.set_firing(FALSE, user)
		if("Set Drive Current")
			var/new_current = input(user, "Enter drive current (0 - 10000 A):", "Drive Current", drive_current) as num
			if (isnum_safe(new_current))
				drive_current = clamp(new_current, 0, 10000)
				boutput(user, SPAN_NOTICE("Drive current set to [drive_current] A."))
		if("Eject Fuel Tank")
			if (is_firing)
				boutput(user, SPAN_ALERT("Shut down \the [src] before ejecting the fuel tank."))
				return
			user.put_in_hand_or_drop(fuel_tank)
			fuel_tank = null

/obj/machinery/atmospherics/unary/lpa_emitter/attackby(obj/item/W, mob/user)
	if (iswrenchingtool(W))
		if (is_firing)
			boutput(user, SPAN_ALERT("Shut down \the [src] before unanchoring it."))
		else
			src.anchored = !src.anchored
			boutput(user, SPAN_NOTICE("\The [src] is [anchored ? "anchored" : "unanchored"]."))
		return
	if (istype(W, /obj/item/tank))
		if (is_firing)
			boutput(user, SPAN_ALERT("Shut down \the [src] before swapping fuel tanks."))
			return
		if (fuel_tank)
			user.put_in_hand_or_drop(fuel_tank)
		fuel_tank = W
		W.set_loc(src)
		boutput(user, SPAN_NOTICE("You slot \the [W] into \the [src] as filament fuel."))
		return

	. = ..()

/obj/machinery/atmospherics/unary/lpa_emitter/proc/set_firing(var/turn_on, mob/user)
	if (turn_on == is_firing)
		return
	if (turn_on && !fuel_tank)
		if (user)
			boutput(user, SPAN_ALERT("\The [src] has no fuel tank slotted."))
		return
	is_firing = turn_on
	if (!is_firing)
		if (beam && !QDELETED(beam))
			qdel(beam)
		beam = null
		beam_age = 0
		endcap_connections = 0
		unstable_energy = 0
	if (user)
		boutput(user, SPAN_NOTICE("\The [src] [is_firing ? "begins ionizing." : "shuts down."]"))

/obj/machinery/atmospherics/unary/lpa_emitter/process()
	. = ..()
	if (!is_firing || !anchored || (src.status & (NOPOWER | BROKEN)))
		if (beam && !QDELETED(beam))
			qdel(beam)
			beam = null
		beam_age = 0
		endcap_connections = 0
		unstable_energy = 0
		return

	// Coil power draw: P = I²R, normalised to R = 1 Ω
	use_power(drive_current * drive_current)

	// Rebuild beam if parameters changed or beam was destroyed externally.
	// Reset tracking vars BEFORE qdel so disconnect callbacks see beam_age=0 and don't trigger escalation.
	if (beam && !QDELETED(beam) && (beam.frequency != frequency || beam.drive_current != drive_current))
		beam_age = 0
		endcap_connections = 0
		unstable_energy = 0
		qdel(beam)
		beam = null

	if (!beam || QDELETED(beam))
		beam_age = 0
		endcap_connections = 0
		unstable_energy = 0
		var/turf/beamTurf = get_step(src, src.dir)
		if (!istype(beamTurf) || beamTurf.density)
			return
		beam = new /obj/linked_laser/lpa(beamTurf, src.dir, src)
		beam.source = src
		beam.frequency = frequency
		beam.drive_current = drive_current
		beam.try_propagate()
		return // skip validation this tick; beam needs one tick to propagate and find an endcap

	// Compute channel quality from pipe gas and assert it on the beam.
	// The pre-ionizing pilot pulse partially ionizes the pipe gas ahead of the main beam;
	// quality scales with pressure and the gas's ionization efficiency (electron yield per kJ).
	// Pipe gas is consumed each tick proportional to quality — more efficient gas, more ionization events.
	var/channel_quality = compute_channel_quality()
	air_contents.remove(0.05 * channel_quality) // TODO: balance — pre-ionizing pulse gas consumption (mol/tick)
	beam.channel_quality = channel_quality

	// Beam exists — age it and check termination
	beam_age++
	if (beam_age >= 1 && endcap_connections == 0)
		unstable_energy += beam.get_source_power()

		if (unstable_energy >= LPA_FAILURE_THRESHOLD * 0.33)
			src.playsound(src, 'sound/machines/alarm_a.ogg', 50, TRUE)
		if (unstable_energy >= LPA_FAILURE_THRESHOLD * 0.66)
			src.visible_message(SPAN_ALERT("\The [src] emits a dangerous plasma discharge warning!"))
		if (unstable_energy >= LPA_FAILURE_THRESHOLD)
			src.spawn_failure_projectile()
			src.set_firing(FALSE, null)
			src.visible_message(SPAN_ALERT("\The [src] suffers a catastrophic beam failure!"))

#undef LPA_FAILURE_THRESHOLD

/// Debug subtype — skips pipe/tank requirements, lets you set channel_quality and drive_current by hand.
/// Not intended for normal gameplay.
/obj/machinery/atmospherics/unary/lpa_emitter/cheat
	name = "Ionized Plasma Filamenter (DEBUG)"
	/// Overrides computed channel quality when >= 0. Set via attack_hand menu.
	var/forced_channel_quality = 1.0

/obj/machinery/atmospherics/unary/lpa_emitter/cheat/set_firing(var/turn_on, mob/user)
	// Skip tank requirement check for debug subtype.
	if (turn_on == is_firing)
		return
	is_firing = turn_on
	if (!is_firing)
		if (beam && !QDELETED(beam))
			qdel(beam)
		beam = null
		beam_age = 0
		endcap_connections = 0
		unstable_energy = 0
	if (user)
		boutput(user, SPAN_NOTICE("\The [src] [is_firing ? "begins ionizing." : "shuts down."]"))

/obj/machinery/atmospherics/unary/lpa_emitter/cheat/get_fuel_gas()
	// Return a synthetic gas mixture with reasonable toxins-like values so get_source_power() works without a tank.
	var/datum/gas_mixture/fake = new()
	fake.volume = 70
	fake.toxins = 1.0 // 1 mol toxins — provides electrons, permittivity, conductivity
	fake.temperature = T20C
	return fake

/obj/machinery/atmospherics/unary/lpa_emitter/cheat/compute_channel_quality()
	return forced_channel_quality

/obj/machinery/atmospherics/unary/lpa_emitter/cheat/attack_hand(mob/user)
	if (!src.anchored)
		boutput(user, SPAN_ALERT("\The [src] must be anchored before firing."))
		return
	var/fire_label = is_firing ? "Shut Down" : "Initiate Beam"
	var/choice = tgui_alert(user, \
		"[fire_label] | Current: [drive_current] A | Freq: [round(frequency / 1e12, 0.1)] THz | Channel: [forced_channel_quality]", \
		"LPA Emitter (DEBUG)", \
		list(fire_label, "Set Drive Current", "Set Frequency", "Set Channel Quality", "Cancel"))
	switch(choice)
		if("Initiate Beam")
			src.set_firing(TRUE, user)
		if("Shut Down")
			src.set_firing(FALSE, user)
		if("Set Drive Current")
			var/new_current = input(user, "Drive current (0–10000 A):", "Drive Current", drive_current) as num
			if (isnum_safe(new_current))
				drive_current = clamp(new_current, 0, 10000)
		if("Set Frequency")
			var/new_freq = input(user, "Frequency (THz):", "Frequency", round(frequency / 1e12, 0.1)) as num
			if (isnum_safe(new_freq))
				frequency = clamp(new_freq, 1, 1000) * 1e12
		if("Set Channel Quality")
			var/new_q = input(user, "Channel quality (0.0–1.0):", "Channel Quality", forced_channel_quality) as num
			if (isnum_safe(new_q))
				forced_channel_quality = clamp(new_q, 0.0, 1.0)

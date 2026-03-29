/// Fraction of beam power extracted as electricity each process() tick. Remainder continues in the re-emitted beam.
#define LPA_TAP_EXTRACTION_FRACTION 0.10
/// Channel quality boost multiplier applied to the re-emitted beam; represents coil refocusing of the plasma channel.
/// Breakeven: min(1, C × BOOST) × (1 − EXTRACT) = C → tap is a net channel quality gain when C < ~0.87.
#define LPA_TAP_CONTAINMENT_BOOST   1.15

TYPEINFO(/obj/machinery/power/lpa_tap)
	// TODO: balance mats
	mats = list(
		"metal" = 10,
	)
/obj/machinery/power/lpa_tap
	name = "Plasma Filament Tap"
	desc = "When placed under a plasma filament beam, converts some of its self-containment field strength to electrical power."
	density = 1
	icon = 'icons/obj/machines/nuclear.dmi'
	icon_state = "engineoff"

	var/obj/item/coil/small/coil = null
	var/watts_gen = 0
	var/lastgen = 0
	/// Maps each incoming laser to its re-emitted counterpart so it can be cleaned up on disconnect
	var/list/obj/linked_laser/emitted_beams = null
	/// Connected LPA beams; iterated each process() to sum power output
	var/list/obj/linked_laser/lpa/connected_lpa_beams = null

/obj/machinery/power/lpa_tap/New(new_loc)
	. = ..()
	emitted_beams = list()
	connected_lpa_beams = list()
	AddComponent(/datum/component/laser_sink)
	RegisterSignal(src, COMSIG_LASER_CONNECTED, PROC_REF(on_laser_incident))
	RegisterSignal(src, COMSIG_LASER_DISCONNECTED, PROC_REF(on_laser_exident))
	RegisterSignal(src, COMSIG_LASER_TRAVERSE, PROC_REF(on_laser_traverse))

/obj/machinery/power/lpa_tap/disposing()
	if (src.coil)
		if (!QDELETED(src.coil) && !isnull(src.loc))
			src.coil.set_loc(src.loc)
		src.coil = null
	. = ..()

/obj/machinery/power/lpa_tap/attackby(obj/item/I, mob/user)
	if (iswrenchingtool(I))
		if (src.anchored == UNANCHORED)
			src.anchored = ANCHORED
		else if (src.anchored == ANCHORED)
			src.anchored = UNANCHORED
		return
	if (istype(I, /obj/item/coil/small)) // TODO: Action Bar Swap
		var/obj/item/coil/small/old_coil = null
		if (src.coil)
			old_coil = src.coil
		I.set_loc(src)
		src.coil = I
		if (istype(old_coil))
			user.put_in_hand_or_drop(old_coil)
		return
	. = ..()

/obj/machinery/power/lpa_tap/process(mult)
	. = ..()
	watts_gen = 0
	for (var/obj/linked_laser/lpa/beam in connected_lpa_beams)
		watts_gen += beam.get_source_power() * LPA_TAP_EXTRACTION_FRACTION
	src.add_avail(src.watts_gen WATTS)
	lastgen = watts_gen
	watts_gen = 0

/obj/machinery/power/lpa_tap/proc/on_laser_incident(datum/source, obj/linked_laser/laser)
	var/obj/linked_laser/out = laser.copy_laser(get_turf(src), laser.dir)
	out.previous = laser
	emitted_beams[laser] = out
	if (istype(laser, /obj/linked_laser/lpa))
		var/obj/linked_laser/lpa/lpa_in = laser
		var/obj/linked_laser/lpa/lpa_out = out
		// Tap coil refocuses the plasma channel (quality boost) then bleeds some power as electricity.
		// Net effect: boost when channel_quality < ~0.87, slight drag above that.
		// Must be set before try_propagate() so downstream copy_laser() degrades from the boosted value.
		var/boosted = min(1.0, lpa_in.channel_quality * LPA_TAP_CONTAINMENT_BOOST)
		lpa_out.channel_quality = boosted * (1 - LPA_TAP_EXTRACTION_FRACTION)
		connected_lpa_beams += laser
	out.try_propagate()

/obj/machinery/power/lpa_tap/proc/on_laser_exident(datum/source, obj/linked_laser/laser)
	qdel(emitted_beams[laser])
	emitted_beams.Remove(laser)
	if (istype(laser, /obj/linked_laser/lpa))
		connected_lpa_beams -= laser

/obj/machinery/power/lpa_tap/proc/on_laser_traverse(datum/source, proc_to_call)
	for (var/key in emitted_beams)
		emitted_beams[key].traverse(proc_to_call)

#undef LPA_TAP_EXTRACTION_FRACTION
#undef LPA_TAP_CONTAINMENT_BOOST



TYPEINFO(/obj/machinery/power/lpa_tap)
	// TODO: balance mats
	mats = list(
		"metal" = 10,
	)
/obj/machinery/power/lpa_tap
	name = "Plasma Filament Tap"
	desc = "When placed under a plasma filament beam, converts some of its self-containment field strength to electrical power."

/obj/machinery/power/lpa_tap/New(new_loc)
	. = ..()
	RegisterSignal(src, COMSIG_LASER_CONNECTED, PROC_REF(on_laser_incident))
	RegisterSignal(src, COMSIG_LASER_DISCONNECTED, PROC_REF(on_laser_exident))
	RegisterSignal(src, COMSIG_LASER_TRAVERSE, PROC_REF(on_laser_traverse))


/obj/machinery/power/lpa_tap/proc/on_laser_incident(datum/source, obj/linked_laser/laser)


/obj/machinery/power/lpa_tap/proc/on_laser_exident(datum/source, obj/linked_laser/laser)


/obj/machinery/power/lpa_tap/proc/on_laser_traverse(datum/source, proc_to_call)


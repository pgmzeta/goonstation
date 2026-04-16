ABSTRACT_TYPE(/datum/random_event/weather)
/datum/random_event/weather
	var/list/incompatible_maps = list() // maybe should be map setting?

/datum/random_event/weather/is_event_available(ignore_time_lock)
	. = ..()
	if (.)
		if (global.map_setting in src.incompatible_maps)
			return FALSE

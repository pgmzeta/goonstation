/mob/dead/target_observer/headspider_takeover
	is_respawnable = FALSE
	locked = TRUE
	default_speech_output_channel = null

	var/datum/abilityHolder/changeling/changeling = null

	New(mob/M)
		. = ..()
		REMOVE_ATOM_PROPERTY(src, PROP_MOB_EXAMINE_ALL_NAMES, src)
		src.host_mob = M
	stop_observing()
		set hidden = 1
		return

	disposing()
		LAZYLISTREMOVE(observers, src)
		. = ..()

/// Can the headspider assume control of their host mob
/mob/dead/target_observer/headspider_takeover/proc/can_assume_control()
	if (isalive(src) && istype(src.target, /mob/living/carbon/human))
		return TRUE // I Am In Control.
	return FALSE

/mob/dead/target_observer/headspider_takeover/emote(act, voluntary)
	if (src.can_assume_control())
		var/mob/living/carbon/human/H = src.target
		return H.emote(name)

/mob/dead/target_observer/headspider_takeover/hotkey(name)
	if (src.can_assume_control())
		var/mob/living/carbon/human/H = src.target
		return H.hotkey(name)
	. = ..(name)

/mob/dead/target_observer/headspider_takeover/internal_process_move(keys)
	if (keys && src.can_assume_control())
		var/mob/living/carbon/human/H = src.target
		H.move_dir = src.move_dir
		var/delay = H.process_move(keys)
		if (isnull(delay))
			return FALSE
		if (client)
			return TRUE
		return TRUE
	. = ..(keys)

/mob/dead/target_observer/headspider_takeover/click(atom/target, list/params)
	if (src.can_assume_control())
		var/mob/living/carbon/human/H = src.target
		return H.click(target, params)
	. = ..(target, params)

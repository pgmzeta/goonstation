

ABSTRACT_TYPE(/datum/item_reward)
/datum/item_reward
	var/title = ""
	var/desc = ""

	/// The list of players who have redeemed this item
	var/list/datum/player/redeemed_by = list()
	/// Number of redeems per player per round. -1 is infinite
	var/max_redeem_per_round = -1

	/// message given on successful redeem
	var/success_message
	/// message given on failure to redeem
	var/failure_message

	/// Needed item, if any. If set, `given_item_path` MUST be set
	var/needed_item_path
	/// Given item, if any
	var/given_item_path

	///The required medal the player must have for the reward, if any
	var/required_medal = null
	/// The required player job, if any
	var/required_job = null
	/// The required job XP level, if any. If Byond is down, does not apply.
	var/required_job_level = 0

/// Is a player eligible to redeem this reward. Warning: You MUST use a SPAWN for this proc - API calls inside.
/datum/item_reward/proc/can_redeem(client/C)
	var/datum/player/player = make_player(C.key)
	if (!istype(player))
		logTheThing(LOG_DEBUG, src, "unable to get player for client [C].")
		CRASH("Unable to get or make player for given client!")

	// redeem caps
	if (src.max_redeem_per_round > 0)
		if (player.ckey in list_keys(src.redeemed_by))
			if (src.redeemed_by[player.ckey] >= src.max_redeem_per_round)
				return REWARD_REDEEM_FAIL_LIMIT_REACHED

	// job check
	if (src.required_job)
		if (!C.mob || !C.mob.mind || !C.mob.mind.assigned_role || C.mob.mind.assigned_role != src.required_job)
			return REWARD_REDEEM_FAIL_JOB_WRONG
		if (src.required_job_level > 0)
			var/level_response = get_level(C.ckey, src.required_job)
			if (isnum(level_response))
				if (round(LEVEL_FOR_XP(level_response)) < src.required_job_level)
					return REWARD_REDEEM_FAIL_JOB_LEVEL
			// Error getting XP, don't block them

	// medal check - we do this last b/c it may take a bit
	if (src.required_medal)
		if (!player.has_medal(src.required_medal))
			return REWARD_REDEEM_FAIL_MISSING_MEDAL

	return REWARD_REDEEM_ALLOWED

/// Attempt to redeem this reward
/datum/item_reward/proc/attempt_redeem(client/C)
	SPAWN(0) // hits api so we have to spawn
		var/redeem_check_result = can_redeem(C)
		switch(redeem_check_result)
			if(REWARD_REDEEM_ALLOWED)
				var/success = src.give_reward(C)
				if (success)
					src.record_success(C)
				else
					boutput(C.mob, SPAN_ALERT(failure_message))
			if(REWARD_REDEEM_FAIL_LIMIT_REACHED)
				boutput(C.mob, SPAN_ALERT("You can only redeem [src.title] [src.max_redeem_per_round] times per round."))
			if(REWARD_REDEEM_FAIL_JOB_WRONG)
				boutput(C.mob, SPAN_ALERT("You can only redeem [src.title] while signed up as a [src.required_job]."))
			if(REWARD_REDEEM_FAIL_JOB_LEVEL)
				boutput(C.mob, SPAN_ALERT("You can only redeem [src.title] if you are level [src.required_job_level] in the [src.required_job] job."))
			if(REWARD_REDEEM_FAIL_MISSING_MEDAL)
				boutput(C.mob, SPAN_ALERT("You can only redeem [src.title] with the '[src.required_medal]' medal."))

/// actually redeem the reward. Return TRUE if reward given successfully.
/datum/item_reward/proc/give_reward(client/C)
	var/success = FALSE
	if (src.needed_item_path && src.given_item_path)
		var/obj/item/item_to_replace = locate(src.needed_item_path) in C.mob.contents
		if (istype_exact(item_to_replace, src.needed_item_path))
			C.mob.remove_item(item_to_replace)
			qdel(item_to_replace)
			var/obj/item/item_to_give = new given_item_path(get_turf(C.mob))
			C.mob.put_in_hand_or_drop(item_to_give)
			success = TRUE

	else if (src.given_item_path)
		var/obj/item/item_to_give = new given_item_path(get_turf(C.mob))
		C.mob.put_in_hand_or_drop(item_to_give)
		success = TRUE

	return success

/// record a successful redeem
/datum/item_reward/proc/record_success(client/C)
	if (!(C.ckey in list_keys(src.redeemed_by)))
		src.redeemed_by[C.ckey] = 0
	src.redeemed_by[C.ckey] = src.redeemed_by[C.ckey] + 1

	boutput(C.mob, SPAN_SUCCESS(src.success_message))

ABSTRACT_TYPE(/datum/item_reward/job)
/datum/item_reward/job
/datum/item_reward/job/can_redeem(client/C)


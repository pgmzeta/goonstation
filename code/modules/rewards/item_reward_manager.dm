/datum/item_reward_manager
	var/list/rewards = list()

/datum/item_reward_manager/New()
	. = ..()
	for (var/datum/item_reward/reward in concrete_typesof(/datum/item_reward, FALSE))
		src.rewards += reward

/datum/item_reward_manager/proc/cache_all_medals()
	for (var/client/C in clients)
		if (C.mob?.mind)
			var/datum/player/player = C.mob.mind.get_player()
			if (istype(player))
				src.cache_player_medals(player)

/datum/item_reward_manager/proc/cache_player_medals(datum/player/player)
	SPAWN(0)
		rewards[player.ckey] = player.get_all_medals()


/datum/item_reward_manager/proc/cache_job_xp()


/datum/item_reward_manager/proc/get_eligible_rewards(client/C)
	for (var/datum/item_reward/reward in src.rewards)


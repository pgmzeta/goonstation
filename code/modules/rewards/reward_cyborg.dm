/datum/item_reward/job/cyborg
	required_job = "Cyborg"

/datum/item_reward/job/cyborg/automaton
	title = "(Cyborg Skin) Automaton"
	desc = "Turns you into the mysterious Automaton! Only in appearance, of course. Keys not included."
	required_medal = "Icarus"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (isrobot(activator))
			var/mob/living/silicon/robot/robot = activator
			robot.automaton_skin = 1
			robot.update_appearance()
			return 1
		else
			boutput(activator, SPAN_ALERT("You need to be a cyborg to use this, you goof!"))

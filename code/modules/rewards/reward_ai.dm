ABSTRACT_TYPE(/datum/item_reward/job/ai)
/datum/item_reward/job/ai
	required_job = "AI"

/datum/item_reward/job/ai/face_malfunction
	title = "(AI Face) Malfunction"
	desc = "Turns you into a scary malfunctioning AI! Only in appearance, of course."
	required_medal = "HUMANOID MUST NOT ESCAPE"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (isAI(activator))
			var/mob/living/silicon/ai/A = activator
			if (isAIeye(activator))
				var/mob/living/intangible/aieye/AE = activator
				A = AE.mainframe
			A.custom_emotions = ai_emotions | list("ROGUE (reward)" = "ai_red")
			A.faceEmotion = "ai_red"
			A.set_color("#EE0000")
			A.update_appearance()
			return 1
		else
			boutput(activator, SPAN_ALERT("You need to be an AI to use this, you goof!"))

/datum/item_reward/job/ai/face_tetris
	title = "(AI Face) Tetris"
	desc = "Turns you into a tetris-playing machine!"
	required_medal = "Block Stacker"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (isAI(activator))
			var/mob/living/silicon/ai/A = activator
			if (isAIeye(activator))
				var/mob/living/intangible/aieye/AE = activator
				A = AE.mainframe
			A.custom_emotions = ai_emotions | list("Tetris (reward)" = "ai_tetris")
			A.faceEmotion = "ai_tetris"
			A.set_color("#111111")
			A.update_appearance()
			return 1
		else
			boutput(activator, SPAN_ALERT("You need to be an AI to use this, you goof!"))


/datum/item_reward/job/ai/aicase
	var/aiskin = "default"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (isAI(activator))
			var/mob/living/silicon/ai/A = activator
			if (isAIeye(activator))
				var/mob/living/intangible/aieye/AE = activator
				A = AE.mainframe
			A.coreSkin = src.aiskin
			A.update_appearance()
			return 1
		else
			boutput(activator, SPAN_ALERT("You need to be an AI to use this, you goof!"))

/datum/item_reward/job/ai/aicase/standard
	title = "(AI Core Skin) Standard"
	desc = "Resets your AI core to standard."
	aiskin = "default"

/datum/item_reward/job/ai/aicase/nanotrasen
	title = "(AI Core Skin) NanoTrasen"
	desc = "Fancies up your core to show some company spirit!"
	aiskin = "nt"

/datum/item_reward/job/ai/aicase/nanotrasen_old
	title = "(AI Core Skin) NanoTrasen (Dated)"
	desc = "Fancies up your core to show some company spirit! Now with added dust and eggshell white."
	aiskin = "ntold"

/datum/item_reward/job/ai/aicase/gardengear
	title = "(AI Core Skin) Hydroponics"
	desc = "Paints your core with the colours of the hydroponics department!"
	aiskin = "gardengear"

/datum/item_reward/job/ai/aicase/science
	title = "(AI Core Skin) Research"
	desc = "Paints your core with the colours of the research department!"
	aiskin = "science"

/datum/item_reward/job/ai/aicase/medical
	title = "(AI Core Skin) Medical"
	desc = "Paints your core with the colours of the medical department!"
	aiskin = "medical"

/datum/item_reward/job/ai/aicase/engineering
	title = "(AI Core Skin) Engineering"
	desc = "Paints your core with the colours of the engineering department!"
	aiskin = "engineering"

/datum/item_reward/job/ai/aicase/security
	title = "(AI Core Skin) Security"
	desc = "Fancies up your AI core to look all tactical."
	aiskin = "tactical"

/datum/item_reward/job/ai/aicase/plastic_pink
	title = "(AI Core Skin) Plastic (Pink)"
	desc = "Replaces your AI core with a fancy, child-friendly version."
	aiskin = "lgun"

/datum/item_reward/job/ai/aicase/plastic_blue
	title = "(AI Core Skin) Plastic (Blue)"
	desc = "Replaces your AI core with a fancy, child-friendly version."
	aiskin = "telegun"

/datum/item_reward/job/ai/aicase/rustic
	title = "(AI Core Skin) Rustic"
	desc = "Replaces your AI core with a much, much older model."
	aiskin = "rustic"

/datum/item_reward/job/ai/aicase/bee
	title = "(AI Core Skin) Bee"
	desc = "Buzz Buzz!"
	required_medal = "Bombini is Missing!"
	aiskin = "bee"

/datum/item_reward/job/ai/aicase/ai_ailes
	title = "(AI Core Skin) Bulky"
	desc = "Replaces your core with a bulky older model."
	required_medal = "I'm in"
	aiskin = "ailes"

/datum/item_reward/job/ai/aicase/ai_crt
	title = "(AI Core Skin) CRT Television"
	desc = "Replaces the casing of your core with a CRT television."
	required_medal = "I Spy"
	aiskin = "crt"

/datum/item_reward/job/ai/aicase/ai_dwaine
	title = "(AI Core Skin) DWAINE"
	desc = "Replaces the casing of your core with an older model!"
	required_medal = "421"
	aiskin = "dwaine"

/datum/item_reward/job/ai/aicase/ai_gold
	title = "(AI Core Skin) Golden"
	desc = "Gold plates your AI core!"
	required_medal = "Helios"
	aiskin = "gold"

/datum/item_reward/job/ai/aicase/ai_industrial
	title = "(AI Core Skin) Industrial"
	desc = "Reinforces your AI core with a shiny reinforced alloy straight from mining-- purely superficially, of course."
	required_medal = "This object menaces with spikes of..."
	aiskin = "industrial"

/*/datum/item_reward/job/ai/aicase/ai_kingsway
	title = "(AI Core Skin) Kingsway"
	desc = "Replaces your AI core with a fancy new model."
	required_medal = PLEEEASE someone make a kingsway associated medal something for playing all three obtainable brad tapes in the same round or something
	aiskin = "kingsway"*/

/datum/item_reward/job/ai/aicase/ai_salvage
	title = "(AI Core Skin) Salvaged"
	desc = "Superficially smashes up your AI core a bit - for that really RUGGED aesthetic."
	required_medal = "40K" //placeholder until salvagers get a greentext medal - ideally also have the core frame in the magpie use this skin
	aiskin = "salvage"

/datum/item_reward/job/ai/aicase/ai_shock
	title = "(AI Core Skin) Shock"
	desc = "Fancies your AI core up to look very neon."
	required_medal = "Virtual Ascension"
	aiskin = "shock"

/datum/item_reward/job/ai/aicase/ai_soviet
	title = "(AI Core Skin) Soviet"
	desc = "Replaces your AI core with a model originating from the Eastern Bloc."
	required_medal = "My Bologna Has A First Name" //placeholder bc there's no directly soviet related medals and meat has some soviet stuff in it ig
	aiskin = "soviet"

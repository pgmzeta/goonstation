ABSTRACT_TYPE(/datum/item_reward/general)
/datum/item_reward/general

/datum/item_reward/general/satchel
	title = "(Skin) Satchel"
	desc = "Converts whatever backpack you're wearing into a satchel. Requires that you're wearing a backpack."
	required_medal = "Fish"

	give_reward(client/C)
		var/mob/activator = C.mob

		if (!istype(activator))
			return

		if (!activator.back)
			boutput(activator, SPAN_ALERT("You can't reskin a backpack if you're not wearing one!"))
			return

		var/obj/item/storage/backpack/M = activator.back
		var/prev_desc

		if(!istype(M))
			boutput(activator, SPAN_ALERT("Whatever it is you've got on your back, it isn't a backpack!"))
			return

		//SPACEBUX REWARD BACKPACKS
		if (istype(M, /obj/item/storage/backpack/NT) || activator.back.icon_state == "NTbackpack")
			M.icon_state = "NTsatchel"
			M.item_state = "NTsatchel"
			M.name = "\improper NT Satchel"
			M.real_name = "NT satchel"
			M.desc = "A stylish blue, thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder. (Base Item: NT backpack)"

		else if (istype(M, /obj/item/storage/backpack/randoseru) || activator.back.icon_state == "bp_randoseru")
			M.icon_state = "sat_randoseru"
			M.item_state = "sat_randoseru"
			M.name = "randoseru satchel"
			M.real_name = "randoseru satchel"
			M.desc = "Inconspicuous, nostalgic and quintessentially Space Japanese. (Base Item: randoseru)"

		else if (istype(M, /obj/item/storage/backpack/fjallravenyel) || activator.back.icon_state == "bp_fjallraven_yellow")
			M.icon_state = "sat_fjallraven_yellow"
			M.item_state = "sat_fjallraven_yellow"
			M.name = "rucksack satchel"
			M.real_name = "rucksack satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, perfectly suited for outdoorsy, adventure-loving staff. (Base Item: rucksack)"

		else if (istype(M, /obj/item/storage/backpack/fjallravenred) || activator.back.icon_state == "bp_fjallraven_red")
			M.icon_state = "sat_fjallraven_red"
			M.item_state = "sat_fjallraven_red"
			M.name = "rucksack satchel"
			M.real_name = "rucksack satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, perfectly suited for outdoorsy, adventure-loving staff. (Base Item: rucksack)"

		else if (istype(M, /obj/item/storage/backpack/anello) || activator.back.icon_state == "bp_anello")
			M.icon_state = "sat_anello"
			M.item_state = "sat_anello"
			M.name = "travel satchel"
			M.real_name = "travel satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, often seen carried by tourists and travelers. (Base Item: travel pack)"

		else if (istype(M, /obj/item/storage/backpack/studdedblack) || activator.back.icon_state == "bp_studded")
			M.icon_state = "sat_studded"
			M.item_state = "sat_studded"
			M.name = "studded satchel"
			M.real_name = "studded satchel"
			M.desc = "Made of sturdy synthleather and covered in metal studs. Much edgier than the standard issue bag. (Base Item: studded backpack)"

		else if (istype(M, /obj/item/storage/backpack/itabag/blue) || activator.back.icon_state == "bp_itabag_blue")
			prev_desc = M.desc
			M.icon_state = "sat_itabag_blue"
			M.item_state = "sat_itabag_blue"
			M.name = "blue itabag satchel"
			M.real_name = "blue itabag satchel"
			M.desc = "[prev_desc] (Base Item: blue itabag)"

		else if (istype(M, /obj/item/storage/backpack/itabag/purple) || activator.back.icon_state == "bp_itabag_purple")
			prev_desc = M.desc
			M.icon_state = "sat_itabag_purple"
			M.item_state = "sat_itabag_purple"
			M.name = "purple itabag satchel"
			M.real_name = "purple itabag satchel"
			M.desc = "[prev_desc] (Base Item: purple itabag)"

		else if (istype(M, /obj/item/storage/backpack/itabag/mint) || activator.back.icon_state == "bp_itabag_mint")
			prev_desc = M.desc
			M.icon_state = "sat_itabag_mint"
			M.item_state = "sat_itabag_mint"
			M.name = "mint itabag satchel"
			M.real_name = "mint itabag satchel"
			M.desc = "[prev_desc] (Base Item: mint itabag)"

		else if (istype(M, /obj/item/storage/backpack/itabag/black) || activator.back.icon_state == "bp_itabag_black")
			prev_desc = M.desc
			M.icon_state = "sat_itabag_black"
			M.item_state = "sat_itabag_black"
			M.name = "black itabag satchel"
			M.real_name = "black itabag satchel"
			M.desc = "[prev_desc] (Base Item: black itabag)"

		else if (istype(M, /obj/item/storage/backpack/itabag) || activator.back.icon_state == "bp_itabag_pink")
			prev_desc = M.desc
			M.icon_state = "sat_itabag_pink"
			M.item_state = "sat_itabag_pink"
			M.name = "pink itabag satchel"
			M.real_name = "pink itabag satchel"
			M.desc = "[prev_desc] (Base Item: pink itabag)"

		else if (istype(M, /obj/item/storage/backpack/brown) || activator.back.icon_state == "backpackbr")
			M.icon_state = "satchelbr"
			M.item_state = "satchelbr"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers. This brown variation is both rustic and adventurous! (Base Item: backpack)"

		//OTHER NON-JOB BAGS
		else if (istype(M, /obj/item/storage/backpack/NT) || activator.back.icon_state == "Syndiebackpack")
			M.icon_state = "Syndiesatchel"
			M.item_state = "Syndiesatchel"
			M.name = "\improper Syndicate Satchel"
			M.real_name = "Syndicate Satchel"
			M.desc = "A stylish red, evil, thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on an operative's shoulder. (Base Item: Syndicate backpack)"

		else if (istype(M, /obj/item/storage/backpack/studdedwhite) || activator.back.icon_state == "bp_studdedw")
			M.icon_state = "sat_studdedw"
			M.item_state = "sat_studdedw"
			M.name = "white studded satchel"
			M.real_name = "white studded satchel"
			M.desc = "Made of sturdy white synthleather and covered in metal studs. Much edgier than the standard issue bag. (Base Item: white studded backpack)"

		else if (istype(M, /obj/item/storage/backpack/bearpack) || activator.back.icon_state == "bp_bear")
			M.icon_state = "sat_bear"
			M.item_state = "sat_bear"
			M.name = "bear-satchel"
			M.real_name = "bear-satchel"
			M.desc = "An adorable friend that is perfect for hugs AND carries your gear for you, how helpful! (Base Item: bearpack)"

		else if (istype(M, /obj/item/storage/backpack/breadpack) || activator.back.icon_state == "bp_breadpack")
			M.icon_state = "sat_breadpack"
			M.item_state = "sat_breadpack"
			M.name = "bag-uette satchel"
			M.real_name = "bag-uette satchel"
			M.desc = "It kind of smells like bread too! Definitely not edible, sadly. (Base Item: bag-uette)"

		else if (istype(M, /obj/item/storage/backpack/turtlegreen) || activator.back.icon_state == "bp_turtle_green")
			M.icon_state = "sat_turtle_green"
			M.name = "green turtle shell satchel"
			M.real_name = "green turtle shell backpack"
			M.desc = "A satchel that looks like a green turtleshell. Cowabunga! (Base Item: green turtle shell backpack)"

		else if (istype(M, /obj/item/storage/backpack/turtlebrown) || activator.back.icon_state == "bp_turtle_brown")
			M.icon_state = "sat_turtle_brown"
			M.name = "brown turtle shell satchel"
			M.real_name = "brown turtle shell backpack"
			M.desc = "A satchel that looks like a brown turtleshell. How childish! (Base Item: brown turtle shell backpack)"

		else if (istype(M, /obj/item/storage/backpack/blue) || activator.back.icon_state == "backpackb")
			M.icon_state = "satchelb"
			M.item_state = "satchelb"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers. The blue variation is similar in shade to Abzu's ocean. (Base Item: backpack)"

		else if (istype(M, /obj/item/storage/backpack/red) || activator.back.icon_state == "backpackr")
			M.icon_state = "satchelr"
			M.item_state = "satchelr"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers. The red variation is striking and slightly suspicious. (Base Item: backpack)"

		else if (istype(M, /obj/item/storage/backpack/green) || activator.back.icon_state == "backpackg")
			M.icon_state = "satchelg"
			M.item_state = "satchelg"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers. The green variation reminds you of a botanist's garden... (Base Item: backpack)"

		//JOB BAGS
		else if (istype(M, /obj/item/storage/backpack/medic) || activator.back.icon_state == "bp_medic")
			M.icon_state = "satchel_medic"
			M.item_state = "satchel_medic"
			M.name = "medic's satchel"
			M.real_name = "medic's satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a medical doctor's shoulder. (Base Item: medic's backpack)"

		else if (istype(M, /obj/item/storage/backpack/security) || activator.back.icon_state == "bp_security")
			M.icon_state = "satchel_security"
			M.item_state = "satchel_security"
			M.name = "security satchel"
			M.real_name = "security satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects stylishly on the shoulder of security personnel.(Base Item: security backpack)"

		else if (istype(M, /obj/item/storage/backpack/robotics) || activator.back.icon_state == "bp_robotics")
			M.icon_state = "satchel_robotics"
			M.item_state = "satchel_robotics"
			M.name = "robotics satchel"
			M.real_name = "robotics satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects monochromatically on the shoulder of roboticists.(Base Item: robotics backpack)"

		else if (istype(M, /obj/item/storage/backpack/genetics) || activator.back.icon_state == "bp_genetics")
			M.icon_state = "satchel_genetics"
			M.item_state = "satchel_genetics"
			M.name = "genetics satchel"
			M.real_name = "genetics satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects safely on the shoulder of geneticists.(Base Item: genetics backpack)"

		else if (istype(M, /obj/item/storage/backpack/engineering) || activator.back.icon_state == "bp_engineering")
			M.icon_state = "satchel_engineering"
			M.item_state = "satchel_engineering"
			M.name = "engineering satchel"
			M.real_name = "engineering satchel"
			M.desc = "A sturdy, wearable container made of synthetic fibers, able to carry a number of objects effectively on the shoulder of engineers.(Base Item: engineering backpack)"

		else if (istype(M, /obj/item/storage/backpack/research) || activator.back.icon_state == "bp_research")
			M.icon_state = "satchel_research"
			M.item_state = "satchel_research"
			M.name = "research satchel"
			M.real_name = "research satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects efficiently on the shoulder of scientists.(Base Item: research backpack)"

		else if (istype(M, /obj/item/storage/backpack/captain/blue) || activator.back.icon_state == "capbackpack_blue")
			M.icon_state = "capsatchel_blue"
			M.item_state = "capsatchel_blue"
			M.name = "Captain's Satchel"
			M.real_name = "Captain's Satchel"
			M.desc = "A fancy designer bag made out of rare blue space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: Captain's Backpack)"

		else if (istype(M, /obj/item/storage/backpack/captain/red) || activator.back.icon_state == "capbackpack_red")
			M.icon_state = "capsatchel_red"
			M.item_state = "capsatchel_red"
			M.name = "Captain's Satchel"
			M.real_name = "Captain's Satchel"
			M.desc = "A fancy designer bag made out of rare red space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: Captain's Backpack)"

		else if (istype(M, /obj/item/storage/backpack/captain) || activator.back.icon_state == "capbackpack")
			M.icon_state = "capsatchel"
			M.item_state = "capbackpack"
			M.name = "Captain's Satchel"
			M.real_name = "Captain's Satchel"
			M.desc = "A fancy designer bag made out of space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: Captain's Backpack)"

		//GENERIC BACKPACK
		else if (M.satchel_compatible && (istype(M, /obj/item/storage/backpack) || activator.back.icon_state == "backpack"))
			M.icon_state = "satchel"
			M.item_state = "satchel"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder. (Base Item: backpack)"
		else
			boutput(activator, SPAN_ALERT("Whatever it is you've got on your back, it can't be reskinned!"))
			return

		//Updates to ensure satchel is displayed correctly
		M.icon = 'icons/obj/items/storage.dmi'
		M.inhand_image_icon = 'icons/mob/inhand/hand_storage.dmi'
		if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/hand_storage.dmi'
		M.wear_image_icon = 'icons/mob/clothing/back.dmi'
		if (M.wear_image) M.wear_image.icon = 'icons/mob/clothing/back.dmi'
		activator.set_clothing_icon_dirty()
		M.wear_layer = MOB_BACK_LAYER_SATCHEL

		return 1

/datum/item_reward/general/hightechpodskin
	title = "(Skin) HighTech Pod"
	desc = "Gives you a Kit that allows you to change the appearance of a Pod."
	required_medal = "Newton's Crew"
	max_redeem_per_round = 1
	given_item_path = /obj/item/pod/paintjob/tronthing
	success_message = "The Kit has been dropped at your current location."

/datum/item_reward/general/respirator
	title = "(Skin) Gas Respirator"
	desc = "Turns a gas mask you're wearing into a high-tech particle-filtered version."
	required_medal = "Old Enemy"
	failure_message = "Unable to redeem... are you wearing a gas mask?"

	give_reward(client/C)
		var/mob/activator = C.mob

		if (!istype(activator))
			return

		if (activator.wear_mask && istype(activator.wear_mask, /obj/item/clothing/mask/gas))
			var/obj/item/clothing/mask/gas/emergency/mask = activator.wear_mask
			mask.icon_state = "respirator-gas"
			mask.item_state = "respirator-gas"
			mask.name = "gas respirator"
			mask.real_name = "gas respirator"
			mask.desc = "A close-fitting gas mask with a custom particle filter."
			mask.color_r = 0.85
			mask.color_g = 0.85
			mask.color_b = 0.95
			activator.set_clothing_icon_dirty()
			return 1

		return ..()

/datum/item_reward/general/swatgasmask
	title = "(Skin) SWAT Gas Mask"
	desc = "Turns your Gas Mask into a SWAT Gas Mask. If you're wearing one."
	required_medal = "Leave no man behind!"
	failure_message = "Unable to redeem... are you wearing a gas mask?"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return

		if (activator.wear_mask && istype(activator.wear_mask, /obj/item/clothing/mask/gas))
			var/obj/item/clothing/mask/gas/emergency/M = activator.wear_mask
			M.icon_state = "swatNT"
			M.name = "SWAT Gas Mask"
			M.real_name = "SWAT Gas Mask"
			M.desc = "A snazzy-looking black Gas Mask."
			M.color_r = 0.8
			M.color_g = 0.8
			M.color_b = 1
			activator.set_clothing_icon_dirty()
			return 1
		boutput(activator, SPAN_ALERT("Unable to redeem... are you wearing a gas mask?"))
		return

/datum/item_reward/general/colorfulberet
	title = "(Skin) Colorful Beret"
	desc = "Turns your hat into a colorful beret. If you're wearing one."
	required_medal = "Monkey Duty"


	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (!istype(H.head, /obj/item/clothing/head/helmet) && !istype(H.head, /obj/item/clothing/head/headband && istype(H.head, /obj/item/clothing/head))) // ha...
				var/obj/item/clothing/head/M = H.head
				M.icon = 'icons/obj/clothing/item_hats.dmi'
				M.icon_state = "beret_base"
				M.item_state = "beret_base"
				M.wear_state = "beret_base"
				M.wear_image_icon = 'icons/mob/clothing/head.dmi'
				M.color = random_saturated_hex_color(1)
				M.name = "beret"
				M.real_name = "beret"
				M.desc = "A colorful beret."
				activator.set_clothing_icon_dirty()
				return 1
			boutput(activator, SPAN_ALERT("Unable to redeem... are you wearing a hat?"))
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... only humans can redeem this."))
		return 0

/datum/item_reward/general/round_flask
	title = "(Skin) Round-bottom Flask"
	desc = "Requires you to be holding a large beaker."
	required_medal = "We didn't start the fire"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return

		var/obj/item/reagent_containers/glass/beaker/large/skin_target = activator.find_type_in_hand(/obj/item/reagent_containers/glass/beaker/large)
		if (skin_target)
			var/prev = skin_target.name
			skin_target.name = "round-bottom flask"
			skin_target.desc = "A large round-bottom flask, for all your chemistry needs. (Base Item: [prev])"
			skin_target.icon_state = "large_flask"
			skin_target.item_state = "large_flask"
			skin_target.original_icon_state = "large_flask"
			skin_target.fluid_overlay_states = 11
			skin_target.container_style = "large_flask"
			skin_target.fluid_overlay_scaling = RC_REAGENT_OVERLAY_SCALING_SPHERICAL
			activator.set_clothing_icon_dirty()

			var/datum/component/component = skin_target.GetComponent(/datum/component/reagent_overlay)
			component?.RemoveComponent()
			skin_target.AddComponent( \
				/datum/component/reagent_overlay, \
				reagent_overlay_icon = skin_target.container_icon, \
				reagent_overlay_icon_state = skin_target.container_style, \
				reagent_overlay_states = skin_target.fluid_overlay_states, \
				reagent_overlay_scaling = skin_target.fluid_overlay_scaling, \
			)
			return 1
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... you need to have a large beaker in your hands."))
			return


/datum/item_reward/general/red_bucket
	title = "(Skin) Red Bucket"
	desc = "Requires you to be holding a bucket."
	required_medal = "Spotless"
	max_redeem_per_round = 1

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return

		var/obj/item/reagent_containers/glass/bucket/skin_target = activator.find_type_in_hand(/obj/item/reagent_containers/glass/bucket)

		if (skin_target)
			var/obj/item/reagent_containers/glass/bucket/red/new_bucket = new /obj/item/reagent_containers/glass/bucket/red(get_turf(activator))
			new_bucket.reagents = skin_target.reagents
			new_bucket.fingerprints = skin_target.fingerprints
			new_bucket.fingerprints_full = skin_target.fingerprints_full
			new_bucket.fingerprintslast = skin_target.fingerprintslast
			skin_target.reagents = null
			skin_target.fingerprints = null
			skin_target.fingerprints_full = null
			skin_target.fingerprintslast = null
			// Update borg's bucket in their module, don't drop it
			if (issilicon(activator))
				var/mob/living/silicon/robot/borg_activator = activator
				borg_activator.swap_individual_tool(skin_target, new_bucket)
			else
				activator.put_in_hand(new_bucket)
			qdel(skin_target)
			return 1
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... you need to have a bucket in your hands."))
			return

/datum/item_reward/general/pilotuniform
	title = "(Skin) Pilot Suit"
	desc = "Requires that you wear something in your jumpsuit slot."
	required_medal = "It's not 'Door to Heaven'"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				var/prev = M.name
				M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				M.wear_image_icon = 'icons/mob/clothing/jumpsuits/worn_js_misc.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/clothing/jumpsuits/worn_js_misc.dmi'
				M.icon_state = "mechanic-reward"
				M.item_state = "mechanic-reward"
				M.name = "pilot suit"
				M.real_name = "pilot suit"
				M.desc = "A sleek but comfortable pilot's jumpsuit. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
				return 1
			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a jumpsuit."))
			return

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return

/datum/item_reward/general/flower_scrubs
	title = "(Skin) Flower Scrubs"
	desc = "Requires that you wear medical scrubs in your jumpsuit slot."
	required_medal = "Primum non nocere"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/under/scrub/M = H.w_uniform
				if (!istype(M))
					boutput(activator, SPAN_ALERT("You're not wearing medical scrubs!"))
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/jumpsuit/hand_js.dmi'
				M.wear_image_icon = 'icons/mob/clothing/jumpsuits/worn_js_misc.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/clothing/jumpsuits/worn_js_misc.dmi'
				M.icon_state = "scrub-f"
				M.item_state = "lightblue"
				M.name = "flower scrubs"
				M.real_name = "flower scrubs"
				M.desc = "Man, these scrubs look pretty nice. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
				return 1

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return


/datum/item_reward/general/stylish
	title = "(Skin) Relic Security Jumpsuit"
	desc = "Requires that you wear a security officer or Head of Security uniform in your jumpsuit slot."
	required_medal = "Dead or alive, you're coming with me"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/under/rank/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/head_of_security))
					M.icon = initial(M.icon)
					M.inhand_image_icon = initial(M.inhand_image_icon)
					M.wear_image_icon = initial(M.wear_image_icon)
					M.item_state = initial(M.item_state)
					M.name = initial(M.name)
					M.real_name = initial(M.real_name)
					M.desc = initial(M.desc)
					M.icon_state = "hos-old"
					H.set_clothing_icon_dirty()
					return 1
				else if (istype(M, /obj/item/clothing/under/rank/security))
					M.icon = initial(M.icon)
					M.inhand_image_icon = initial(M.inhand_image_icon)
					M.wear_image_icon = initial(M.wear_image_icon)
					M.name = initial(M.name)
					M.real_name = initial(M.real_name)
					M.desc = initial(M.desc)
					M.icon_state = "security-old"
					M.item_state = "security-relic"
					H.set_clothing_icon_dirty()
					return 1

			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a HoS or Security jumpsuit."))
			return
		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return


/datum/item_reward/general/med_labcoat
	title = "(Skin) Cool Medical Labcoat"
	desc = "Requires that you wear a medical labcoat in your suit slot."
	required_medal = "Patchwork"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/medical/M = H.wear_suit
				if (istype(M))
					//change the icon if you've bought the alt jumpsuit thing (so the coat matches the alt medical jumpsuit)
					if (activator.mind && istype(activator.mind.purchased_bank_item, /datum/bank_purchaseable/altjumpsuit))
						M.icon_state = findtext(M.icon_state, "_o") ? "MDlabcoat-coolalt_o" : "MDlabcoat-coolalt"
						M.coat_style = "MDlabcoat-coolalt"
					else
						M.icon_state = findtext(M.icon_state, "_o") ? "MDlabcoat-cool_o" : "MDlabcoat-cool"
						M.coat_style = "MDlabcoat-cool"

					H.set_clothing_icon_dirty()
					return 1

			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a medical labcoat."))
			return

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return

/datum/item_reward/general/sci_labcoat
	title = "(Skin) Science Labcoat"
	desc = "Requires that you wear a labcoat in your suit slot."
	required_medal = "Meth is a hell of a drug"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/M = H.wear_suit
				if (istype(M))
					var/prev = M.name
					M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
					M.inhand_image_icon = 'icons/mob/inhand/overcoat/hand_suit.dmi'
					if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/overcoat/hand_suit.dmi'
					M.wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'
					if (M.wear_image) M.wear_image.icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'

					//change the icon if you've bought the alt jumpsuit thing (so the coat matches the alt science jumpsuit)
					if (activator.mind && istype(activator.mind.purchased_bank_item, /datum/bank_purchaseable/altjumpsuit))
						M.icon_state = findtext(M.icon_state, "_o") ? "SCIlabcoat-alt_o" : "SCIlabcoat-alt"
						M.item_state = "SCIlabcoat-alt"
						M.coat_style = "SCIlabcoat-alt"
						M.desc = "A protective laboratory coat with the green markings of a fancy Scientist. (Base Item: [prev])"
					else
						M.icon_state = findtext(M.icon_state, "_o") ? "SCIlabcoat_o" : "SCIlabcoat"
						M.item_state = "SCIlabcoat"
						M.coat_style = "SCIlabcoat"
						M.desc = "A protective laboratory coat with the purple markings of a Scientist. (Base Item: [prev])"

					M.name = "scientist's labcoat"
					M.real_name = "scientist's labcoat"
					H.set_clothing_icon_dirty()
					return 1

			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a labcoat."))
			return

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return


/datum/item_reward/general/alchemistrobes
	title = "(Skin) Grand Alchemist's Robes"
	desc = "Requires that you wear a labcoat in your suit slot."
	required_medal = "Illuminated"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/M = H.wear_suit
				if (istype(M))
					var/prev = M.name
					M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
					M.inhand_image_icon = 'icons/mob/inhand/hand_cl_suit.dmi'
					if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/hand_cl_suit.dmi'
					M.wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'
					if (M.wear_image) M.wear_image.icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'
					M.icon_state = findtext(M.icon_state, "_o") ? "alchrobe_o" : "alchrobe"
					M.item_state = "alchrobe"
					M.coat_style = "alchrobe"
					M.name = "grand alchemist's robes"
					M.real_name = "grand alchemist's robes"
					M.desc = "Well you sure LOOK the part with these on. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					return 1
			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a labcoat."))
			return

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return


/datum/item_reward/general/dioclothes
	title = "(Skin) Strange Vampire Outfit"
	desc = "Requires that you wear a vampire cape in your suit slot."
	required_medal = "Dracula Jr."

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/gimmick/vampire))
					var/prev = M.name
					M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
					M.inhand_image_icon = 'icons/mob/inhand/hand_cl_suit.dmi'
					M.wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'
					M.icon_state = "vclothes"
					M.item_state = "vclothes"
					M.name = "strange vampire outfit"
					M.real_name = "strange vampire outfit"
					M.desc = "How many breads <i>have</i> you eaten in your life? It's a good question. (Base Item: [prev])"
					M.c_flags &= ~ONBACK // no wearing the whole suit on your back
					H.set_clothing_icon_dirty()
					return 1

		boutput(activator, SPAN_ALERT("Unable to redeem... you must be wearing a vampire cape. Guess it's the thought that <i>counts<i>."))
		return

/datum/item_reward/general/golden_gun
	title = "(Skin) Golden Gun"
	desc = "Gold plates a shotgun, hunting rifle, detective revolver, or AK-47 you're holding."
	required_medal = "Helios"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			var/obj/item/gun/kinetic/gunmod
			if (istype(H.l_hand, /obj/item/gun/kinetic))
				gunmod = H.l_hand
			else if (istype(H.r_hand, /obj/item/gun/kinetic))
				gunmod = H.r_hand
			if (!gunmod)
				boutput(activator, SPAN_ALERT("You can't be the man with the golden gun if you ain't got a got dang gun!"))
				return
			if(!gunmod.gildable)
				boutput(activator, SPAN_ALERT("This gun doesn't seem to be gildable!"))
				return

			gunmod.name = "Golden [gunmod.name]"
			gunmod.icon_state = "[initial(gunmod.icon_state)]-golden"
			gunmod.item_state = "[initial(gunmod.item_state)]-golden"
			if(gunmod.wear_state)
				gunmod.wear_state = "[initial(gunmod.wear_state)]-golden"
			gunmod.gilded = TRUE
			gunmod.UpdateIcon()
			H.update_inhands()
			return 1

/datum/item_reward/general/goldenCarrier
	title = "Golden Carrier"
	desc = "Gold plates a pet carrier."
	required_medal = "Noah's Shuttle"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			var/obj/item/pet_carrier/carrier
			if (istype(H.l_hand, /obj/item/pet_carrier))
				carrier = H.l_hand
			else if (istype(H.r_hand, /obj/item/pet_carrier))
				carrier = H.r_hand
			if (!carrier)
				boutput(activator, SPAN_ALERT("You attempt to plate your non-existant pet carrier to no avail."))
				return
			if (carrier.gilded)
				boutput(activator, SPAN_ALERT("That's enough gold plating for now."))
				return

			carrier.name = "Golden [carrier.name]"
			carrier.empty_carrier_icon_state = "[initial(carrier.empty_carrier_icon_state)]-golden"
			carrier.icon_state = carrier.empty_carrier_icon_state
			carrier.carrier_open_item_state = "[initial(carrier.carrier_open_item_state)]-golden"
			carrier.carrier_closed_item_state = "[initial(carrier.carrier_closed_item_state)]-golden"
			carrier.trap_mob_icon_state = "[carrier.trap_mob_icon_state]-golden"
			carrier.release_mob_icon_state = "[carrier.release_mob_icon_state]-golden"
			carrier.gilded = TRUE
			carrier.UpdateIcon()
			H.update_inhands()
			return 1

/datum/item_reward/general/smug
	title = "(Emote) Smug"
	desc = "Gives you the ability to be all smug about something. I bet nobody likes you."
	required_medal = ":10bux:"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return
		activator.verbs += /proc/smugproc
		return 1

/datum/item_reward/general/shelterbee
	title = "(Emote) Shelterbee"
	desc = "Shelterbee expresses what you cannot. And it's also pretty dang cute."
	required_medal = "Too Cool"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return
		boutput(usr, SPAN_NOTICE(":shelterbee:"))
		animate_emote(usr, /obj/effect/shelterbee)
		return 1

/obj/effect/shelterbee
	name = "shelterbee"
	icon = 'icons/mob/64.dmi'
	icon_state = "shelterbee"
	anchored = ANCHORED
	pixel_x = -16
	pixel_y = -16

/datum/item_reward/general/participantribbon
	title = "(Transformation) Participation Ribbon"
	desc = "Turn into a living participation ribbon. No refunds!"
	required_medal = "Fun Times"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!isobserver(activator))
			boutput(activator, SPAN_ALERT("You gotta be dead to use this, you goof!"))
			return
		if(istype(activator, /mob/dead/target_observer) && !istype_exact(activator, /mob/dead/target_observer))
			boutput(activator, SPAN_ALERT("You gotta be a ghost to use this, you goof!"))
			return
		var/mob/living/object/O = new /mob/living/object(get_turf(usr), new /obj/item/sticker/ribbon/participant, usr)
		O.say_language = LANGUAGE_ANIMAL
		O.literate = 0
		return 1

/datum/item_reward/general/goldbud
	title = "(Skin) Golden PR-4 Guardbuddy Frame"
	desc = "Gold plates a held PR-4 Guardbuddy frame."
	required_medal = "Ol' buddy ol' pal"
	max_redeem_per_round = 1

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return

		var/obj/item/guardbot_frame/old/skin_target = activator.find_type_in_hand(/obj/item/guardbot_frame/old)
		if (skin_target)
			new /obj/item/guardbot_frame/old/golden(get_turf(activator))
			qdel(skin_target)
			return 1

		boutput(activator, SPAN_ALERT("You need to be holding a PR-4 Guardbuddy frame in order to claim this reward!"))
		return


// /proc/smugproc()
// 	set name = ":smug:"
// 	set desc = "Allows you to show others how great you feel about yourself for having paid 10 bucks."
// 	set category = "Commands"

// 	animate_emote(usr, /obj/effect/smug)
// 	usr.verbs -= /proc/smugproc
// 	usr.verbs += /proc/smugprocCD
// 	SPAWN(30 SECONDS)
// 		boutput(usr, SPAN_NOTICE("You can now be smug again! Go hog wild."))
// 		usr.verbs += /proc/smugproc
// 		usr.verbs -= /proc/smugprocCD
// 	return

// /proc/smugprocCD()
// 	set name = ":smug:"
// 	set desc = "Currently on cooldown."
// 	set category = "Commands"

// 	boutput(usr, SPAN_ALERT("You can't use that again just yet."))
// 	return

/obj/effect/smug
	name = "smug"
	icon = 'icons/mob/64.dmi'
	icon_state = "smug"
	anchored = ANCHORED
	pixel_x = -16
	pixel_y = -16

/datum/item_reward/general/beefriend
	title = "(Reagent) Bee"
	desc = "You're gonna burp one up, probably."
	required_medal = "Bombini is Missing!"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!activator.reagents) return
		activator.reagents.add_reagent("bee", 5)
		boutput (activator, SPAN_ALERT("Pleeze hold, bee will bee with thee shortlee!") )
		return 1

/datum/item_reward/general/bloodflood
	title = "(Fancy Gib) Plague of Blood"
	desc = "This will cleanse you of Original Sin (permanently)."
	required_medal = "Original Sin"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (isdead(activator))
			boutput(activator, SPAN_ALERT("You uh, yeah no- you already popped, buddy."))
			return
		if (activator.restrained() || is_incapacitated(activator))
			boutput(activator, SPAN_ALERT("Absolutely Not. You can't be incapacitated."))
			return
		var/blood_id = "blood"
		var/blood_amount = 500
		var/blood_mult = 6.9
		var/mob/living/L = activator
		if(istype(L))
			var/mob/living/carbon/human/H = activator
			if(L.blood_id)
				blood_id = L.blood_id
			if(istype(H) && H.blood_volume)
				blood_amount = H.blood_volume
		activator.suiciding = 1
		var/turf/T = get_turf(activator)
		if (L?.traitHolder?.hasTrait("hemophilia"))
			blood_mult = blood_mult + 3
		T.fluid_react_single(blood_id,blood_mult * blood_amount)
		var/result = activator.mind.get_player().clear_medal("Original Sin")
		logTheThing(LOG_COMBAT, activator, "Activated the blood flood gib reward thing (Original Sin)")
		if (result)
			boutput(activator, SPAN_ALERT("You feel your soul cleansed of sin."))
			playsound(T, 'sound/voice/farts/diarrhea.ogg', 50, TRUE)
		activator.gib()
		return 1

/datum/item_reward/general/HotrodHelmet
	title = "(Skin) Hotrod Welding Helmet"
	desc = "Requires you to hold a welding helmet."
	required_medal = "Slow Burn"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (!istype(activator))
			return

		var/obj/item/clothing/head/helmet/welding/skin_target = activator.find_type_in_hand(/obj/item/clothing/head/helmet/welding)
		if (skin_target)
			var/obj/item/clothing/head/helmet/welding/fire/new_helmet = new /obj/item/clothing/head/helmet/welding/fire(get_turf(activator))
			new_helmet.fingerprints = skin_target.fingerprints
			new_helmet.fingerprints_full = skin_target.fingerprints_full
			new_helmet.fingerprintslast = skin_target.fingerprintslast
			skin_target.fingerprints = null
			skin_target.fingerprints_full = null
			skin_target.fingerprintslast = null
			qdel(skin_target)
			activator.put_in_hand_or_drop(new_helmet)
			return 1
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... you need to have a welding helmet in your hands."))
			return


// /datum/achievementReward/contributor
// 	title = "Contributor Rewards"
// 	desc = "A whole host of things and buttons to reward you for contributing!"
// 	required_medal = "Contributor"
// 	once_per_round = 0
// 	mobonly = 0

// 	rewardActivate(mob/user)
// 		ui_interact(user)
// 		return 1

// 	/// [name, desc, callback]
// 	var/contrib_rewards = list(
// 		list("Silly Screams", "Crazy silly screams for your character!", PROC_REF(sillyscream)),
// 	)

// 	ui_state(mob/user)
// 		. = tgui_always_state

// 	ui_interact(mob/user, datum/tgui/ui)
// 		ui = tgui_process.try_update_ui(user, src, ui)
// 		if(!ui)
// 			ui = new(user, src, "ContributorRewards")
// 			ui.open()

// 	ui_static_data(mob/user)
// 		var/titles = list()
// 		var/descs = list()
// 		for (var/reward in contrib_rewards)
// 			titles += reward[1]
// 			descs += reward[2]
// 		. = list(
// 			"rewardTitles" = titles,
// 			"rewardDescs" = descs,
// 		)

// 	ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
// 		. = ..()
// 		if (.)
// 			return

// 		switch(action)
// 			if("redeem")
// 				var/reward_idx = text2num(params["reward_idx"])
// 				INVOKE_ASYNC(src, contrib_rewards[reward_idx][3], ui.user)

// 	// proc/sillyscream(mob/M)
// 	// 	var/mob/living/living = M
// 	// 	if(istype( living ))
// 	// 		M.bioHolder.mobAppearance.screamsounds["sillyscream"] = pick('sound/voice/screams/sillyscream1.ogg', 'sound/voice/screams/sillyscream2.ogg')
// 	// 		M.bioHolder.mobAppearance.screamsound = "sillyscream"
// 	// 		M.bioHolder.mobAppearance.UpdateMob()
// 	// 		M.playsound_local_not_inworld(living.sound_scream, 100)
// 	// 		return 1
// 	// 	else
// 	// 		boutput( usr, SPAN_ALERT("Hmm.. I can't set the scream sound of that!") )
// 	// 		return 0

// /// Keeps track of once-per-round rewards
// /datum/player/var/list/claimed_rewards = list()

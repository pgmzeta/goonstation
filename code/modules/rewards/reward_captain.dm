ABSTRACT_TYPE(/datum/item_reward/job/captain)
/datum/item_reward/job/captain
	required_job = "Captain"

/datum/item_reward/job/captain/sabre
	title = "Commander's Sabre"
	desc = "Trade out your energy gun for a cool sword! Swords beat guns, right?"
	max_redeem_per_round = 1
	needed_item_path = /obj/item/gun/energy/egun
	given_item_path = /obj/item/swords_sheaths/captain
	success_message = "Your energy gun morphs into a sword! What the fuck!"

	// TODO: device scanner failure logic

	// activate(var/client/C)
	// 	var/found = 0
	// 	var/O = locate(sacrifice_path) in C.mob.contents
	// 	if (istype(O, sacrifice_path))
	// 		var/obj/item/gun/energy/egun/K = O
	// 		if (K.nojobreward) // Checks to see if it was scanned by a device analyzer
	// 			boutput(C.mob, "This [sacrifice_name] has forever been ruined by a device analyzer's magnets. It can't turn into a sword ever again!!")
	// 			src.claimedNumbers[usr.key] --
	// 			return
	// 		if (K.deconstruct_flags & DECON_BUILT) //Checks to see if it was built from a frame
	// 			boutput(C.mob, "This [sacrifice_name] is a replica and cannot be turned into a sword legally! Only an original, unscanned energy gun will work for this!")
	// 			src.claimedNumbers[usr.key] --
	// 			return
	// 		var/list/ret = list()
	// 		if(SEND_SIGNAL(K, COMSIG_CELL_CHECK_CHARGE, ret) & CELL_RETURNED_LIST)
	// 			var/ratio = min(1, ret["charge"] / ret["max_charge"])
	// 			if (ratio < 0.9)
	// 				boutput(C.mob, "The [sacrifice_name] is depleted, you'll need to charge it up first!")
	// 				src.claimedNumbers[usr.key]--
	// 				return
	// 		else
	// 			boutput(C.mob, "The [sacrifice_name] has no cell, you'll need to provide one first!")
	// 			src.claimedNumbers[usr.key]--
	// 			return

	// 		C.mob.remove_item(K)
	// 		found = 1
	// 		qdel(K)
	// 		boutput(C.mob, "Your energy gun morphs into a sword! What the fuck!")
	// 		var/obj/item/swords_sheaths/captain/T = new/obj/item/swords_sheaths/captain()
	// 		T.set_loc(get_turf(C.mob))
	// 		C.mob.put_in_hand(T)
	// 		return

	// 	if (!found)
	// 		boutput(C.mob, "You need to be holding an [sacrifice_name] in order to claim this reward.")
	// 		src.claimedNumbers[usr.key] --
	// 		return


/datum/item_reward/job/captain/ntso_commander
	title = "(Skin set) NT-SO Commander Uniform"
	desc = "Will change the skin of captain hats, captain armor/spacesuits, cap backpacks, captain gloves, sabres and captain uniforms."
	required_medal = "Icarus"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			var/succ = FALSE
			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/captain))
					var/prev = M.name
					M.name = "commander's uniform"
					M.desc = "A uniform specifically for NanoTrasen commanders. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/rank/captain/fancy))
						M.icon_state = "captain-fancy-blue"
						M.item_state = "captain-fancy-blue"
					else if (istype(M, /obj/item/clothing/under/rank/captain/dress))
						M.icon_state = "captain-dress-blue"
						M.item_state = "captain-dress-blue"
					else
						M.icon_state = "captain-blue"
						M.item_state = "captain-blue"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/under/suit/captain))
					var/prev = M.name
					M.name = "\improper Commander's suit"
					M.desc = "A uniform specifically for NanoTrasen commanders. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/suit/captain/dress))
						M.icon_state = "suit-capB-dress"
						M.item_state = "suit-capB-dress"
					else
						M.icon_state = "suit-capB"
						M.item_state = "suit-capB"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/armor/captain))
					var/prev = M.name
					M.icon_state = "centcom"
					M.item_state = "centcom"
					M.name = "commander's armor"
					M.real_name = "commander's armor"
					M.desc = "A suit of protective formal armor. It is made specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				if (istype(M, /obj/item/clothing/suit/armor/capcoat))
					var/prev = M.name
					M.icon_state = "centcoat"
					M.item_state = "centcoat"
					M.name = "commander's coat"
					M.real_name = "commander's coat"
					M.desc = "A luxurious formal coat. It is specifically made for Nanotrasen commanders.(Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/suit/space/captain))
					var/prev = M.name
					M.icon_state = "spacecap-blue"
					M.item_state = "spacecap-blue"
					M.name = "commander's space suit"
					M.real_name = "commander's space suit"
					M.desc = "A suit that protects against low pressure environments. It is made specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.gloves)
				var/obj/item/clothing/gloves/M = H.gloves
				if (istype(M, /obj/item/clothing/gloves/swat/captain))
					var/prev = M.name
					M.icon_state = "centcomgloves"
					M.item_state = "centcomgloves"
					M.name = "commander's gloves"
					M.real_name = "commander's gloves"
					M.desc = "A pair of formal gloves that are electrically insulated and quite heat-resistant. (Base Item: [prev])"
					M.fingertip_color = "#3c6dc3"
					H.update_gloves(H.mutantrace.hand_offset)
					succ = TRUE

			if (H.head)
				var/obj/item/clothing/M = H.head
				if (istype(M, /obj/item/clothing/head/caphat))
					var/prev = M.name
					M.icon_state = "centcom"
					M.item_state = "centcom"
					M.name = "commander's hat"
					M.real_name = "commander's hat"
					M.desc = "A fancy hat specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/helmet/space/captain))
					var/prev = M.name
					M.name = "commander's space helmet"
					M.desc = "Helps protect against vacuum. Comes in a fasionable blue befitting a commander. (Base Item: [prev])"
					M.icon_state = "space-captain-blue"
					M.item_state = "space-captain-blue"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/helmet/captain))
					var/prev = M.name
					M.name = "commander's helmet"
					M.desc = "Somewhat protects an important person's head from being bashed in. Comes in a stylish shade of blue befitting of a commander. (Base Item: [prev])"
					M.icon_state = "helmet-captain-blue"
					M.item_state = "helmet-captain-blue"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/bigcaphat))
					var/prev = M.name
					M.name = "commander of commander's hat"
					M.desc = "A symbol of the commander's rank, signifying they're the greatest commander, and the source of all their power. (Base Item: [prev])"
					M.icon_state = "captainbig-blue"
					M.item_state = "captainbig-blue"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.belt)
				var/obj/item/M = H.belt
				if (istype(M, /obj/item/swords_sheaths/captain))
					if (M.item_state == "scabbard-cap1" || M.item_state == "red_scabbard-cap1")
						qdel(M)
						H.equip_if_possible(new /obj/item/swords_sheaths/captain/blue(H), SLOT_BELT)
						succ = TRUE

			if (H.back)
				if (istype(H.back, /obj/item/storage/backpack/satchel/captain) || (H.back.icon_state == "capsatchel" || H.back.icon_state == "capsatchel_red"))
					var/obj/item/storage/backpack/satchel/captain/M = activator.back
					var/prev = M.name
					M.icon_state = "capsatchel_blue"
					M.item_state = "capsatchel_blue"
					M.desc = "A fancy designer bag made out of rare blue space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				if (istype(H.back, /obj/item/storage/backpack/captain))
					if (H.back.icon_state == "capbackpack" || H.back.icon_state == "capbackpack_red")
						var/obj/item/storage/backpack/captain/M = activator.back
						var/prev = M.name
						M.icon_state = "capbackpack_blue"
						M.item_state = "capbackpack_blue"
						M.desc = "A fancy designer bag made out of rare blue space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: [prev])"
						H.set_clothing_icon_dirty()
						succ = TRUE

			if(H.find_type_in_hand(/obj/item/megaphone))
				var/obj/item/megaphone/M = H.find_type_in_hand(/obj/item/megaphone)
				if (!istype(M, /obj/item/megaphone/syndicate))
					M.icon_state = "megaphone_blue"
					M.item_state = "megaphone_blue"
					M.desc = "The captain's megaphone, fancily decorated blue to induce a 'cool' and 'calming' sensation in those around. Useful for barking demands at staff assistants or getting your point across."
					M.maptext_color = "#c1ddf8"
					M.maptext_outline_color = "#02294d"
					H.update_inhands()
					succ = TRUE
				else
					boutput(H, SPAN_ALERT("That megaphone is WAY too loud to disguise."))

			if (!succ)
				boutput(activator, SPAN_ALERT("Unable to redeem... What kind of fake captain are you!?"))
			return succ
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
			return FALSE

//red captain medal, after all this time!
/datum/item_reward/job/captain/centcom_executive
	title = "(Skin Set) CENTCOM Executive Uniform"
	desc = "Will change the skin of captain hats, captain armor/spacesuits, cap backpacks, captain gloves, sabres and captain uniforms."
	required_medal = "Brown Pants" //Red shirt, brown pants.

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			var/succ = FALSE
			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/captain))
					var/prev = M.name
					M.name = "\improper CentCom uniform"
					M.desc = "A uniform specifically for CENTCOM executives. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/rank/captain/fancy))
						M.icon_state = "captain-fancy-red"
						M.item_state = "captain-fancy-red"
					else if (istype(M, /obj/item/clothing/under/rank/captain/dress))
						M.icon_state = "captain-dress-red"
						M.item_state = "captain-dress-red"
					else
						M.icon_state = "captain-red"
						M.item_state = "captain-red"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/under/suit/captain))
					var/prev = M.name
					M.name = "\improper CentCom suit"
					M.desc = "A uniform specifically for CENTCOM executives. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/suit/captain/dress))
						M.icon_state = "suit-capR-dress"
						M.item_state = "suit-capR-dress"
					else
						M.icon_state = "suit-capR"
						M.item_state = "suit-capR"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/armor/captain))
					var/prev = M.name
					M.icon_state = "centcom-red"
					M.item_state = "centcom-red"
					M.name = "\improper CentCom armor"
					M.desc = "A suit of protective formal armor. It is made specifically for CENTCOM executives. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				if (istype(M, /obj/item/clothing/suit/armor/capcoat))
					var/prev = M.name
					M.icon_state = "centcoat-red"
					M.item_state = "centcoat-red"
					M.name = "\improper CentCom coat"
					M.real_name = "\improper CentCom coat"
					M.desc = "A luxurious formal coat. It is specifically made for CENTCOM executives.(Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/suit/space/captain))
					var/prev = M.name
					M.icon_state = "spacecap-red"
					M.item_state = "spacecap-red"
					M.name = "\improper CentCom space suit"
					M.desc = "A suit that protects against low pressure environments. It is made specifically for CENTCOM executives. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.gloves)
				var/obj/item/clothing/gloves/M = H.gloves
				if (istype(M, /obj/item/clothing/gloves/swat/captain))
					var/prev = M.name
					M.icon_state = "centcomredgloves"
					M.item_state = "centcomredgloves"
					M.name = "CentCom gloves"
					M.real_name = "CentCom gloves"
					M.desc = "A pair of formal gloves that are electrically insulated and quite heat-resistant. (Base Item: [prev])"
					M.fingertip_color = "#d73715"
					H.update_gloves(H.mutantrace.hand_offset)
					succ = TRUE

			if (H.head)
				var/obj/item/clothing/M = H.head
				if (istype(M, /obj/item/clothing/head/caphat))
					var/prev = M.name
					M.icon_state = "centcom-red"
					M.item_state = "centcom-red"
					M.name = "\improper CentCom hat"
					M.desc = "A fancy hat specifically for CENTCOM executives. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/helmet/space/captain))
					var/prev = M.name
					M.name = "\improper CentCom space helmet"
					M.desc = "Helps protect against vacuum. Comes in a fasionable red befitting an executive. (Base Item: [prev])"
					M.icon_state = "space-captain-red"
					M.item_state = "space-captain-red"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/helmet/captain))
					var/prev = M.name
					M.name = "\improper CentCom helmet"
					M.desc = "Somewhat protects an important person's head from being bashed in. Comes in a stylish shade of red befitting an executive. (Base Item: [prev])"
					M.icon_state = "helmet-captain-red"
					M.item_state = "helmet-captain-red"
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/bigcaphat))
					var/prev = M.name
					M.name = "\improper CentCom Executive of Executive's hat"
					M.desc = "A symbol of the CentCom Executive's rank, signifying they're the greatest VentCom Executive, and the source of all their power. (Base Item: [prev])"
					M.icon_state = "captainbig-red"
					M.item_state = "captainbig-red"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.belt)
				var/obj/item/M = H.belt
				if (istype(M, /obj/item/swords_sheaths/captain))
					if (M.item_state == "scabbard-cap1" || M.item_state == "blue_scabbard-cap1")
						qdel(M)
						H.equip_if_possible(new /obj/item/swords_sheaths/captain/red(H), SLOT_BELT)
						succ = TRUE

			if (H.back)
				if (istype(H.back, /obj/item/storage/backpack/satchel/captain) || (H.back.icon_state == "capsatchel" || H.back.icon_state == "capsatchel_blue"))
					var/obj/item/storage/backpack/satchel/captain/M = activator.back
					var/prev = M.name
					M.icon_state = "capsatchel_red"
					M.item_state = "capsatchel_red"
					M.desc = "A fancy designer bag made out of rare red space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

				if (istype(H.back, /obj/item/storage/backpack/captain))
					if (H.back.icon_state == "capbackpack" || H.back.icon_state == "capbackpack_blue")
						var/obj/item/storage/backpack/captain/M = activator.back
						var/prev = M.name
						M.icon_state = "capbackpack_red"
						M.item_state = "capbackpack_red"
						M.desc = "A fancy designer bag made out of rare red space snake leather and encrusted with plastic expertly made to look like gold. (Base Item: [prev])"
						H.set_clothing_icon_dirty()
						succ = TRUE

			if(H.find_type_in_hand(/obj/item/megaphone))
				var/obj/item/megaphone/M = H.find_type_in_hand(/obj/item/megaphone)
				if (!istype(M, /obj/item/megaphone/syndicate))
					M.icon_state = "megaphone_red"
					M.item_state = "megaphone_red"
					M.desc = "The captain's megaphone, fancily decorated red, which helps it stand out. Useful for barking demands at staff assistants or getting your point across."
					M.maptext_color = "#fcd4d4"
					M.maptext_outline_color = "#520000"
					H.update_inhands()
					succ = TRUE
				else
					boutput(H, SPAN_ALERT("That megaphone is WAY too loud to disguise."))


			if (!succ)
				boutput(activator, SPAN_ALERT("Unable to redeem... What kind of fake captain are you!?"))
			return succ
		else
			boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
			return FALSE

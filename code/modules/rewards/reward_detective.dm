ABSTRACT_TYPE(/datum/item_reward/job/detective)
/datum/item_reward/job/detective
	required_job = "Detective"

/datum/item_reward/job/detective/Aerostaticjacket
	title = "(Skin) Aerostatic Pilot Jacket"
	desc = "Turns your detective's coat into an orange pilot jacket"
	required_medal = "Deep Freeze"

	give_reward(client/C)
		var/mob/activator = C.mob
		var/mob/living/carbon/human/H = activator
		if (H.wear_suit)
			var/obj/item/clothing/suit/det_suit/M = H.wear_suit
			if (istype(M))
				var/prev = M.name
				M.icon_state = findtext(M.icon_state, "_o") ? "detective_kim_o" : "detective_kim"
				M.coat_style = "detective_kim"
				M.name = "Aerostatic Pilot Jacket"
				M.real_name = "Aerostatic pilot jacket"
				M.desc = "You feel centered while wearing this... Maybe you could put something in the pockets? (Base Item: [prev])"
				H.set_clothing_icon_dirty()
				return 1

			if(H.mind.assigned_role == "Detective")
				boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing your jacket, detective."))
				return

			boutput(activator, SPAN_ALERT("Unable to redeem... you need to be wearing a detective's jacket."))
		return

/datum/item_reward/job/detective/inspectorscloths
	title = "(Skin set) Inspector's Clothes"
	desc = "Will change the skin of a detective's coat, hats, gloves, shoes, jumpsuit, and holster."
	required_medal = "Neither fashionable noir stylish"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			var/succ = FALSE
			if (H.wear_suit)
				var/obj/item/clothing/suit/det_suit/M = H.wear_suit
				if (istype(M))
					var/prev = M.name
					M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
					M.inhand_image_icon = 'icons/mob/inhand/overcoat/hand_suit.dmi'
					M.wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit.dmi'
					M.item_state = "inspectorc"
					M.icon_state = findtext(M.icon_state, "_o") ? "inspectorc_o" : "inspectorc"
					M.coat_style = "inspectorc"
					M.name = "inspector's short coat"
					M.real_name = "inspector's short coat"
					M.desc = "A coat for the modern detective. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/det))
					var/prev = M.name
					M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
					M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
					M.wear_image_icon = 'icons/mob/clothing/jumpsuits/worn_js_misc.dmi'
					M.icon_state = "inspectorj"
					M.item_state = "viceG"
					M.name = "inspector's uniform"
					M.real_name = "inspector's uniform"
					M.desc = "A uniform for the modern detective. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.head)
				var/obj/item/clothing/M = H.head
				var/obj/item/clothing/head/det_hat/gadget/G = H.head
				var/obj/item/clothing/head/det_hat/folded_scuttlebot/S = H.head
				if (istype(G))
					var/prev = M.name
					G.icon_state = "inspector"
					G.item_state = "inspector"
					G.desc = "Detective's special hat you can outfit with various items for easy retrieval! (Base Item: [prev])"
					G.inspector = TRUE
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(S))
					var/prev = M.name
					S.icon_state = "inspector"
					S.item_state = "inspector"
					S.name = "inspector's hat"
					S.real_name = "inspector's hat"
					S.desc = "A hat for the modern detective. It looks a bit heavier than it should. (Base Item: [prev])"
					S.inspector = TRUE
					H.set_clothing_icon_dirty()
					succ = TRUE

				else if (istype(M, /obj/item/clothing/head/det_hat))
					var/prev = M.name
					M.icon_state = "inspector"
					M.item_state = "inspector"
					M.name = "inspector's hat"
					M.real_name = "inspector's hat"
					M.desc = "A hat for the modern detective. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.belt)
				var/obj/item/storage/belt/M = H.belt
				if (istype(M, /obj/item/storage/belt/security/shoulder_holster))
					var/prev = M.name
					M.icon_state = "inspector_holster"
					M.item_state = "inspector_holster"
					M.name = "inspector's holster"
					M.real_name = "inspector holster"
					M.desc = "A shoulder holster for the modern detective. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.shoes)
				var/obj/item/clothing/M = H.shoes
				if (istype(M, /obj/item/clothing/shoes/detective))
					var/prev = M.name
					M.icon_state = "inspector"
					M.item_state = "inspector"
					M.name = "inspector's boots"
					M.real_name = "inspector's boots"
					M.desc = "This pair of boots has inspected it's fair share of mysteries. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (H.gloves)
				var/obj/item/clothing/gloves/M = H.gloves
				if (istype(M, /obj/item/clothing/gloves/black))
					var/prev = M.name
					M.icon_state = "inspector"
					M.item_state = "inspector"
					M.name = "inspector's gloves"
					M.real_name = "inspector's gloves"
					M.desc = "A pair of gloves for the modern detective. (Base Item: [prev])"
					M.fingertip_color = "#2d3c52"
					H.set_clothing_icon_dirty()
					succ = TRUE

			if (!succ)
				boutput(activator, SPAN_ALERT("Unable to redeem... now that's a case for a real detective, not you."))
			return succ

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return


/datum/item_reward/job/detective/the_colt
	title = "The Colt"
	desc = "Gain access to an old-ish replica of an old gun by sacrificing your revolver."
	required_job_level = 0
	max_redeem_per_round = 1
	needed_item_path = /obj/item/gun/kinetic/detectiverevolver
	given_item_path = /obj/item/gun/kinetic/single_action/colt_saa/detective

	// TODO: Ammo handling

	// activate(var/client/C)
	// 	var/found = 0
	// 	var/tmp_ammo = null
	// 	var/tmp_current_projectile = null

	// 	var/O = locate(sacrifice_path) in C.mob.contents
	// 	if (istype(O, sacrifice_path))
	// 		var/obj/item/gun/kinetic/K = O
	// 		tmp_ammo = K.ammo
	// 		tmp_current_projectile = K.current_projectile
	// 		C.mob.remove_item(K)
	// 		found = 1
	// 		qdel(K)

	// 	if (!found)
	// 		boutput(C.mob, "You need to be holding a [sacrifice_name] in order to claim this reward.")
	// 		//Remove used from list of claimed. I'll make this more elegant once I understand it all. No time for it now. -Kyle
	// 		src.claimedNumbers[usr.key] --
	// 		return

	// 	var/obj/item/gun/kinetic/single_action/colt_saa/colt = new reward_path()
	// 	if (!istype(colt))
	// 		boutput(C.mob, "Something terribly went wrong. The reward path got screwed up somehow. call 1-800-CODER. But you're a detective! You don't need no stinkin' guns anyway!")
	// 		src.claimedNumbers[usr.key] --
	// 		return

	// 	if (tmp_ammo && tmp_current_projectile)
	// 		colt.ammo = tmp_ammo
	// 		colt.set_current_projectile(tmp_current_projectile)
	// 	if (!colt.ammo)
	// 		colt.ammo = new/obj/item/ammo/bullets/a38/stun
	// 	if (!colt.current_projectile)
	// 		colt.set_current_projectile(new/datum/projectile/bullet/revolver_38/stunners)

	// 	colt.set_loc(get_turf(C.mob))
	// 	C.mob.put_in_hand(colt)
	// 	boutput(C.mob, "Your revolver vanishes and is replaced with [colt]!")
	// 	return

/datum/item_reward/job/detective/noir_glasses
	title = "Noir-Tech Glasses"
	desc = "Gain access to a pair of glasses that replicates monochromia."
	max_redeem_per_round = 1
	given_item_path = /obj/item/clothing/glasses/noir


ABSTRACT_TYPE(/datum/item_reward/job/clown)
/datum/item_reward/job/clown
	required_job = "Clown"

/datum/item_reward/job/clown/clown_college
	title = "Clown College Regalia"
	desc = "Spawns you your clown college graduation cap and diploma."
	required_medal = "Unlike the director, I went to college"

	give_reward(client/C)
		var/mob/activator = C.mob
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.mind.assigned_role == "Clown")
				H.equip_if_possible(new /obj/item/clothing/head/graduation_cap(H), SLOT_HEAD)
				var/obj/item/toy/diploma/D = new /obj/item/toy/diploma(get_turf(H))
				D.redeemer = H.ckey
				H.put_in_hand_or_drop(D)
				return 1
			boutput(H, "You're not a honking clown, you imposter!")

		boutput(activator, SPAN_ALERT("Unable to redeem... Only humans can redeem this."))
		return

/datum/item_reward/job/clown/special_crayon
	title = "Special Crayon"
	desc = "Spin it and watch it work its \"Magic\"!"
	required_job_level = 1
	max_redeem_per_round = 1
	given_item_path = /obj/item/pen/crayon/random/choose
	success_message = "You pull your special crayon out from your special place!"

/datum/item_reward/job/clown/clown_box
	title = "Clown Box"
	desc = "It's a really cool box."
	required_job_level = 5
	max_redeem_per_round = 1
	given_item_path = /obj/item/clothing/suit/cardboard_box/colorful/clown
	success_message = "You pull your clown box out from your - wait, what?"

/datum/item_reward/job/clown/rubber_hammer
	title = "Rubber Hammer"
	desc = "Haha, hammer go 'boing'"
	required_job_level = 10
	max_redeem_per_round = 1
	given_item_path = /obj/item/rubber_hammer
	success_message = "You pull your rubber hammer out from your nose!"

/datum/item_reward/job/clown/nothing
	title = "Nothing!!!"
	desc = "Nothing Again Again Again!!!"
	required_job_level = 15
	max_redeem_per_round = 1
	success_message = "Nothing seems to happen!"

/datum/item_reward/job/clown/bananna
	title = "Bananna"
	desc = "Bananna, but misspelled!"
	required_job_level = 20
	max_redeem_per_round = 1
	success_message = "You get a \"banana\"!"

	give_reward(client/C)
		var/obj/item/banana = null
		if (prob(1))
			banana = new/obj/item/old_grenade/spawner/banana()
		else
			banana = new/obj/item/reagent_containers/food/snacks/plant/banana()
		banana.set_loc(get_turf(C.mob))
		C.mob.put_in_hand(banana)

ABSTRACT_TYPE(/datum/item_reward/job/hos)
/datum/item_reward/job/hos
	required_job = "Head of Security"

/datum/item_reward/job/hos/mug
	title = "Alternate Blue Mug"
	desc = "It's your favourite coffee mug, but now its text is blue. Wow."
	needed_item_path = /obj/item/reagent_containers/food/drinks/mug/HoS
	given_item_path = /obj/item/reagent_containers/food/drinks/mug/HoS/blue
	success_message = "The mug's colouring flips to blue!"
	failure_message = "You need to be holding your mug in order to claim this reward."

/datum/item_reward/job/hos/lawbringer
	title = "The Lawbringer"
	desc = "Gain access to a voice activated weapon of the future-past by sacrificing your egun."
	max_redeem_per_round = 1
	var/sacrifice_path = /obj/item/gun/energy/egun 		//Don't go lower than obj/item/gun/energy/egun
	var/reward_path = /obj/item/gun/energy/lawbringer
	var/sacrifice_name = "E-Gun"

	// TODO: This

	// activate(var/client/C)
	// 	var/charge = 0
	// 	var/max_charge = 0
	// 	var/found = 0
	// 	var/O = locate(sacrifice_path) in C.mob.contents
	// 	if (istype(O, sacrifice_path))
	// 		var/obj/item/gun/energy/E = O
	// 		var/list/ret = list()
	// 		if(SEND_SIGNAL(E, COMSIG_CELL_CHECK_CHARGE, ret) & CELL_RETURNED_LIST)
	// 			charge = ret["charge"]
	// 			max_charge = ret["max_charge"]
	// 		C.mob.remove_item(E)
	// 		found = 1
	// 		qdel(E)

	// 	if (!found)
	// 		boutput(C.mob, "You need to be holding a [sacrifice_name] in order to claim this reward.")
	// 		//Remove used from list of claimed. I'll make this more elegant once I understand it all. No time for it now. -Kyle
	// 		src.claimedNumbers[usr.key] --
	// 		return

	// 	var/obj/item/gun/energy/lawbringer/LG = new reward_path()
	// 	var/obj/item/paper/lawbringer_pamphlet/LGP = new/obj/item/paper/lawbringer_pamphlet()
	// 	if (!istype(LG))
	// 		boutput(C.mob, "Something terribly went wrong. The reward path got screwed up somehow. call 1-800-CODER. But you're an HoS! You don't need no stinkin' guns anyway!")
	// 		src.claimedNumbers[usr.key] --
	// 		return
	// 	//Don't let em get get a charged power cell for a spent one. Spend the difference
	// 	SEND_SIGNAL(LG, COMSIG_CELL_USE, max_charge - charge)

	// 	LG.set_loc(get_turf(C.mob))
	// 	C.mob.put_in_hand(LG)
	// 	boutput(C.mob, "Your E-Gun vanishes and is replaced with [LG]!")
	// 	LG.assign_name(C.mob)
	// 	C.mob.put_in_hand_or_drop(LGP)
	// 	boutput(C.mob, SPAN_EMOTE("A pamphlet flutters out."))
	// 	return

/datum/equipment_set/proc/setup_job_equipment(datum/job/JOB)
	var/ears = src.select_item_from_job_slot(JOB.slot_ears)
	if (ispath(ears, /obj/item/device/radio/headset))
		src.headset = ears
	else
		src.slot_ears = ears

	var/belt = src.select_item_from_job_slot(JOB.slot_belt)
	if (ispath(belt, /obj/item/device/pda2))
		src.pda = belt
	else
		src.slot_belt = belt

	var/l_store = src.select_item_from_job_slot(JOB.slot_poc1)
	if (ispath(l_store, /obj/item/device/pda2))
		src.pda = l_store
	else
		src.slot_l_store = l_store

	var/r_store = src.select_item_from_job_slot(JOB.slot_poc2)
	if (ispath(r_store, /obj/item/device/pda2))
		src.pda = r_store
	else
		src.slot_r_store = r_store

	var/back = src.select_item_from_job_slot(JOB.slot_back)
	if (ispath(back, /obj/item/storage/backpack))
		src.backpack = back
	else
		src.slot_back = back

	// slot_card is not a list
	var/card = JOB.slot_card
	if (ispath(card, /obj/item/card/id) && JOB.spawn_id)
		src.slot_wear_id = card

	src.slot_head = src.select_item_from_job_slot(JOB.slot_head)
	src.slot_wear_mask = src.select_item_from_job_slot(JOB.slot_mask)
	src.slot_glasses = src.select_item_from_job_slot(JOB.slot_eyes)
	src.slot_gloves = src.select_item_from_job_slot(JOB.slot_glov)
	src.slot_shoes = src.select_item_from_job_slot(JOB.slot_foot)
	src.slot_wear_suit = src.select_item_from_job_slot(JOB.slot_suit)
	src.slot_w_uniform = src.select_item_from_job_slot(JOB.slot_jump)
	src.slot_l_hand = src.select_item_from_job_slot(JOB.slot_lhan)
	src.slot_r_hand = src.select_item_from_job_slot(JOB.slot_rhan)

	src.items_in_backpack = JOB.items_in_backpack
	src.items_in_belt = JOB.items_in_belt

	src.implants = JOB.receives_implants
	src.recieves_disk = JOB.receives_disk // has to be done later
	src.badge = JOB.receives_badge
	if (src.badge)
		if (length(src.slot_wear_suit) == 0)
			src.slot_wear_suit += src.badge
		else
			src.loose_items += src.badge

/datum/equipment_set/proc/select_item_from_job_slot(list/job_items)
	switch (length(job_items))
		if (0)
			return null
		if (1)
			return job_items[1]
		if (2 to INFINITY)
			return weighted_pick(job_items)

/datum/equipment_set/proc/spawn_id(datum/job/JOB, mob/M)
	#ifdef DEBUG_EVERYONE_GETS_CAPTAIN_ID
	JOB = new /datum/job/command/captain
	#endif
	if (!JOB || !JOB.spawn_id || !JOB.slot_card)
		return null

	var/obj/item/card/id/C = null
	C = new src.id_card(src)

	if (C)
		var/recorded_name = M.real_name
		if (M.traitHolder?.hasTrait("clericalerror"))
			recorded_name = replacetext(recorded_name, "a", "o")
			recorded_name = replacetext(recorded_name, "e", "i")
			recorded_name = replacetext(recorded_name, "u", pick("a", "e"))
			if(prob(50)) recorded_name = replacetext(recorded_name, "n", "m")
			if(prob(50)) recorded_name = replacetext(recorded_name, "t", pick("d", "k"))
			if(prob(50)) recorded_name = replacetext(recorded_name, "p", pick("b", "t"))

			var/datum/db_record/B = FindBankAccountByName(M.real_name)
			if (B?["name"])
				B["name"] = recorded_name

			C.registered = recorded_name
			C.assignment = JOB.name
			C.name = "[C.registered]'s ID Card ([C.assignment])"
			C.access = JOB.access.Copy()
			C.pronouns = M.get_pronouns()

/datum/equipment_set/proc/spawn_credits(datum/job/JOB, mob/M)
	if (JOB.wages > 0)
		var/cash_mult = 1
		if (M.traitHolder?.hasTrait("pawnstar"))
			cash_mult = 1.25

		var/obj/item/currency/spacecash/starting_credits = new
		starting_credits.setup(M, round(JOB.wages * cash_mult))
		src.loose_items += starting_credits
	else
		var/random_shit = rand(1,3)
		switch(random_shit)
			if(1)
				src.loose_items += /obj/item/pen
			if(2)
				src.loose_items += /obj/item/reagent_containers/food/drinks/water

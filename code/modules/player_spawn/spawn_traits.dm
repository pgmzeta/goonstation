/datum/equipment_set
	var/list/trait_ids = list()

/datum/equipment_set/proc/setup_trait_equipment(mob/living/carbon/human/H)
	if (!H.traitHolder) return
	if (H.traitHolder.hasTrait("allergic"))
		src.loose_items += /obj/item/reagent_containers/emergency_injector/epinephrine
	if (H.traitHolder.hasTrait("allears"))
		src.slot_ears = null
	if (H.traitHolder.hasTrait("smoker"))
		src.loose_items += /obj/item/device/light/zippo

	src.setup_trait_trinket_equipment(H)
	src.setup_trait_background_equipment(H)
	src.setup_trait_body_equipment(H)
	src.setup_trait_vision_equipment(H)

/datum/equipment_set/proc/setup_trait_trinket_equipment(mob/living/carbon/human/H)
	if (H.traitHolder.hasTrait("pawnstar"))
		src.trinket = null
	else if (H.traitHolder.hasTrait("bald"))
		src.trinket = H.create_wig()
	else if (H.traitHolder.hasTrait("loyalist"))
		src.trinket = /obj/item/clothing/head/NTberet
	else if (H.traitHolder.hasTrait("petasusaphilic"))
		src.trinket = pick(filtered_concrete_typesof(/obj/item/clothing/head, /proc/filter_trait_hats))
	else if (H.traitHolder.hasTrait("conspiracytheorist"))
		src.trinket = /obj/item/clothing/head/tinfoil_hat
	else if (H.traitHolder.hasTrait("beestfriend"))
		if (prob(15))
			src.trinket = /obj/item/reagent_containers/food/snacks/ingredient/egg/bee/buddy
		else
			src.trinket = /obj/item/reagent_containers/food/snacks/ingredient/egg/bee
	else if (H.traitHolder.hasTrait("petperson"))
		src.trinket = /obj/item/pet_carrier/with_pet
	else if (H.traitHolder.hasTrait("lunchbox"))
		src.trinket = /obj/item/storage/lunchbox
	else if (H.traitHolder.hasTrait("wheelchair"))
		src.trinket = /obj/stool/chair/comfy/wheelchair
	else
		src.trinket = pick(global.trinket_safelist)

	if (ispath(trinket, /obj/item/clothing/head))
		src.loose_items += src.slot_head
		src.slot_head = src.trinket
	else if (ispath(trinket, /obj/item))
		src.loose_items += src.trinket
	else
		src.spawn_on_turf += src.trinket

/datum/equipment_set/proc/setup_trait_vision_equipment(mob/living/carbon/human/H)
	var/given_glasses = null

	if (H.traitHolder.hasTrait("blind"))
		given_glasses = /obj/item/clothing/glasses/visor
	else if (H.traitHolder.hasTrait("shortsighted"))
		given_glasses = /obj/item/clothing/glasses/regular
	else // if you're blind and have missing eyes, you don't get a cool patch sorry
		var/missing_left = H.traitHolder.hasTrait("eye_missing_left")
		var/missing_right =  H.traitHolder.hasTrait("eye_missing_right")
		if (missing_left && missing_right)
			given_glasses = /obj/item/clothing/glasses/blindfold
		else if (missing_right)
			given_glasses = /obj/item/clothing/glasses/eyepatch
		else if (missing_left)
			given_glasses = /obj/item/clothing/glasses/eyepatch/left

	if (given_glasses)
		src.loose_items += src.slot_glasses
		src.slot_glasses = given_glasses

/datum/equipment_set/proc/setup_trait_body_equipment(mob/living/carbon/human/H)
	if (H.traitHolder.hasTrait("deaf"))
		src.loose_items += src.slot_ears
		src.slot_ears = /obj/item/device/radio/headset/deaf
	if (H.traitHolder.hasTrait("plasmalungs"))
		src.bonus_tank_size = TANK_SIZE_MINI
		src.bonus_tank_contents = TANK_CONTENTS_PLASMA

/datum/equipment_set/proc/setup_trait_background_equipment(mob/living/carbon/human/H)
	if (H.traitHolder.hasTrait("pilot"))
		src.bonus_tank_size = TANK_SIZE_MINI
		src.loose_items += src.slot_wear_suit
		src.loose_items += src.slot_head
		#ifdef UNDERWATER_MAP
		src.slot_wear_suit = /obj/item/clothing/suit/space/diving/civilian
		src.slot_head = /obj/item/clothing/head/helmet/space/engineer/diving/civilian
		#else
		src.slot_wear_suit = /obj/item/clothing/suit/space/emerg
		src.slot_head = /obj/item/clothing/head/emerg
		#endif
		src.loose_items += /obj/item/device/gps
		src.pda = null
	else if (H.traitHolder.hasTrait("stowaway"))
		src.id_card = null

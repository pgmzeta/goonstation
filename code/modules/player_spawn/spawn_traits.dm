/datum/equipment_set
	var/list/trait_ids = list()

/datum/equipment_set/proc/setup_trait_equipment(mob/M)
	if (!M.traitHolder) return
	if (M.traitHolder.hasTrait("allergic"))
		src.loose_items += /obj/item/reagent_containers/emergency_injector/epinephrine
	if (M.traitHolder.hasTrait("allears"))
		src.slot_ears = null
	if (M.traitHolder.hasTrait("smoker"))
		src.loose_items += /obj/item/device/light/zippo

	src.setup_trait_trinket_equipment()
	src.setup_trait_background_equipment()
	src.setup_trait_body_equipment()
	src.setup_trait_vision_equipment()

/datum/equipment_set/proc/setup_trait_trinket_equipment(mob/M)
	if (M.traitHolder.hasTrait("pawnstar"))
		src.trinket = null
	else if (M.traitHolder.hasTrait("bald"))
		src.trinket = /obj/item/clothing/head/wig // TODO: Make wig subtype that wigs your current hair on spawn
	else if (M.traitHolder.hasTrait("loyalist"))
		src.trinket = /obj/item/clothing/head/NTberet
	else if (M.traitHolder.hasTrait("petasusaphilic"))
		src.trinket = pick(filtered_concrete_typesof(/obj/item/clothing/head, /proc/filter_trait_hats))
	else if (M.traitHolder.hasTrait("conspiracytheorist"))
		src.trinket = /obj/item/clothing/head/tinfoil_hat
	else if (M.traitHolder.hasTrait("beestfriend"))
		if (prob(15))
			src.trinket = /obj/item/reagent_containers/food/snacks/ingredient/egg/bee/buddy
		else
			src.trinket = /obj/item/reagent_containers/food/snacks/ingredient/egg/bee
	else if (M.traitHolder.hasTrait("petperson"))
		src.trinket = /obj/item/pet_carrier // TODO; pet carrier subtype that spawns a pet within itself
	else if (M.traitHolder.hasTrait("lunchbox"))
		src.trinket = /obj/item/storage/lunchbox
	else if (M.traitHolder.hasTrait("wheelchair"))
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

/datum/equipment_set/proc/setup_trait_vision_equipment(mob/M)
	var/given_glasses = null

	if (M.traitHolder.hasTrait("blind"))
		given_glasses = /obj/item/clothing/glasses/visor
	else if (M.traitHolder.hasTrait("shortsighted"))
		given_glasses = /obj/item/clothing/glasses/regular
	else // if you're blind and have missing eyes, you don't get a cool patch sorry
		var/missing_left = M.traitHolder.hasTrait("eye_missing_left")
		var/missing_right =  M.traitHolder.hasTrait("eye_missing_right")
		if (missing_left && missing_right)
			given_glasses = /obj/item/clothing/glasses/blindfold
		else if (missing_right)
			given_glasses = /obj/item/clothing/glasses/eyepatch
		else if (missing_left)
			given_glasses = /obj/item/clothing/glasses/eyepatch/left

	if (given_glasses)
		src.loose_items += src.slot_glasses
		src.slot_glasses = given_glasses

/datum/equipment_set/proc/setup_trait_body_equipment(mob/M)
	if (M.traitHolder.hasTrait("deaf"))
		src.loose_items += src.slot_ears
		src.slot_ears = /obj/item/device/radio/headset/deaf
	if (M.traitHolder.hasTrait("plasmalungs"))
		src.bonus_tank_size = TANK_SIZE_MINI
		src.bonus_tank_contents = TANK_CONTENTS_PLASMA

/datum/equipment_set/proc/setup_trait_background_equipment(mob/M)
	if (M.traitHolder.hasTrait("pilot"))
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
	else if (M.traitHolder.hasTrait("stowaway"))
		src.id_card = null

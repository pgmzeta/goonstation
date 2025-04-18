#define TANK_SIZE_NONE "none"
#define TANK_SIZE_POCKET "pocket"
#define TANK_SIZE_EXTENDED "extended"
#define TANK_SIZE_MINI "mini"
#define TANK_SIZE_NORMAL "normal"

#define TANK_CONTENTS_OXYGEN "oxygen"
#define TANK_CONTENTS_PLASMA "plasma"
#define TANK_CONTENTS_AIR "air"
#define TANK_CONTENTS_EMPTY "empty"

// antagonist type -> job type -> chosen traits -> persistent bank purchase -> mutantrace type -> antagonist equipment

/datum/player_spawn
	var/location
	var/datum/equipment_set/equipment

/datum/equipment_set
	/// Starting PDA, if one exists
	var/obj/item/device/pda2/pda
	/// Starting ID card, if one exists
	var/obj/item/card/id/id_card
	/// Starting headset, if one exists
	var/obj/item/device/radio/headset/headset
	/// Starting backpack, if one exists
	var/obj/item/storage/backpack/backpack
	/// Starting trinket, if one exists
	var/obj/trinket
	/// List of implants to implant
	var/implants = list()
	/// Typepath of badge to give
	var/obj/item/clothing/suit/security_badge/badge = null
	/// Whether the person recieves a clone disk
	var/recieves_disk = FALSE

	/// Size of the bonus breathing tank. TANK_SIZE_NONE will not give them a bonus tank
	var/bonus_tank_size = TANK_SIZE_NONE
	/// Atmos content of the breathing tank
	var/bonus_tank_contents = TANK_CONTENTS_OXYGEN

	var/obj/item/clothing/slot_wear_mask
	var/obj/item/clothing/slot_belt
	var/obj/item/clothing/slot_glasses
	var/obj/item/clothing/slot_gloves
	var/obj/item/clothing/slot_shoes
	var/obj/item/clothing/slot_head
	var/obj/item/clothing/slot_wear_suit
	var/obj/item/clothing/slot_w_uniform
	var/obj/item/clothing/ears/slot_ears

	var/obj/item/slot_l_store
	var/obj/item/slot_r_store

	var/obj/item/slot_wear_id
	var/obj/item/slot_back

	var/obj/item/slot_l_hand
	var/obj/item/slot_r_hand

	/// Items that need to be given to the person, somewhere
	var/list/obj/item/loose_items = list()

	/// Things we spawn on the same turf as ourselves
	var/list/spawn_on_turf = list()

	var/list/items_in_backpack = list()
	var/list/items_in_belt = list()

/// Place the player's PDA in an open spot, or in their ID slot if nothing else
/datum/equipment_set/proc/equip_pda()
	if (!src.pda)
		return
	if (isnull(src.slot_belt))
		src.slot_belt = src.pda
	else if (isnull(src.slot_l_store))
		src.slot_l_store = src.pda
	else if (isnull(src.slot_r_store))
		src.slot_r_store = src.pda
	else if (isnull(src.slot_wear_id))
		src.slot_wear_id = src.pda
	else
		if (!isnull(src.id_card))
			src.pda.ID_card = src.id_card

/// Find out what tank typepath to give the player
/datum/equipment_set/proc/get_tank_typepath()
	switch (src.bonus_tank_size)
		if (TANK_SIZE_NONE)
			return null
		if (TANK_SIZE_POCKET)
			switch (src.bonus_tank_contents)
				if (TANK_CONTENTS_OXYGEN)
					return /obj/item/tank/emergency_oxygen
				if (TANK_CONTENTS_PLASMA) // TODO: plasma pocket tank
					return /obj/item/tank/emergency_oxygen/extended/plasma
				if (TANK_CONTENTS_AIR) // TODO: air pocket tank
					return /obj/item/tank/emergency_oxygen
				if (TANK_CONTENTS_EMPTY) // TODO: empty pocket tank
					return /obj/item/tank/emergency_oxygen
		if (TANK_SIZE_EXTENDED)
			switch (src.bonus_tank_contents)
				if (TANK_CONTENTS_OXYGEN)
					return /obj/item/tank/emergency_oxygen/extended
				if (TANK_CONTENTS_PLASMA)
					return /obj/item/tank/emergency_oxygen/extended/plasma
				if (TANK_CONTENTS_AIR) // TODO: air extended tank
					return /obj/item/tank/emergency_oxygen/extended
				if (TANK_CONTENTS_EMPTY)
					return /obj/item/tank/emergency_oxygen/extended/empty
		if (TANK_SIZE_MINI)
			switch (src.bonus_tank_contents)
				if (TANK_CONTENTS_OXYGEN)
					return /obj/item/tank/mini_oxygen
				if (TANK_CONTENTS_PLASMA)
					return /obj/item/tank/mini_plasma
				if (TANK_CONTENTS_AIR)
					return /obj/item/tank/mini_oxygen
				if (TANK_CONTENTS_EMPTY)
					return /obj/item/tank/mini_oxygen/empty
		if (TANK_SIZE_NORMAL)
			switch (src.bonus_tank_contents)
				if (TANK_CONTENTS_OXYGEN)
					return /obj/item/tank/oxygen
				if (TANK_CONTENTS_PLASMA)
					return /obj/item/tank/plasma
				if (TANK_CONTENTS_AIR)
					return /obj/item/tank/air
				if (TANK_CONTENTS_EMPTY)
					return /obj/item/tank/empty




/datum/equipment_set/proc/equip_mob(mob/living/carbon/human/H)
	var/obj/item/tank/bonus_tank = get_tank_typepath()
	if (!isnull(bonus_tank))
		; // TODO: tank repathing :/


	if(src.slot_w_uniform)
		H.equip_new_if_possible(src.slot_w_uniform, SLOT_W_UNIFORM)
	if(src.slot_wear_mask)
		H.equip_new_if_possible(src.slot_wear_mask, SLOT_WEAR_MASK)
	if(src.slot_back)
		H.equip_new_if_possible(src.slot_back, SLOT_BACK)
	if(src.slot_glasses)
		H.equip_new_if_possible(src.slot_glasses, SLOT_GLASSES)
	if(src.slot_gloves)
		H.equip_new_if_possible(src.slot_gloves, SLOT_GLOVES)
	if(src.slot_shoes)
		H.equip_new_if_possible(src.slot_shoes, SLOT_SHOES)
	if(src.slot_head)
		H.equip_new_if_possible(src.slot_head, SLOT_HEAD)
	if(src.slot_wear_suit)
		H.equip_new_if_possible(src.slot_wear_suit, SLOT_WEAR_SUIT)
	if(src.slot_ears)
		H.equip_new_if_possible(src.slot_ears, SLOT_EARS)

	if(src.slot_l_store)
		H.equip_new_if_possible(src.slot_l_store, SLOT_L_STORE)
	if(src.slot_r_store)
		H.equip_new_if_possible(src.slot_r_store, SLOT_R_STORE)
	if(src.slot_wear_id)
		H.equip_new_if_possible(src.slot_wear_id, SLOT_WEAR_ID)
	if(src.slot_belt)
		H.equip_new_if_possible(src.slot_belt, SLOT_BELT)
	if(src.slot_l_hand)
		H.equip_new_if_possible(src.slot_l_hand, SLOT_L_HAND)
	if(src.slot_r_hand)
		H.equip_new_if_possible(src.slot_r_hand, SLOT_R_HAND)

	for(var/obj/item in src.loose_items)

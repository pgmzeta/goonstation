#define TANK_SIZE_POCKET "pocket"
#define TANK_SIZE_EXTENDED "extended"
#define TANK_SIZE_MINI "mini"
#define TANK_SIZE_NORMAL "normal"

#define TANK_CONTENTS_OXYGEN "oxygen"
#define TANK_CONTENTS_PLASMA "plasma"
#define TANK_CONTENTS_AIR "air"
#define TANK_CONTENTS_EMPTY "empty"

/datum/starting_equipment
	/// Starting PDA
	var/obj/item/device/pda2/pda
	/// Starting ID card
	var/obj/item/card/id/id
	/// Starting headset
	var/obj/item/device/radio/headset/headset
	/// Starting backpack
	var/obj/item/storage/backpack/backpack
	/// Starting uniform
	var/obj/item/clothing/under/uniform

	var/tank_size = TANK_SIZE_POCKET
	var/tank_contents = TANK_CONTENTS_OXYGEN

	var/list/slot_back = list()
	var/list/slot_wear_mask = list()
	var/list/slot_l_hand = list()
	var/list/slot_r_hand = list()
	var/list/slot_belt = list()
	var/list/slot_wear_id = list()
	var/list/slot_ears = list()
	var/list/slot_glasses = list()
	var/list/slot_gloves = list()
	var/list/slot_shoes = list()
	var/list/slot_head = list()
	var/list/slot_wear_suit = list()
	var/list/slot_w_uniform = list()
	var/list/slot_l_store = list()
	var/list/slot_r_store = list()
	var/list/items_in_backpack = list()
	var/list/items_in_belt = list()

/datum/starting_equipment/proc/equip_mob(mob/living/carbon/human/H)
	;


/// Find out where to place the player's PDA
/datum/starting_equipment/proc/target_pda_location()
	if (!length(slot_belt))
		return SLOT_BELT
	if (!length(slot_l_store))
		return SLOT_L_STORE
	if (!length(slot_r_store))
		return SLOT_R_STORE
	return SLOT_WEAR_ID

/// Find out what tank typepath to give the player
/datum/starting_equipment/proc/get_tank_typepath(tank_size, contents_type)
	switch(contents_type)
		if (TANK_CONTENTS_OXYGEN)
			switch(tank_size)
				if (TANK_SIZE_POCKET)
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED)
					return /obj/item/tank/emergency_oxygen/extended
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_oxygen
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/oxygen

		if (TANK_CONTENTS_PLASMA)
			switch(tank_size)
				if (TANK_SIZE_POCKET) // not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED)
					return /obj/item/tank/emergency_oxygen/extended/plasma
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_plasma
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/plasma

		if (TANK_CONTENTS_AIR)
			switch(tank_size)
				if (TANK_SIZE_POCKET) // not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED) // not exist
					return /obj/item/tank/emergency_oxygen/extended
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_oxygen
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/air

		if (TANK_CONTENTS_EMPTY)
			switch(tank_size)
				if (TANK_SIZE_POCKET) // not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED)
					return /obj/item/tank/emergency_oxygen/extended/empty
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_oxygen/empty
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/empty

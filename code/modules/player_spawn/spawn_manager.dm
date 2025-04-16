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
	/// Starting PDA
	var/obj/item/device/pda2/pda
	/// Starting ID card
	var/obj/item/card/id/id_card
	/// Starting headset
	var/obj/item/device/radio/headset/headset
	/// Starting backpack
	var/obj/item/storage/backpack/backpack
	/// Starting trinket
	var/obj/trinket

	var/bonus_tank_size = TANK_SIZE_NONE
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
	var/list/loose_items = list()

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
/datum/equipment_set/proc/get_tank_typepath(tank_size, contents_type)
	if (tank_size == TANK_SIZE_NONE)
		return null
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
				if (TANK_SIZE_POCKET) // does not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED)
					return /obj/item/tank/emergency_oxygen/extended/plasma
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_plasma
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/plasma

		if (TANK_CONTENTS_AIR)
			switch(tank_size)
				if (TANK_SIZE_POCKET) // does not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED) // does not exist
					return /obj/item/tank/emergency_oxygen/extended
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_oxygen
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/air

		if (TANK_CONTENTS_EMPTY)
			switch(tank_size)
				if (TANK_SIZE_POCKET) // does not exist
					return /obj/item/tank/emergency_oxygen
				if (TANK_SIZE_EXTENDED)
					return /obj/item/tank/emergency_oxygen/extended/empty
				if (TANK_SIZE_MINI)
					return /obj/item/tank/mini_oxygen/empty
				if (TANK_SIZE_NORMAL)
					return /obj/item/tank/empty

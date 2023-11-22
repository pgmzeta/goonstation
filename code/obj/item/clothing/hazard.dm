// Hazard Gear - full-body suits and matching hoods for specific hazards

/obj/item/clothing/suit/hazard
	icon = 'icons/obj/clothing/overcoats/item_suit_hazard.dmi'
	wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit_hazard.dmi'
	inhand_image_icon = 'icons/mob/inhand/overcoat/hand_suit_hazard.dmi'
	body_parts_covered = TORSO|LEGS|ARMS
	hides_from_examine = C_UNIFORM|C_GLOVES|C_SHOES
	///If defined, transform into this item when body armor is applied
	var/armored_variant = null

/obj/item/clothing/suit/hazard/attackby(obj/item/W, mob/user)
	if(isnull(src.armored_variant))
		return
	var/turf/T = user.loc
	boutput(user, SPAN_NOTICE("You attach [W] to [src]."))
	new armored_variant(T)
	qdel(W)
	qdel(src)

/obj/item/clothing/head/hazard
	c_flags = COVERSEYES | COVERSMOUTH | BLOCKCHOKE
	hides_from_examine = C_EARS
	seal_hair = 1


// Biological

/obj/item/clothing/suit/hazard/biological
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon_state = "bio_suit"
	item_state = "bio_suit"
	armored_variant = /obj/item/clothing/suit/hazard/biological/armored

	setupProperties()
		..()
		setProperty("coldprot", 15)
		setProperty("heatprot", 15)
		setProperty("viralprot", 50)
		setProperty("chemprot", 60)
		setProperty("meleeprot", 2)
		setProperty("rangedprot", 0.5)
		setProperty("movespeed", 0.3)
		setProperty("disorient_resist", 15)

/obj/item/clothing/suit/hazard/biological/janitor
	name = "bio suit"
	desc = "A suit that protects against biological contamination. This one has purple boots."
	icon_state = "biosuit_jani"
	item_state = "biosuit_jani"

/obj/item/clothing/suit/hazard/biological/beekeeper
	name = "apiculturist's suit"
	desc = "A suit that protects against bees. Not space bees, but like the tiny, regular kind. This thing doesn't do <i>shit</i> to protect you from space bees."

/obj/item/clothing/suit/hazard/biological/armored
	name = "armored bio suit"
	desc = "A suit that protects against biological contamination. Somebody slapped some bulky armor onto the chest."
	icon_state = "armorbio"
	item_state = "armorbio"
	armored_variant = null

	setupProperties()
		..()
		setProperty("meleeprot", 5)
		setProperty("rangedprot", 1)
		setProperty("movespeed", 0.45)

/obj/item/clothing/suit/hazard/biological/armored/nt
	name = "\improper NT bio suit"
	desc = "An armored biosuit that protects against biological contamination and toolboxes."
	icon_state = "ntbio"
	item_state = "ntbio"

	setupProperties()
		..()
		setProperty("meleeprot", 5)
		setProperty("rangedprot", 1)
		delProperty("movespeed")

/obj/item/clothing/head/hazard/biological
	name = "bio hood"
	desc = "This hood protects you from harmful biological contaminants."
	icon_state = "bio"
	item_state = "bio_hood"
	path_prot = 0

	setupProperties()
		..()
		setProperty("heatprot", 10)
		setProperty("viralprot", 50)
		setProperty("chemprot", 30)
		setProperty("meleeprot_head", 1)
		setProperty("disorient_resist_eye", 5)
		setProperty("disorient_resist_ear", 2)
		setProperty("movespeed", 0.1)

/obj/item/clothing/head/hazard/biological/janitor
	name = "bio hood"
	desc = "This hood protects you from harmful biological contaminants. This one has a blue visor."
	icon_state = "bio_jani"
	item_state = "bio_jani"

/obj/item/clothing/head/hazard/biological/nt
	name = "NT bio hood"
	icon_state = "ntbiohood"

	setupProperties()
		..()
		setProperty("meleeprot_head", 2)

/obj/item/clothing/head/hazard/biological/beekeeper
	name = "apiculturist's hood"
	desc = "This hood has a special mesh on it to keep bees from your eyes and other face stuff."
	icon_state = "beekeeper"
	item_state = "beekeeper"


// Paramedic

/obj/item/clothing/suit/hazard/paramedic
	name = "paramedic suit"
	desc = "A protective padded suit for emergency response personnel. Offers limited thermal and biological protection."
	icon_state = "paramedic"
	item_state = "paramedic"
	hides_from_examine = C_UNIFORM|C_SHOES
	protective_temperature = 3000
	armored_variant = /obj/item/clothing/suit/hazard/paramedic/armored
#ifdef MAP_OVERRIDE_NADIR
	c_flags = SPACEWEAR
	acid_survival_time = 5 MINUTES
#endif

	setupProperties()
		..()
		setProperty("coldprot", 25)
		setProperty("heatprot", 25)
		setProperty("viralprot", 50)
		setProperty("chemprot", 30)
		setProperty("meleeprot", 3)
		setProperty("rangedprot", 0.9)

/obj/item/clothing/suit/hazard/paramedic/armored
	name = "armored paramedic suit"
	desc = "A protective padded suit for emergency response personnel. Offers limited thermal and biological protection. Somebody slapped some armor onto the chest."
	icon_state = "para_armor"
	item_state = "paramedic"
	armored_variant = null

	setupProperties()
		..()
		setProperty("meleeprot", 5)
		setProperty("rangedprot", 1)

/obj/item/clothing/suit/hazard/paramedic/armored/para_sec
	icon_state = "para_sec"
	item_state = "para_sec"
	name = "rapid response armor"
	desc = "A protective padded suit for emergency reponse personnel. Tailored for ground operations, not vaccuum rated. This one bears security insignia."

/obj/item/clothing/suit/hazard/paramedic/armored/para_eng
	name = "rapid response armor"
	desc = "A protective padded suit for emergency response personnel. Tailored for ground operations, not vaccuum rated. This one bears engineering insignia."
	icon_state = "para_eng"
	item_state = "para_eng"


// Fire

/obj/item/clothing/suit/hazard/fire
	name = "firesuit"
	desc = "A suit that protects against fire and heat."
	icon = 'icons/obj/clothing/overcoats/item_suit_hazard.dmi'
	inhand_image_icon = 'icons/mob/inhand/overcoat/hand_suit_hazard.dmi'
	wear_image_icon = 'icons/mob/clothing/overcoats/worn_suit_hazard.dmi'
	icon_state = "fire"
	item_state = "fire_suit"
	hides_from_examine = C_UNIFORM|C_SHOES
	protective_temperature = 4500
	armored_variant = /obj/item/clothing/suit/hazard/fire/armored

	setupProperties()
		..()
		setProperty("coldprot", 20)
		setProperty("heatprot", 45)
		setProperty("chemprot", 10)
		setProperty("meleeprot", 3)
		setProperty("rangedprot", 0.5)
		setProperty("movespeed", 0.6)
		setProperty("disorient_resist", 15)

/obj/item/clothing/suit/hazard/fire/armored
	name = "armored firesuit"
	desc = "A suit that protects against fire and heat. Somebody slapped some bulky armor onto the chest."
	icon_state = "fire_armor"
	item_state = "fire_suit"
	armored_variant = null

	setupProperties()
		..()
		setProperty("meleeprot", 6)
		setProperty("rangedprot", 1)
		setProperty("movespeed", 1)

/obj/item/clothing/suit/hazard/fire/heavy
	name = "heavy firesuit"
	desc = "A suit that protects against extreme fire and heat."
	icon_state = "thermal"
	item_state = "thermal"
	hides_from_examine = C_UNIFORM|C_SHOES|C_GLOVES
	protective_temperature = 100000
	armored_variant = null

	setupProperties()
		..()
		setProperty("coldprot", 5)
		setProperty("heatprot", 65)
		setProperty("meleeprot", 4)
		setProperty("rangedprot", 0.8)
		setProperty("movespeed", 1.5)
		setProperty("disorient_resist", 25)

/obj/item/clothing/head/hazard/fire
	name = "firefighter helm"
	desc = "For fighting fires."
	c_flags = COVERSEYES | BLOCKCHOKE
	icon_state = "firefighter"
	item_state = "firefighter"
	protective_temperature = 500
	duration_remove = 5 SECONDS
	hides_from_examine = 0

	setupProperties()
		..()
		setProperty("meleeprot_head", 3)
		setProperty("coldprot", 5)
		setProperty("heatprot", 15)
		setProperty("disorient_resist_eye", 8)
		setProperty("disorient_resist_ear", 8)

/obj/item/clothing/suit/hazard/radiation
	name = "\improper Class II radiation suit"
	desc = "An old Soviet radiation suit made of 100% space asbestos. It's good for you!"
	icon_state = "rad"
	item_state = "rad"

	New()
		. = ..()
		AddComponent(/datum/component/wearertargeting/geiger, list(SLOT_WEAR_SUIT))

	setupProperties()
		..()
		setProperty("movespeed", 0.3)
		setProperty("radprot", 50)
		setProperty("coldprot", 15)
		setProperty("heatprot", 15)
		setProperty("chemprot", 25)
		setProperty("meleeprot", 3)
		setProperty("rangedprot", 0.5)
		setProperty("disorient_resist", 15)

/obj/item/clothing/head/hazard/radiation
	name = "Class II radiation hood"
	desc = "Asbestos, right near your face. Perfect!"
	icon_state = "radiation"

	setupProperties()
		..()
		setProperty("radprot", 50)
		setProperty("heatprot", 10)
		setProperty("meleeprot_head", 1)
		setProperty("chemprot", 10)
		setProperty("disorient_resist_eye", 12)
		setProperty("disorient_resist_ear", 8)
		setProperty("movespeed", 0.1)

/obj/item/clothing/suit/hazard/radiation/iomoon
	name = "FB-8 Environment Suit"
	desc = "A rather old-looking suit designed to guard against extreme heat and radiation."
	icon_state = "rad_io"
	item_state = "rad_io"
	protective_temperature = 7500

	setupProperties()
		..()
		setProperty("coldprot", 30)
		setProperty("heatprot", 95)

/obj/item/clothing/head/hazard/radiation/iomoon
	name = "FB-8 Environment Hood"
	desc = "The paired hood to the FB-8 environment suit. Not in the least stylish."
	icon_state = "radhood"
	item_state = "radhood"


// Chemical

/obj/item/clothing/suit/hazard/chemical
	name = "chemical protection suit"
	desc = "A bulky suit made from thick rubber. This should protect against most harmful chemicals."
	icon_state = "chem_suit"
	item_state = "chem_suit"

	setupProperties()
		..()
		setProperty("chemprot", 70)

/obj/item/clothing/head/hazard/chemical
	name = "chemical protection hood"
	desc = "A thick rubber hood which protects you from almost any harmful chemical substance."
	icon_state = "chemhood"
	item_state = "chemhood"
	c_flags = SPACEWEAR | COVERSEYES | COVERSMOUTH | BLOCKCHOKE
	hides_from_examine = C_EARS
	acid_survival_time = 8 MINUTES

	setupProperties()
		..()
		setProperty("chemprot", 40)
		setProperty("disorient_resist_eye", 6)
		setProperty("disorient_resist_ear", 5)

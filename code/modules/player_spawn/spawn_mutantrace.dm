/datum/equipment_set
	var/datum/mutantrace/mutantrace = /datum/mutantrace/human

/datum/equipment_set/proc/setup_mutantrace_equipment()
	if(ispath(src.mutantrace, /datum/mutantrace/skeleton))
		src.loose_items += /obj/item/joint_wax
	if(ispath(src.mutantrace, /datum/mutantrace/pug))
		src.loose_items += /obj/item/reagent_containers/food/snacks/cookie/dog

	if (!mutantrace::uses_human_clothes)
		if (!src.backpack && ispath(src.slot_belt, /obj/item/storage/fanny))
			src.backpack = /obj/item/storage/backpack

		if (src.slot_w_uniform && !src.mutantrace_compat_check(src.slot_w_uniform))
			src.slot_w_uniform = null
		if (src.slot_head && !src.mutantrace_compat_check(src.slot_head))
			src.slot_head = null
		if (src.slot_shoes && !src.mutantrace_compat_check(src.slot_shoes))
			src.slot_shoes = null
		if (src.slot_glasses && !src.mutantrace_compat_check(src.slot_glasses))
			src.slot_glasses = null
		if (src.slot_wear_suit && !src.mutantrace_compat_check(src.slot_wear_suit))
			src.slot_wear_suit = null

/datum/equipment_set/proc/mutantrace_compat_check(obj/item/clothing/clothing)
	if (clothing.compatible_species.Find(mutantrace.name) || mutantrace.uses_human_clothes && clothing.compatible_species.Find("human"))
		return TRUE
	return FALSE

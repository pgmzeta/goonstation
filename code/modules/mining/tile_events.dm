/datum/ore/event
	var/analysis_string = "Caution! Anomaly detected!"
	var/excavation_string = null
	var/distribution_range = 2
	var/nearby_tile_distribution_min = 0
	var/nearby_tile_distribution_max = 0
	var/scan_decal = null
	var/prevent_excavation = 0
	var/restrict_to_turf_type = null
	var/weight = 100

	set_up(var/datum/ore/event/parent_event)
		..()
		if (parent_event)
			if (!istype(parent_event, /datum/ore/))
				return 1
		return 0

/datum/ore/event/gem
	analysis_string = "Small extraneous mineral deposit detected."
	excavation_string = "Something shiny tumbles out of the collapsing rock!"
	scan_decal = "scan-gem"
	var/gem_type = /obj/item/raw_material/gemstone

	set_up(var/datum/ore/parent)
		if (..() || !parent)
			return 1
		if (parent.gems.len < 1)
			return 1
		gem_type = pick(parent.gems)

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		var/obj/item/I = new gem_type
		I.set_loc(AST)
		I.quality = AST.quality + rand(-50,50)
		I.name = "[getGemQualityName(I.quality)] [I.name]"

/datum/ore/event/gem/molitz_b
	analysis_string = "Small unusual crystalline deposit detected."
	excavation_string = "Something unusual tumbles out of the collapsing rock!"

	set_up(var/datum/ore/parent)
		if (..())
			return
		gem_type = /obj/item/raw_material/molitz_beta

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		var/quantity = rand(2,3)
		for(var/i in 1 to quantity)
			..()


/datum/ore/event/rock_worm
	analysis_string = "Caution! Life signs detected!"
	excavation_string = "A rock worm jumps out of the collapsing rock!"
	scan_decal = "scan-object"
	restrict_to_turf_type = /turf/simulated/wall/auto/asteroid

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		new /obj/critter/rockworm(AST)

/datum/ore/event/loot_crate
	analysis_string = "Caution! Large object embedded in rock!"
	excavation_string = "An abandoned crate was unearthed!"
	scan_decal = "scan-object"
	weight = 10

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		new /obj/storage/crate/loot(AST)

/datum/ore/event/artifact
	analysis_string = "Caution! Large object embedded in rock!"
	excavation_string = "An artifact was unearthed!"
	scan_decal = "scan-object"

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		Artifact_Spawn(AST)

/datum/ore/event/soft_rock
	analysis_string = "Caution! Weak rock formation detected!"
	hardness_mod = -1
	distribution_range = 4
	nearby_tile_distribution_min = 4
	nearby_tile_distribution_max = 12
	scan_decal = "scan-soft"

	onGenerate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		AST.hardness += hardness_mod

/datum/ore/event/hard_rock
	analysis_string = "Caution! Dense rock formation detected!"
	hardness_mod = 1
	distribution_range = 4
	nearby_tile_distribution_min = 4
	nearby_tile_distribution_max = 12
	scan_decal = "scan-hard"

	onGenerate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		AST.hardness += hardness_mod
		AST.amount += rand(1,3)

/datum/ore/event/volatile
	analysis_string = "Danger! Volatile compounds detected!"
	scan_decal = "scan-danger"
	prevent_excavation = 1
	restrict_to_turf_type = /turf/simulated/wall/auto/asteroid
	var/image/warning_overlay = null

	New()
		..()
		warning_overlay = image('icons/turf/walls_asteroid.dmi', "unstable")
		warning_overlay.layer = ASTEROID_MINING_SCAN_DECAL_LAYER

	onHit(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		AST.UpdateOverlays(warning_overlay, "warning")
		var/timer = rand(3,6) * 10
		SPAWN(timer)
			if (istype(AST)) //Wire note: Fix for Undefined variable /turf/simulated/floor/plating/airless/asteroid/var/invincible
				AST.invincible = 0
				explosion(AST, AST, 1, 2, 3, 4, 1)

/datum/ore/event/radioactive
	analysis_string = "Danger! Radioactive mineral deposits detected!"
	nearby_tile_distribution_min = 4
	nearby_tile_distribution_max = 8
	scan_decal = "scan-danger"
	restrict_to_turf_type = /turf/simulated/wall/auto/asteroid

	onHit(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		for (var/mob/living/L in range(1,AST))
			L.take_radiation_dose(0.05 SIEVERTS)

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		for (var/mob/living/L in range(1,AST))
			L.take_radiation_dose(0.1 SIEVERTS)

/datum/ore/event/nanites
	analysis_string = "Danger! Suspended nano-lifeforms detected!"
	scan_decal = "scan-danger"
	restrict_to_turf_type = /turf/simulated/wall/auto/asteroid
	weight = 10
	var/image/warning_overlay = null

	New()
		..()
		warning_overlay = image('icons/turf/walls_asteroid.dmi', "nanite cluster1")
		warning_overlay.layer = ASTEROID_MINING_SCAN_DECAL_LAYER

	onGenerate(var/turf/simulated/wall/auto/asteroid/AST)
		if (..())
			return
		AST.UpdateOverlays(warning_overlay, "warning")

	onExcavate(var/turf/simulated/wall/auto/asteroid/AST)
		if (!AST)
			return 1
		var/obj/critter/ancient_repairbot/N = new/obj/critter/gunbot/drone/buzzdrone/naniteswarm(AST)
		var/obj/item/I = new /obj/item/material_piece/cloth/carbon
		N.set_loc(AST)
		I.set_loc(AST)

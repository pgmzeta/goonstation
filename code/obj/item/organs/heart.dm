/*=========================*/
/*----------Heart----------*/
/*=========================*/

#define HEART_REAGENT_CAP 330
#define HEART_WRING_AMOUNT src.reagents.maximum_volume * 0.25
/obj/item/organ/heart
	name = "heart"
	organ_name = "heart"
	desc = "Offal, just offal."
	organ_holder_name = "heart"
	organ_holder_location = "chest"
	icon = 'icons/obj/items/organs/heart.dmi'
	icon_state = "heart"
	item_state = "heart"
	surgery_flags = SURGERY_SNIPPING | SURGERY_SAWING | SURGERY_CUTTING
	region = RIBS
	// var/broken = 0		//Might still want this. As like a "dead organ var", maybe not needed at all tho?
	var/list/diseases = null
	var/body_image = null // don't have time to completely refactor this, but, what name does the heart icon have in human.dmi?
	var/transplant_XP = 5
	var/blood_id = "blood"
	var/squeeze_sound = 'sound/impact_sounds/Slimy_Splat_1.ogg'

	New(loc, datum/organHolder/nholder)
		. = ..()
		reagents = new/datum/reagents(HEART_REAGENT_CAP)

#undef HEART_REAGENT_CAP

	disposing()
		if (holder)
			holder.heart = null
		..()

	attack_self(mob/user)
		..()
		if (!src.reagents)
			return
		if (!src.reagents.total_volume)
			boutput(user, SPAN_ALERT("There's nothing in \the [src] to wring out!"))
			return

		if (!ON_COOLDOWN(src, "heart_wring", 2 SECONDS))
			playsound(user, squeeze_sound, 30, TRUE)
			logTheThing(LOG_CHEMISTRY, user, "wrings out [src] containing [log_reagents(src)] at [log_loc(user)].")
			src.reagents.trans_to(get_turf(src), HEART_WRING_AMOUNT)
			boutput(user, SPAN_NOTICE("You wring out \the [src]."))

#undef HEART_WRING_AMOUNT

	on_transplant(var/mob/M as mob)
		..()
		if (src.donor.reagents && src.reagents)
			src.reagents.trans_to(src.donor, src.reagents.total_volume)

		if (src.robotic)
			if (src.emagged)
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STAMINA_REGEN_BONUS, "heart", 15)
				src.donor.add_stam_mod_max("heart", 90)
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST, "heart", 30)
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST_MAX, "heart", 30)
			else
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STAMINA_REGEN_BONUS, "heart", 5)
				src.donor.add_stam_mod_max("heart", 40)
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST, "heart", 15)
				APPLY_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST_MAX, "heart", 15)

		if (src.donor)
			for (var/datum/ailment_data/disease in src.donor.ailments)
				if (disease.cure_flags & CURE_HEART_TRANSPLANT)
					src.donor.cure_disease(disease)
			src.donor.blood_id = (ischangeling(src.donor) && src.blood_id == "blood") ? "bloodc" : src.blood_id
		if (ishuman(M) && islist(src.diseases))
			var/mob/living/carbon/human/H = M
			for (var/datum/ailment_data/AD in src.diseases)
				H.contract_disease(null, null, AD, 1)
				src.diseases.Remove(AD)
			return

	on_removal()
		if (donor)
			if (src.donor.reagents && src.reagents)
				src.donor.reagents.trans_to(src, src.reagents.maximum_volume - src.reagents.total_volume)

			if (!ischangeling(donor) && !donor.nodamage)
				donor.changeStatus("knockdown", 8 SECONDS)
				donor.losebreath += 20
				donor.take_oxygen_deprivation(20)

			src.blood_id = src.donor.blood_id //keep our owner's blood (for mutantraces etc)

			if (src.robotic)
				REMOVE_ATOM_PROPERTY(src.donor, PROP_MOB_STAMINA_REGEN_BONUS, "heart")
				src.donor.remove_stam_mod_max("heart")
				REMOVE_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST, "heart")
				REMOVE_ATOM_PROPERTY(src.donor, PROP_MOB_STUN_RESIST_MAX, "heart")

			var/datum/ailment_data/malady/HD = donor.find_ailment_by_type(/datum/ailment/malady/heartdisease)
			if (HD)
				if (!islist(src.diseases))
					src.diseases = list()
				HD.master.on_remove(donor,HD)
				donor.ailments.Remove(HD)
				HD.affected_mob = null
				src.diseases.Add(HD)
		..()
		return

/obj/item/organ/heart/synth
	name = "synthheart"
	desc = "I guess you could call this a... hearti-choke"
	synthetic = 1
	item_state = "plant"
	transplant_XP = 6
	squeeze_sound = 'sound/items/rubberduck.ogg'

	New()
		..()
		src.icon_state = pick("plant_heart", "plant_heart_bloom")

TYPEINFO(/obj/item/organ/heart/cyber)
	mats = 8

/obj/item/organ/heart/cyber
	name = "cyberheart"
	desc = "A cybernetic heart. Is this thing really medical-grade?"
	icon_state = "heart_robo1"
	item_state = "heart_robo1"
	//created_decal = /obj/decal/cleanable/oil
	edible = 0
	robotic = 1
	created_decal = /obj/decal/cleanable/oil
	default_material = "pharosium"
	transplant_XP = 7
	squeeze_sound = 'sound/voice/screams/Robot_Scream_2.ogg'

	emp_act()
		..()
		if (src.emagged)
			boutput(donor, SPAN_ALERT("<B>Your cyberheart malfunctions and shuts down!</B>"))
			donor.contract_disease(/datum/ailment/malady/flatline,null,null,1)

/obj/item/organ/heart/flock
	name = "pulsing octahedron"
	desc = "It beats ceaselessly to a peculiar rhythm. Like it's trying to tap out a distress signal."
	icon_state = "flockdrone_heart"
	item_state = "flockdrone_heart"
	body_image = "heart_flock"
	created_decal = /obj/decal/cleanable/flockdrone_debris/fluid
	default_material = "gnesis"
	var/resources = 0 // reagents for humans go in heart, resources for flockdrone go in heart, now, not the brain
	var/flockjuice_limit = 20 // pump flockjuice into the human host forever, but only a small bit
	var/min_blood_amount = 450
	squeeze_sound = 'sound/misc/flockmind/flockdrone_grump2.ogg'
	blood_id = "flockdrone_fluid"

	on_transplant(var/mob/M as mob)
		..()
		if (ishuman(M))
			M:blood_color = "#4d736d"
			// there is no undo for this. wear the stain of your weird alien blood, pal
	//was do_process
	on_life()
		var/mob/living/M = src.holder.donor
		if(!M || !ishuman(M)) // flockdrones shouldn't have these problems
			return
		var/mob/living/carbon/human/H = M
		// handle flockjuice addition and capping
		if(H.reagents)
			var/datum/reagents/R = H.reagents
			var/flockjuice = R.get_reagent_amount("flockdrone_fluid")
			if(flockjuice <= 0)
				R.add_reagent("flockdrone_fluid", 10)
			if(flockjuice > flockjuice_limit)
				R.remove_reagent("flockdrone_fluid", flockjuice - flockjuice_limit)
			// handle blood synthesis
			if(H.blood_volume < min_blood_amount)
				// consume flockjuice, convert into blood
				var/converted_amt = min(flockjuice, min_blood_amount - H.blood_volume)
				R.remove_reagent("flockdrone_fluid", converted_amt)
				H.blood_volume += converted_amt

/obj/item/organ/heart/flock/special_desc(dist, mob/user)
	if (!isflockmob(user))
		return
	return {"[SPAN_FLOCKSAY("[SPAN_BOLD("###=- Ident confirmed, data packet received.")]<br>\
		[SPAN_BOLD("ID:")] Resource repository<br>\
		[SPAN_BOLD("System Integrity:")] [src.resources]<br>\
		[SPAN_BOLD("###=-")]")]"}

/// Special heart that spews bloodc into you until you get taken over. Replacement for the headspider disease.
/obj/item/organ/heart/headspider
	name = "squirming heartspider"
	desc = "It's so unsettling, you're not even sure this is real." // should never be seen, but...
	created_decal = /obj/decal/cleanable/blood/changeling
	default_material = "flesh"
	blood_id = "bloodc"
	var/mob/living/critter/changeling/headspider/source = null
	/// Current amount of `bloodc` in host
	var/ling_blood = 0
	/// Maximum amount of `bloodc` in host that we've seen
	var/ling_blood_max = 0
	/// `TIME` we infested the host
	var/infection_start
	/// Have we shown the level1 message
	var/level1_message = FALSE
	/// Have we shown the level2 message
	var/level2_message = FALSE
	/// Have we shown the level3 message
	var/level3_message = FALSE
	/// Have we shown the level4 message
	var/level4_message = FALSE
	/// Have we shown the level5 message
	var/level5_message = FALSE

	New(loc, datum/organHolder/nholder)
		. = ..()

	disposing()
		if (src.source.changeling)
			src.source.death()
		. = ..()

	on_transplant(mob/M)
		. = ..()
		src.infection_start = TIME

	on_removal()
		. = ..()
		src.visible_message(SPAN_ALERT("<B>[src] boils and bursts open violently!</B>"))
		bloodboil(20, get_turf(src))
		if (source)
			source.gib()
		qdel(src)

	on_life(mult)
		. = ..()
		if (!ismind(source?.mind))
			return
		var/mob/living/M = src.holder.donor
		if(!M || !ishuman(M))
			return // TODO: what happens when polymorphed or turned into a cat? Die? Eject? Take over the lesser being's mind?
		var/mob/living/carbon/human/H = M
		if (isdead(H))
			src.takeover_host(src.holder.donor)
			setalive(H)
			H.stabilize()
		if(H.reagents)
			var/datum/reagents/R = H.reagents
			src.ling_blood = R.get_reagent_amount("bloodc")

			boutput(src.source, "HEARTSPIDER DEBUG: [ling_blood]/220 blood for takeover ([ling_blood/220*100]%)")

			switch(src.ling_blood)
				if(0 to 50)
					if (!src.level1_message && src.ling_blood > src.ling_blood_max)
						boutput(src.source, SPAN_ALERT("We begin diffusing throughout the body."))
						boutput(src.holder.donor, SPAN_ALERT("Your heart skips a beat. Or was that two beats?"))
						src.level1_message = TRUE
					else if(probmult(1))
						src.limb_effect()
				if(50 to 100)
					if (!src.level2_message && src.ling_blood > src.ling_blood_max)
						boutput(src.source, SPAN_ALERT("Our reach extends and embeds."))
						boutput(src.holder.donor, SPAN_ALERT("Your chest feels both tight and loose."))
						src.level2_message = TRUE
					else if(probmult(2))
						src.limb_effect()
				if(100 to 150)
					if (!src.level3_message && src.ling_blood > src.ling_blood_max)
						boutput(src.source, SPAN_ALERT("We embed into the limbs."))
						boutput(src.holder.donor, SPAN_ALERT("Your arms and legs feel like they have minds of their own."))
						src.level3_message = TRUE
					else if(probmult(3))
						src.limb_effect()
				if(150 to 200)
					if (!src.level4_message && src.ling_blood > src.ling_blood_max)
						boutput(src.source, SPAN_ALERT("Our tendrils spread up the spine."))
						boutput(src.holder.donor, SPAN_ALERT("You're overcome with a sense of disassociation."))
						src.level4_message = TRUE
					else if(probmult(5))
						src.limb_effect()
				if(200 to 220)
					if (!src.level5_message && src.ling_blood > src.ling_blood_max)
						boutput(src.source, SPAN_ALERT("We entwine the brainstem."))
						boutput(src.holder.donor, SPAN_ALERT("You feel your consciousness fading..."))
						src.level5_message = TRUE
					else if(probmult(8))
						src.limb_effect()
				if(220 to INFINITY)
					src.takeover_host(H)

			src.ling_blood_max = max(src.ling_blood_max, src.ling_blood)

			var/volume_left = R.maximum_volume - R.total_volume
			var/timeeee = TIME
			var/denominator = 30 SECONDS
			var/blood_to_add = (timeeee - src.infection_start) / denominator // increases by one unit every 30 seconds
			if (volume_left < blood_to_add)
				R.remove_any_except(blood_to_add-volume_left, "bloodc")
			R.add_reagent("bloodc", blood_to_add)

	proc/limb_effect()
		. = null
		if (!ishuman(src.holder.donor))
			return
		var/mob/living/carbon/human/H = src.holder.donor
		var/list/obj/item/parts/possible_limbs = list()
		if (H.limbs.l_arm)
			possible_limbs += H.limbs.l_arm
		if (H.limbs.r_arm)
			possible_limbs += H.limbs.r_arm
		if (H.limbs.l_leg)
			possible_limbs += H.limbs.l_leg
		if (H.limbs.r_leg)
			possible_limbs += H.limbs.r_leg
		if (!length(possible_limbs))
			return

		var/obj/item/parts/target_limb = pick(possible_limbs)
		// deliberately a shadow of "funky_limb" bioeffect
		if (isarm(target_limb))
			switch(rand(1, 4))
				if (1)
					H.visible_message(SPAN_ALERT("[H.name]'s [target_limb] makes a [pick("rude", "funny", "weird", "strange", "offensive", "cruel", "furious")] gesture!"))
				if (2)
					H.emote("slap")
				if (3)
					H.visible_message(SPAN_ALERT("<B>[H.name]'s [target_limb] punches [him_or_her(H)] in the face!</B>"))
					H.changeStatus("knockdown", 5 SECONDS)
					H.TakeDamageAccountArmor("head", rand(2,5), 0, 0, DAMAGE_BLUNT)
				if (4)
					H.visible_message(SPAN_ALERT("[H.name]'s [target_limb] tries to strangle [him_or_her(H)]!"))
					while (TRUE)
						H.losebreath = max(H.losebreath, 2)
						sleep(1 SECOND)
					H.visible_message(SPAN_ALERT("[H.name]'s [target_limb] stops trying to strangle [him_or_her(H)]."))
		else if (isleg(target_limb))
			switch(rand(1, 4))
				if (1)
					H.visible_message(SPAN_ALERT("[H.name]'s [target_limb] twitches [pick("rudely", "awkwardly", "weirdly", "strangely", "offensively", "cruelly", "furiously")]!"))
				if (2)
					H.visible_message(SPAN_ALERT("<B>[H.name] trips over [his_or_her(H)] own [target_limb]!</B>"))
					H.changeStatus("knockdown", 2 SECONDS)
				if (3)
					H.visible_message(SPAN_ALERT("<B>[H.name]'s [target_limb] kicks [him_or_her(H)] in the head somehow!</B>"))
					H.changeStatus("unconscious", 7 SECONDS)
					H.TakeDamageAccountArmor("head", rand(5,10), 0, 0, DAMAGE_BLUNT)
				if (4)
					H.visible_message(SPAN_ALERT("<B>[H.name] can't seem to control [his_or_her(H)] [target_limb]!</B>"))
					H.change_misstep_chance(10)

	relaymove(mob/user, direction, delay, running)
		. = ..()
		if (!ishuman(src.holder.donor))
			return
		if (prob(src.ling_blood/8.8)) // slowly take control 0-25%
			var/mob/M = src.holder.donor
			var/turf/T = get_turf(get_step(M, direction))
			M.step_towards_movedelay(T)

	proc/takeover_host(mob/affected_mob)
		boutput(world, "HEARTSPIDER DEBUG: Infection end (took [time_to_text(TIME-src.infection_start)])")
		if(!source.changeling)
			//if the headspider doesn't have a changeling, we create one
			src.source.mind.add_antagonist(ROLE_CHANGELING, TRUE, FALSE, FALSE, TRUE, ANTAGONIST_SOURCE_SUMMONED, FALSE, FALSE, FALSE)
			var/datum/antagonist/changeling/antag_datum = src.source.mind.get_antagonist(ROLE_CHANGELING)
			src.source.changeling = antag_datum.ability_holder
			logTheThing(LOG_COMBAT, src.source.mind, "became a changeling by infecting [affected_mob] as [src.source].")
		// Absorb their DNA. Copies identities and DNA points automatically if victim was another changeling. This also inserts them into the hivemind.
		// Remove changeling AH (if any) and copy our own.
		if (ischangeling(affected_mob))
			src.source.show_text("[affected_mob] was a changeling! We have incorporated their entire genetic structure.", "blue")
			affected_mob.remove_ability_holder(/datum/abilityHolder/changeling)

		//transfer mind first
		var/datum/mind/M = affected_mob.mind

		src.source.changeling.addDna(affected_mob, TRUE)
		if (affected_mob.mind && affected_mob.mind != src.source.changeling.owner.mind)
			logTheThing(LOG_DEBUG, src, "headspider somehow failed to transfer victim [key_name(affected_mob)]'s mind properly, panicking and ghosting them because it's better than ghosting the ling [src.source.changeling.owner] (screm) (fuck) (hepl).")
			affected_mob.ghostize()
		src.source.mind.transfer_to(affected_mob)

		affected_mob.add_existing_ability_holder(src.source.changeling)
		affected_mob.ensure_speech_tree().AddSpeechOutput(SPEECH_OUTPUT_HIVECHAT_MEMBER, subchannel = "\ref[src.source.changeling]")
		affected_mob.ensure_listen_tree().AddListenInput(LISTEN_INPUT_HIVECHAT, subchannel = "\ref[src.source.changeling]")
		if (M)
			src.source.changeling.insert_into_hivemind(M.current) //aaa aaa aaaaaaaahhhhhhhhhhhhh

		src.source.changeling.reassign_hivemind_target_mob()

		src.source.changeling = null //so the spider doesn't have a ref to our holder as well
		affected_mob.change_misstep_chance(-INFINITY)
		affected_mob.show_text("<h3>We have assumed control of the new host.</h3>", "blue")
		logTheThing(LOG_COMBAT, affected_mob, "'s headspider successfully assumes control of new host at [log_loc(affected_mob)].")

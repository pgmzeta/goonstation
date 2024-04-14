var/datum/score_tracker/score_tracker

/datum/score_tracker
	// Nice to have somewhere to centralize this shit so w/e
	var/score_calculated = 0
	var/final_score_all = 0
	var/grade = "The Aristocrats!"
	var/inspector_report = ""
	// SECURITY DEPARTMENT
	// var/score_crew_evacuation_rate = 0 save this for later to keep categories balanced
	var/score_crew_survival_rate = 0
	var/score_enemy_failure_rate = 0
	var/final_score_sec = 0
	// ENGINEERING DEPARTMENT
	var/power_generated = 0
	var/score_power_outages = 0
	var/score_structural_damage = 0
	var/final_score_eng = 0
	// RESEARCH DEPARTMENT
	var/artifacts_analyzed = 0
	var/artifacts_correctly_analyzed = 0
	var/score_artifact_analysis = 0
	var/final_score_res = 0
	// CIVILIAN DEPARTMENT
	var/score_cleanliness = 0
	var/score_expenses = 0
	var/final_score_civ = 0
	var/most_xp = "OH NO THIS IS BROKEN"
	var/score_text = null
	var/tickets_text = null
	var/mob/richest_escapee = null
	var/richest_total = 0
	var/mob/most_damaged_escapee = null
	var/acula_blood = null
	var/beepsky_alive = null
	var/clown_beatings = null
	var/list/pets_escaped = null
	var/list/command_pets_escaped = null


	proc/calculate_score()
		if (score_calculated != 0)
			return
		// Even if its the end of the round it'd probably be nice to just calculate this once and let players grab that
		// instead of calculating it again every time a player wants to look at the score

		inspector_report = get_inspector_report()

		// SECURITY DEPARTMENT SECTION
		var/crew_count = 0
		var/fatalities = 0
		var/traitor_objectives = 0
		var/traitor_objectives_failed = 0

		for (var/datum/mind/M in ticker.minds)
			if (M.current && istype(M.current,/mob/dead/observer/))
				var/mob/dead/observer/O = M.current
				if (O.observe_round)
					continue
			if (M in ticker.mode.traitors) // if you're an antag, you're not considered crew
				continue

			crew_count++ // good job you're one of the crew, get counted upon

			if (!M.current || (M.current && isdead(M.current))) // DEAD
				fatalities++

		for (var/datum/mind/traitor in ticker.mode.traitors)
			for (var/datum/objective/objective in traitor.objectives)
				traitor_objectives++
#ifdef CREW_OBJECTIVES
				if (istype(objective, /datum/objective/crew)) continue
#endif
				if (!objective.check_completion())
					traitor_objectives_failed++

		// special case - if there were no antags for w/e reason you get a free pass i guess?
		if (traitor_objectives == 0)
			score_enemy_failure_rate = 100
		else
			score_enemy_failure_rate = get_percentage_of_fraction_and_whole(traitor_objectives_failed,traitor_objectives)

		score_crew_survival_rate = 100 - get_percentage_of_fraction_and_whole(fatalities,crew_count)

		score_crew_survival_rate = clamp(score_crew_survival_rate,0,100)
		score_enemy_failure_rate = clamp(score_enemy_failure_rate,0,100)

		final_score_sec = (score_crew_survival_rate + score_enemy_failure_rate) * 0.5

		// ENGINEERING DEPARTMENT SECTION
		// also civ cleanliness counted here cos fuck calling a world loop more than once
		var/apc_count = 0
		var/apcs_powered = 0
		var/num_station_areas = 0
		var/undamaged_areas = 0
		var/clean_areas = 0

		//checking power levels
		for (var/obj/machinery/power/apc/A in machine_registry[MACHINES_POWER])
			if (!istype(A.area,/area/station/))
				continue
			apc_count++
			for (var/obj/item/cell/C in A.contents)
				if (get_percentage_of_fraction_and_whole(C.charge,C.maxcharge) >= 85)
					apcs_powered++
			//LAGCHECK(LAG_LOW)

		//checking mess
		for(var/area/station/AR in world)
			var/cleanliness = AR.calculate_area_cleanliness()
			if(cleanliness == -1) // no sim. turfs
				continue
			num_station_areas++
			if (get_percentage_of_fraction_and_whole(AR.calculate_structure_value(),AR.initial_structure_value) >= 50)
				undamaged_areas++
			if (cleanliness >= 80)
				clean_areas++
			//LAGCHECK(LAG_LOW)

		score_power_outages = get_percentage_of_fraction_and_whole(apcs_powered,apc_count)

		if (istype(ticker?.mode, /datum/game_mode/nuclear)) //Since the nuke doesn't actually blow up in time
			var/datum/game_mode/nuclear/N = ticker.mode
			if (N.nuke_detonated)
				score_structural_damage = 0
			else
				score_structural_damage = get_percentage_of_fraction_and_whole(undamaged_areas,num_station_areas)
		else
			score_structural_damage = get_percentage_of_fraction_and_whole(undamaged_areas,num_station_areas)

		score_power_outages = clamp(score_power_outages,0,100)
		score_structural_damage = clamp(score_structural_damage,0,100)

		for(var/time in station_power_generation)
			power_generated += station_power_generation[time]

		final_score_eng = (score_power_outages + score_structural_damage) * 0.5

		// RESEARCH DEPARTMENT SECTION
		for(var/obj/O in artifact_controls.artifacts)
			if(O.disposed)
				continue
			var/obj/item/sticker/postit/artifact_paper/pap = locate(/obj/item/sticker/postit/artifact_paper/) in O.vis_contents
			if(pap)
				artifacts_analyzed++
			if(pap?.lastAnalysis >= 3)
				artifacts_correctly_analyzed++
		if(artifacts_analyzed)
			score_artifact_analysis = (artifacts_correctly_analyzed/artifacts_analyzed)*100

		final_score_res = score_artifact_analysis

		// CIVILIAN DEPARTMENT SECTION
		if (!istype(wagesystem))
			// something glitched out and broke so give them a free pass on it
			score_expenses = 100
		else
			var/profit_target = wagesystem.total_stipend
			var/totalfunds = wagesystem.station_budget + wagesystem.research_budget + wagesystem.shipping_budget
			if (totalfunds == 0)
				score_expenses = 0
			if (totalfunds != totalfunds) //let's see if someone sets the budget to -NaN!
				score_expenses = 100
			else
				score_expenses = get_percentage_of_fraction_and_whole(totalfunds,profit_target)

		score_cleanliness = get_percentage_of_fraction_and_whole(clean_areas,num_station_areas)

		score_expenses = clamp(score_expenses,0,100)
		score_cleanliness = clamp(score_cleanliness,0,100)
		final_score_civ = (score_expenses + score_cleanliness) * 0.5

		var/xp_winner = null
		var/curr_xp = 0
		for(var/x in xp_earned)
			if(xp_earned[x] > curr_xp)
				curr_xp = xp_earned[x]
				xp_winner = x

		if(xp_winner)
			most_xp = "[xp_winner]!"
		else
			most_xp = "No one. Dang."

		calculate_escape_stats()

		// AND THE WINNER IS.....

		var/department_score_sum = 0
		department_score_sum = final_score_sec + final_score_eng + final_score_civ + final_score_res

		if (department_score_sum == 0 || department_score_sum != department_score_sum) //check for 0 and for NaN values
			final_score_all = 0
		else
			final_score_all = round(department_score_sum / 4)

		switch(final_score_all)
			if (100 to INFINITY) grade = "NanoTrasen's Finest"
			if (90 to 99) grade = "The Pride of Science Itself"
			if (91 to 95) grade = "Ambassadors of Discovery"
			if (86 to 90) grade = "Missionaries of Science"
			if (81 to 85) grade = "Promotions for Everyone"
			if (76 to 80) grade = "An Excellent Pursuit of Progress"
			if (71 to 75) grade = "Lean Mean Machine Thirteen"
			if (66 to 70) grade = "Best of a Good Bunch"
			if (61 to 65) grade = "Worthy Citizens"
			if (56 to 60) grade = "Ambiguously Ambivalent"
			if (51 to 55) grade = "Not Bad, but Not Good"
			if (46 to 50) grade = "Ambivalently Average"
			if (41 to 45) grade = "Not Worthy of Praise"
			if (36 to 40) grade = "Extremely Unsatisfactory"
			if (31 to 35) grade = "A Bad Bunch"
			if (26 to 30) grade = "The Undesireables"
			if (21 to 25) grade = "Outclassed by Lab Monkeys"
			if (16 to 20) grade = "A Wretched Heap of Scum and Incompetence"
			if (11 to 15) grade = "A Waste of Perfectly Good Oxygen"
			if (06 to 10) grade = "You're All Fired"
			if (01 to 05) grade = "Engine Fodder"
			if (-INFINITY to 0) grade = "Even the Engine Deserves Better"
			else grade = "Somebody fucked something up."

		score_calculated = 1
		boutput(world, "<br><b>Final Rating: <font size='4'>[final_score_all]%</font></b>")
		boutput(world, "<b>Grade: <font size='4'>[grade]</font></b>")

		return

	/////////////////////////////////////
	/////////Escapee stuff///////////////
	/////////////////////////////////////
	proc/calculate_escape_stats()
		//set the global total to zero on proc start, just in cases.
		richest_total = 0
		//search mobs in centcom
		for (var/mob/M in mobs)
			if (!ishuman(M))
				continue
			if(in_centcom(M))
				if (!most_damaged_escapee)
					most_damaged_escapee = M
				else if (M.get_damage() < most_damaged_escapee.get_damage())
					most_damaged_escapee = M

				var/cash_total = get_cash_in_thing(M)
				var/bank_account = data_core.bank.find_record("name", M.real_name)
				var/bank_total = 0
				if(bank_account)
					bank_total = bank_account["current_money"]
				if (richest_total < (cash_total + bank_total))
					richest_total = cash_total + bank_total
					richest_escapee = M

		command_pets_escaped = list()
		pets_escaped = list()

		for (var/pet in by_cat[TR_CAT_PETS])
			if(iscritter(pet))
				var/obj/critter/P = pet
				if (in_centcom(P) && P.alive)
					if(P.is_pet == 2)
						command_pets_escaped += P
					else if(P.is_pet)
						pets_escaped += P
					if (istype(P, /obj/critter/bat/doctor))
						acula_blood = P:blood_volume //this only gets populated if Dr. Acula escapes
			else if(ismobcritter(pet))
				var/mob/living/critter/P = pet
				if (in_centcom(pet) && isalive(P))
					if(pet:is_pet == 2)
						command_pets_escaped += pet
					else if(pet:is_pet)
						pets_escaped += pet
			else if(istype(pet, /obj/item/rocko))
				if(in_centcom(pet))
					command_pets_escaped += pet

		if (length(by_type[/obj/machinery/bot/secbot/beepsky]))
			beepsky_alive = 1

		return

	proc/get_cash_in_thing(var/atom/A)
		. = 0
		if (istype(A, /obj/item/currency/spacecash))
			var/obj/item/currency/spacecash/SC = A
			. += SC.amount
		else if (istype(A, /obj/item/card/id))
			var/obj/item/card/id/ID = A
			. += ID.money
		else if (A.storage)
			for (var/obj/item/I as anything in A.storage.get_contents())
				. += get_cash_in_thing(I)
		else
			for (var/I in A)
				. += get_cash_in_thing(I)

	proc/heisenhat_stats()
		. = list()
		. += "<B>Heisenbee's hat:</B> "
		var/found_hb = 0
		var/tier = world.load_intra_round_value("heisenbee_tier")
		for(var/obj/critter/domestic_bee/heisenbee/HB in by_cat[TR_CAT_PETS])
			var/obj/item/hat = HB.original_hat
			if(hat && !hat.disposed)
				if(hat.loc != HB)
					var/atom/movable/L = hat.loc
					while(istype(L) && !istype(L, /mob))
						L = L.loc
					. += "[hat][inline_bicon(getFlatIcon(hat, no_anim=TRUE))](tier [HB.original_tier])"
					if(istype(L, /mob))
						. += " \[STOLEN BY [L]\]"
					else
						. += " \[STOLEN!\]"
					if(HB.hat)
						var/dead = HB.alive ? "" : "(dead) "
						. += "<BR>Also someone put [HB.hat] on [dead][HB][inline_bicon(getFlatIcon(HB, no_anim=TRUE))]but that doesn't count."
				else if(!HB.alive)
					. += "[hat][inline_bicon(getFlatIcon(HB, no_anim=TRUE))](tier [HB.original_tier])"
					. += " \[🐝 MURDERED!\]"
				else
					. += "[hat][inline_bicon(getFlatIcon(HB, no_anim=TRUE))](tier [HB.original_tier])"
			else if(HB.alive)
				if(hat)
					. += "[inline_bicon(getFlatIcon(hat, no_anim=TRUE))] \[DESTROYED!\]"
				else
					. += "No hat yet."
			else if(hat)
				. += "[inline_bicon(getFlatIcon(hat, no_anim=TRUE))] \[DESTROYED!\] \[🐝 MURDERED!\]"
			else
				. += "No hat yet. \[🐝 MURDERED!\]"
			found_hb = 1
			break
		if(!found_hb)
			if(tier)
				. += "Heisenbee is missing but the hat is safe at tier [tier]."
			else
				. += "Heisenbee is missing and has no hat."
		. += "<BR>"
		return jointext(., "")

	proc/escapee_facts()
		. = list()
		//Richest Escapee | Most Damaged Escapee | Dr. Acula Blood Total | Clown Beatings
		if (richest_escapee)		. += "<B>Richest Escapee:</B> [richest_escapee.real_name] : [richest_total][CREDIT_SIGN]<BR>"
		if (most_damaged_escapee) 	. += "<B>Most Damaged Escapee:</B> [most_damaged_escapee.real_name] : [most_damaged_escapee.get_damage()]%<BR>"		//it'll be kinda different from when it's calculated, but whatever.
		if (length(command_pets_escaped))
			var/list/who_escaped = list()
			for (var/atom/A in command_pets_escaped)
				who_escaped += "[A.name] [inline_bicon(getFlatIcon(A, no_anim=TRUE))]"
			. += "<B>Command Pets Escaped:</B> [who_escaped.Join(" ")]<BR><BR>"
		if (length(pets_escaped))
			var/list/who_escaped = list()
			for (var/atom/A in pets_escaped)
				who_escaped += "[A.name] [bicon(A)]"
			. += "<B>Other Pets Escaped:</B> [who_escaped.Join(" ")]<BR><BR>"

		if (acula_blood) 			. += "<B>Dr. Acula Blood Total:</B> [acula_blood]p<BR>"
		if (beepsky_alive) 			. += "<B>Beepsky?:</B> Yes<BR>"

		return jointext(., "")

	proc/get_inspector_report()
		. = list()
		for_by_tcl(clipboard, /obj/item/clipboard/with_pen/inspector)
			. += "<B>Inspector[clipboard.inspector_name ? " [clipboard.inspector_name]" : ""]'s report</B><BR><HR>"
			for(var/obj/item/paper/paper in clipboard.contents)
				//ignore blank untitled pages
				if (paper.name == "paper" && !paper.info)
					continue
				if (paper.name != "paper")
					. += "<B>[paper.name]</B>"
				. += paper.info ? paper.info : "<BR><BR>"
		return jointext(., "")

/mob/proc/show_inspector_report()
	if(!length(score_tracker.inspector_report)) return

	src.Browse(score_tracker.inspector_report, "window=tickes;size=500x650")

#define POD_BAR_HEALTH "health"
#define POD_BAR_FUEL "fuel"

/datum/hud/pod
	var/atom/movable/screen/hud
		engine
		life_support
		comms
		sensors
		sensors_use
		weapon
		secondary
		lock
		set_code
		rts
		wormhole
		use_comms
		leave
		rcs
		lights
		tracking
		sensor_lock

		fuel
		fuel_needle
		bottom_bar_bg
		bottom_bar_southwest
		bottom_bar_south
		bottom_bar_east
		// Only applies to the /tg/ hud.
		bottom_bar_west
		bottom_bar_southeast

	click_check = 0
	var/image/missing
	var/datum/healthBar/health_bar
	var/datum/healthBar/fuel_bar
	var/obj/machinery/vehicle/master

	var/icon/hud_icon = 'icons/mob/hud_pod.dmi'

	New(P)
		..()
		master = P

		// For the top bar.
		create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_bg", "NORTH+1, WEST to NORTH+1, WEST+13", HUD_LAYER)
		create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "NORTH, WEST to NORTH, WEST+13", HUD_LAYER, NORTH)
		create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "NORTH+1, WEST+14", HUD_LAYER, WEST)
		create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "NORTH, WEST+14", HUD_LAYER, NORTHWEST)
		// Beams.
		create_screen("", "", src.hud_icon, "beam", "NORTH+1, WEST+1 to NORTH+1, WEST+10", HUD_LAYER)
		create_screen("", "", src.hud_icon, "beam-l", "NORTH+1, WEST", HUD_LAYER)
		create_screen("", "", src.hud_icon, "beam-r", "NORTH+1, WEST+12", HUD_LAYER)

		// For the bottom bar.
		src.bottom_bar_bg = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_bg", "SOUTH, EAST", HUD_LAYER)
		src.bottom_bar_southwest = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "SOUTH+1, EAST-1", HUD_LAYER, SOUTHWEST)
		src.bottom_bar_south = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "to SOUTH+1, EAST", HUD_LAYER, SOUTH)
		src.bottom_bar_east = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "SOUTH, EAST-1", HUD_LAYER, EAST)

		engine = create_screen("engine", "Engine", 'icons/mob/hud_pod.dmi', "engine-off", "NORTH+1,WEST", tooltipTheme = "pod-alt", desc = "Turn the vehicle's engine on or off.")
		life_support = create_screen("life_support", "Life Support", 'icons/mob/hud_pod.dmi', "life_support-off", "NORTH+1,WEST+1", tooltipTheme = "pod-alt", desc = "Turn life support on or off")

		comms = create_screen("comms", "Comms", 'icons/mob/hud_pod.dmi', "comms-off", "NORTH+1,WEST+2", tooltipTheme = "pod-alt", desc = "Turn the pod's communications system on or off")
		use_comms = create_screen("comms_system", "Use Comms System", 'icons/mob/hud_pod.dmi', "comms_system", "NORTH+1,WEST+3", tooltipTheme = "pod", desc = "Use the communications system to talk or whatever")
		rts = create_screen("return_to_station", "Return To [capitalize(station_or_ship())]", 'icons/mob/hud_pod.dmi', "return-to-station", "NORTH+1,WEST+4", tooltipTheme = "pod", desc = "Using this will place you on the station Z-level the next time you fly off the edge of the current level")

		sensors = create_screen("sensors", "Sensors", 'icons/mob/hud_pod.dmi', "sensors-off", "NORTH+1,WEST+5", tooltipTheme = "pod-alt", desc = "Turn the pod's sensors on or off")
		sensors_use = create_screen("sensors_use", "Activate Sensors", 'icons/mob/hud_pod.dmi', "sensors_use", "NORTH+1,WEST+6", tooltipTheme = "pod", desc = "Use the pod's sensors to search for vehicles and lifeforms nearby")
		wormhole = create_screen("wormhole", "Create Wormhole", 'icons/mob/hud_pod.dmi', "wormhole", "NORTH+1,WEST+7", tooltipTheme = "pod", desc = "Open a wormhole to a beacon that you can fly through")

		weapon = create_screen("weapon", "Main Weapon", 'icons/mob/hud_pod.dmi', "weapon-off", "NORTH+1,WEST+8", tooltipTheme = "pod-alt", desc = "Turn the main weapon on or off, if the pod is equipped with one")
		lights = create_screen("lights", "Toggle Lights", 'icons/mob/hud_pod.dmi', "lights-off", "NORTH+1, WEST+9", tooltipTheme = "pod", desc = "Turn the pod's external lights on or off")
		secondary = create_screen("secondary", "Secondary System", 'icons/mob/hud_pod.dmi', "blank", "NORTH+1,WEST+10", tooltipTheme = "pod", desc = "Activate the secondary system installed in the pod, if there is one")
		lock = create_screen("lock", "Lock", 'icons/mob/hud_pod.dmi', "lock-locked", "NORTH+1,WEST+11", tooltipTheme = "pod-alt", desc = "Lock or unlock the pod.")
		set_code = create_screen("set_code", "Set Lock code", 'icons/mob/hud_pod.dmi', "set_code", "NORTH+1,WEST+12", tooltipTheme = "pod", desc = "Set the code used to unlock the pod")
		rcs = create_screen("rcs", "Toggle RCS", 'icons/mob/hud_pod.dmi', "rcs-off", "NORTH+1,WEST+13", tooltipTheme = "pod-alt", desc = "Reduce the pod's relative velocity")

		leave = create_screen("leave", "Leave Pod", 'icons/mob/hud_pod.dmi', "leave", "SOUTH,EAST", tooltipTheme = "pod-alt", desc = "Get out of the pod")

		tracking = create_screen("tracking", "Tracking Indicator", 'icons/mob/hud_pod.dmi', "off", "CENTER, CENTER")
		tracking.mouse_opacity = 0
		sensor_lock = create_screen("sensor_lock", "Sensor Lock", 'icons/mob/hud_pod.dmi', "blank", "SOUTH+1,EAST")
		sensor_lock.mouse_opacity = 0	//maybe set to one, so that clicking on it will explain what it is

		src.apply_button_overlay("text_leave", src.leave)

		health_bar = new /datum/healthBar(barLength=3, index_from_top=1, bar_name=POD_BAR_HEALTH)
		health_bar.add_to_hud(src)
		fuel_bar = new /datum/healthBar(barLength=3, index_from_top=2, bar_name=POD_BAR_FUEL)
		fuel_bar.add_to_hud(src)

		if (master)
			update_health()
			update_systems()
			update_states()
			update_fuel()

	clear_master()
		master = null
		..()

	proc/detach_all_clients()
		for (var/client/C in clients)
			remove_client(C)

			if (C.tooltipHolder)
				C.tooltipHolder.inPod = 0

	proc/check_clients()
		for (var/client/C in clients)
			var/mob/M = C.mob
			if (M.loc != master)
				remove_client(C)

				if (C.tooltipHolder)
					C.tooltipHolder.inPod = 0

	proc/check_hud_layout(mob/user)
		if (user.client.tg_layout)
			src.bottom_bar_bg.screen_loc = "SOUTH, EAST-5"
			src.bottom_bar_southwest.screen_loc = "SOUTH+1, EAST-6"
			src.bottom_bar_south.screen_loc = "SOUTH+1, EAST-5"
			src.bottom_bar_east.screen_loc = "SOUTH, EAST-6"

			src.bottom_bar_southeast = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "SOUTH+1, EAST-4", HUD_LAYER, SOUTHEAST)
			src.bottom_bar_west = create_screen("", "", 'icons/mob/hud_common.dmi', "hotbar_side", "SOUTH, EAST-4", HUD_LAYER, WEST)

			src.leave.screen_loc = "SOUTH, EAST-5"
		else
			src.bottom_bar_bg.screen_loc = "SOUTH, EAST"
			src.bottom_bar_southwest.screen_loc = "SOUTH+1, EAST-1"
			src.bottom_bar_south.screen_loc = "SOUTH+1, EAST"
			src.bottom_bar_east.screen_loc = "SOUTH, EAST-1"

			src.bottom_bar_southeast = null
			src.bottom_bar_west = null

			src.leave.screen_loc = "SOUTH, EAST"

	proc/update_health()
		check_clients()
		health_bar.update_health_overlay(master.health, master.maxhealth, 0, 0)

	proc/update_fuel()
		check_clients()
		if(istype(master.fueltank))
			fuel_bar.update_health_overlay(MIXTURE_PRESSURE(master.fueltank.air_contents), PORTABLE_ATMOS_MAX_RELEASE_PRESSURE, 0, 0)
		else
			fuel_bar.update_health_overlay(0, 100, 0, 0)

	proc/update_states()
		check_clients()
		if (master.engine)
			if (master.engine.active)
				engine.icon_state = "engine-on"
				src.apply_button_overlay("text_online-w", src.engine)
				src.apply_button_overlay("text_lights", src.lights)
				src.apply_button_overlay("text_brakes", src.rcs)
				if (master.rcs)
					src.rcs.icon_state = "toggle-on"
					src.apply_button_overlay("text_on", src.rcs)
					src.rcs.ClearSpecificOverlays("text_off")
				else
					src.rcs.icon_state = "toggle-off"
					src.apply_button_overlay("text_off", src.rcs)
					src.rcs.ClearSpecificOverlays("text_on")
			else
				engine.icon_state = "engine-off"
				src.engine.ClearAllOverlays()
				src.lights.icon_state = "toggle-nopower"
				src.lights.ClearAllOverlays()
				src.rcs.icon_state = "toggle-nopower"
				src.rcs.ClearAllOverlays()

		if (master.engine?.active && master.sensors?.active)
			src.wormhole.icon_state = "wormhole-on"
			src.apply_button_overlay("text_warp", src.wormhole)
		else
			src.wormhole.icon_state = "wormhole-off"
			src.wormhole.ClearAllOverlays()

		if (master.life_support)
			if (master.life_support.active)
				src.life_support.icon_state = "life_support-on"
				src.apply_button_overlay("text_online", src.life_support)
			else
				src.life_support.icon_state = "life_support-off"
				src.life_support.ClearAllOverlays()

		if (master.com_system)
			if (master.com_system.active)
				src.comms.icon_state = "comms-on"
				src.use_comms.icon_state = "comms_system"
				src.apply_button_overlay("text_online", src.comms)
				src.apply_button_overlay("text_comm", src.use_comms)
			else
				src.comms.icon_state = "comms-off"
				src.use_comms.icon_state = "comms_system-nopower"
				src.comms.ClearAllOverlays()
				src.use_comms.ClearAllOverlays()

		if (master.m_w_system)
			src.apply_button_overlay("text_weapons", src.weapon)
			if (master.m_w_system.active)
				src.weapon.icon_state = "weapon-on"
				src.apply_button_overlay("text_armed", src.weapon)
			else
				src.weapon.icon_state = "weapon-off"
				src.weapon.ClearSpecificOverlays("text_armed")

		if (master.sec_system)
			if (master.engine?.active)
				src.secondary.icon_state = master.sec_system.hud_state
				if (master.sec_system.f_active) // uses active toggle
					if (master.sec_system.active)
						src.apply_button_overlay("blank-overlay-on", src.secondary)
					else
						src.apply_button_overlay("blank-overlay-off", src.secondary)
				else
					src.apply_button_overlay("blank-overlay-use", src.secondary)
			else
				src.secondary.icon_state = "blank"
				src.secondary.ClearAllOverlays()
		else
			src.secondary.icon_state = "blank"
			src.secondary.ClearAllOverlays()

		if (master.sensors)
			if (master.sensors.active)
				src.sensors.icon_state = "sensors-on"
				src.apply_button_overlay("text_online", src.sensors)
				src.sensors_use.icon_state = "sensors_use"
				src.apply_button_overlay("sensors_use-overlay", src.sensors_use)
			else
				src.sensors.icon_state = "sensors-off"
				src.sensors.ClearSpecificOverlays("text_online")
				src.sensors_use.icon_state = "sensors_use-nopower"
				src.sensors_use.ClearSpecificOverlays("sensors_use-overlay")

		if (master.lock)
			if (master.lock.code && master.locked)
				src.lock.icon_state = "lock-locked"
				src.apply_button_overlay("text_locked", src.lock)
				src.lock.ClearSpecificOverlays("text_unlocked")
			else
				src.lock.icon_state = "lock-unlocked"
				src.apply_button_overlay("text_unlocked", src.lock)
				src.lock.ClearSpecificOverlays("text_locked")

		if (master.lights)
			if (master.engine?.active)
				src.apply_button_overlay("text_lights", src.lights)
				if (master.lights.active)
					src.lights.icon_state = "toggle-on"
					src.apply_button_overlay("text_on", src.lights)
					src.lights.ClearSpecificOverlays("text_off")
				else
					src.lights.icon_state = "toggle-off"
					src.apply_button_overlay("text_off", src.lights)
					src.lights.ClearSpecificOverlays("text_on")
			else
				src.lights.icon_state = "toggle-nopower"
				src.lights.ClearAllOverlays()

		// if (master.rcs)
		// 	rcs.icon_state = "rcs-on"
		// else
		// 	rcs.icon_state = "rcs-off"


	proc/update_systems()
		check_clients()
		if (master.engine)
			src.engine.name = master.engine.name
		else
			src.engine.name = "Engine"
			src.engine.icon_state = "engine-off"
			src.engine.ClearAllOverlays()

		if (master.com_system)
			src.comms.name = master.com_system.name
			if (!master.com_system.active)
				src.comms.icon_state = "comms-off"
				src.use_comms.icon_state = "comms_system-nopower"
				src.use_comms.ClearAllOverlays()
		else
			src.comms.name = "Comms"
			src.comms.icon_state = "comms-off"
			src.comms.ClearAllOverlays()
			src.use_comms.icon_state = "comms_system-nopower"
			src.use_comms.ClearAllOverlays()

		if (master.m_w_system)
			src.weapon.name = master.m_w_system.name
		else
			src.weapon.name = "Main Weapon"
			src.weapon.icon_state = "weapon-nopower"
			src.weapon.ClearAllOverlays()

		if (master.sec_system)
			src.secondary.name = master.sec_system.name
		else
			src.secondary.name = "Secondary System"
			src.secondary.icon_state = "secondary-off"
			src.secondary.ClearAllOverlays()

		if (master.sensors)
			src.sensors.name = master.sensors.name
			if (!master.sensors.active)
				src.sensors_use.icon_state = "sensors_use-nopower"
				src.sensors_use.ClearAllOverlays()
		else
			src.sensors.name = "Sensors"
			src.sensors.icon_state = "sensors-off"
			src.sensors.ClearAllOverlays()
			src.sensors_use.icon_state = "sensors_use-nopower"
			src.sensors_use.ClearAllOverlays()

		if (master.lock)
			src.lock.name = master.lock.name
			src.apply_button_overlay("text_lock", src.lock)
			src.set_code.icon_state = "set_code"
			src.apply_button_overlay("text_set_code", src.set_code)
			src.apply_button_overlay("text_code", src.set_code)
			if (master.locked)
				src.lock.icon_state = "lock-locked"
				src.apply_button_overlay("text_locked", src.lock)
				src.lock.ClearSpecificOverlays("text_unlocked")
			else
				src.lock.icon_state = "lock-unlocked"
				src.apply_button_overlay("text_unlocked", src.lock)
				src.lock.ClearSpecificOverlays("text_locked")
		else
			src.lock.name = "Lock"
			src.lock.icon_state = "lock-nopower"
			src.lock.ClearSpecificOverlays(list("text_lock", "text_locked", "text_unlocked"))
			src.set_code.icon_state = "set_code-nopower"
			src.set_code.ClearAllOverlays()

		if (master.lights)
			src.lights.name = master.lights.name
		else
			src.lights.name = "Lights"
			src.lights.icon_state = "toggle-nopower"

	proc/switch_sound()
		for (var/mob/M in src.master)
			M.playsound_local(src.master, 'sound/machines/pod_switch.ogg', 60, TRUE, ignore_flag = SOUND_IGNORE_SPACE)

	proc/apply_button_overlay(name, atom/movable/screen/target)
		if (!istext(name) || target.GetOverlayImage(name))
			return FALSE
		. = target.UpdateOverlays(image(src.hud_icon, "[name]"), name)

	relay_click(id, mob/user, list/params)
		if (user.loc != master)
			boutput(user, SPAN_ALERT("You're not in the pod doofus. (Call 1-800-CODER.)"))
			remove_client(user.client)

			if (user.client.tooltipHolder)
				user.client.tooltipHolder.inPod = 0

			return
		if (is_incapacitated(user))
			boutput(user, SPAN_ALERT("Not when you are incapacitated."))
			return
		// WHAT THE FUCK PAST MARQUESAS
		// GET IT TOGETHER
		// - Future Marquesas
		// switch ("id")
		switch (id)
			if ("engine")
				if (master.engine)
					if (user != master.pilot)
						boutput(user, SPAN_ALERT("Only the pilot may do that!"))
						return
					master.engine.toggle()
					src.switch_sound()
			if ("life_support")
				if (master.life_support)
					master.life_support.toggle()
					src.switch_sound()
			if ("comms")
				if (master.com_system)
					master.com_system.toggle()
					src.switch_sound()
					update_systems()
			if ("comms_system")
				if(master.com_system)
					if(master.com_system.active)
						master.com_system.External()
					else
						boutput(user, "[master.ship_message("SYSTEM OFFLINE")]")
				else
					boutput(user, "[master.ship_message("System not installed in ship!")]")
			if ("weapon")
				if (master.m_w_system)
					master.m_w_system.toggle()
					src.switch_sound()
			if ("secondary")
				if (master.sec_system)
					master.sec_system.toggle()
					src.switch_sound()
			if ("sensors")
				if (master.sensors)
					master.sensors.toggle()
					src.switch_sound()
			if ("sensors_use")
				if (master.sensors && master.sensors.active)
					master.sensors.opencomputer(user)
			if ("lock")
				if (master.lock)
					if (!master.lock.is_set())
						master.lock.configure_mode = 1
						if (master)
							master.locked = 0
						master.lock.code = ""
						master.lock.show_lock_panel(user)
					else if (!master.locked)
						master.locked = 1
						boutput(user, SPAN_ALERT("The lock mechanism clunks locked."))
					else if (master.locked)
						master.locked = 0
						boutput(user, SPAN_ALERT("The ship mechanism clicks unlocked."))
			if ("set_code")
				if (master.lock)
					if (master.lock.is_set())
						if (!master.lock.can_reset)
							boutput(user, SPAN_NOTICE("This lock cannot have its code reset."))
							return
						boutput(user, SPAN_NOTICE("Code reset. Please type new code and press enter."))
					master.lock.configure_mode = 1
					if (master)
						master.locked = 0
					master.lock.code = ""
					master.lock.show_lock_panel(user)
			if ("return_to_station")
				master.return_to_station()
			if ("leave")
				master.leave_pod(user)
			if ("wormhole") //HEY THIS DOES SAMETHING AS CLIENT WORMHOLE PROC IN VEHICLE.DM
				if(master.engine && !istype(master,/obj/machinery/vehicle/tank/car))
					if(master.engine.active)
						if(master.engine.ready)
							var/turf/T = master.loc
							if (istype(T) && T.allows_vehicles)
								master.engine.Wormhole()
							else
								boutput(user, "[master.ship_message("Cannot create wormhole on this flooring!")]")
						else
							boutput(user, "[master.ship_message("Engine recharging wormhole capabilities!")]")
					else
						boutput(user, "[master.ship_message("SYSTEM OFFLINE")]")
				else
					boutput(user, "[master.ship_message("System not installed in ship!")]")
			if ("lights")
				if (master.lights)
					master.lights.toggle()
					src.switch_sound()
			if ("rcs")
				master.rcs = !master.rcs
				src.switch_sound()


		update_states()

//for some reason this was in the removed pod colloseum code, moved it here since it's still in use
/datum/healthBar
	var/list/barBits = list()
	var/atom/movable/screen/bar_icon
	var/image/health_overlay

	New(barLength = 4, is_left = 0, index_from_top = 1, bar_name=POD_BAR_HEALTH)
		..()
		var/edge = is_left ? "WEST" : "EAST"
		var/top_offset = 1.75 - (index_from_top * 0.5)

		src.bar_icon = new /atom/movable/screen()
		src.bar_icon.layer = HUD_LAYER
		src.bar_icon.screen_loc = "NORTH+[top_offset+0.25],[edge]-[barLength-0.4]"
		src.bar_icon.icon = 'icons/ui/vehicle16x16.dmi'
		src.bar_icon.icon_state = bar_name

		for (var/i = 1, i <= barLength, i++)
			var/atom/movable/screen/S = new /atom/movable/screen()
			S.layer = HUD_LAYER
			S.name = bar_name
			S.icon = 'icons/obj/colosseum.dmi'
			if (i == 1)
				S.icon_state = "health_bar_left"
				var/sl = barLength - i
				S.screen_loc = "NORTH+[top_offset],[edge]-[sl]"
			else if (i == barLength)
				S.icon_state = "health_bar_right"
				S.screen_loc = "NORTH+[top_offset],[edge]"
			else
				S.icon_state = "health_bar_center"
				var/sl = barLength - i
				S.screen_loc = "NORTH+[top_offset],[edge]-[sl]"
			barBits += S
		health_overlay = image('icons/obj/colosseum.dmi', "health")

	proc/add_to_hud(var/datum/hud/H)
		H.add_object(src.bar_icon)
		for (var/atom/movable/screen/S in barBits)
			H.add_object(S)

	proc/add_to(var/mob/M)
		if (M.client)
			M.client.screen += src.bar_icon
			for (var/atom/movable/screen/S in barBits)
				M.client.screen += S

	proc/remove_from(var/mob/M)
		if (M.client)
			M.client.screen -= src.bar_icon
			for (var/atom/movable/screen/S in barBits)
				M.client.screen -= S

	proc/update_health_overlay(var/health_value, var/health_max, var/shield_value, var/shield_max)
		for (var/atom/movable/screen/S in barBits)
			S.overlays.len = 0
		add_overlay(health_value, health_max, 204, 0, 0, 0, 204, 0)
		if (shield_value > 0)
			add_overlay(shield_value, shield_max, 0, 255, 255, 0, 102, 102)
			add_counter(barBits.len, shield_value, "#000000")
			return
		if ((health_value/health_max) > 0.5)
			add_counter(barBits.len, health_value, "#000000")
		else
			add_counter(barBits.len, health_value, "#d9e8f2")

	proc/add_overlay(value, max_value, r0, g0, b0, r1, g1, b1)
		var/percentage = value / max_value
		var/remaining = round(percentage * 100)
		var/bars = length(barBits)
		var/eachBar = 100 / bars
		var/missingBars = 0
		health_overlay.color = rgb(lerp(r0, r1, percentage), lerp(g0, g1, percentage), lerp(b0, b1, percentage))
		while (100 - (missingBars * eachBar) >= remaining && missingBars <= bars)
			missingBars++
		missingBars--

		for (var/i = 1, i <= bars, i++)
			var/atom/movable/screen/S = barBits[i]
			if (i <= missingBars)
				continue
			else if (i == missingBars + 1)
				var/matrix/Mat = matrix()
				var/present = (bars - missingBars - 1) * eachBar
				var/mine = remaining - present
				var/scale = mine / eachBar
				var/move = 16 - (16 * scale)
				Mat.Scale(scale, 1)
				health_overlay.transform = Mat
				health_overlay.pixel_x = move + 1
				S.overlays += health_overlay
				health_overlay.transform = null
				health_overlay.pixel_x = 0
			else
				S.overlays += health_overlay

	proc/add_counter(var/bit, var/value, var/textcolor)
		var/atom/movable/screen/counter = barBits[bit]
		if (value < 0)
			counter.overlays += image('icons/obj/colosseum.dmi', "INF")
		else
			if (value > 999)
				value = 999
			if (value >= 100)
				var/R2 = round(value / 100)
				var/image/left = image('icons/obj/colosseum.dmi', "[R2]")
				left.color = textcolor
				left.pixel_x = -8
				counter.overlays += left
			if (value >= 10)
				var/R1 = round(value / 10) % 10
				var/image/center = image('icons/obj/colosseum.dmi', "[R1]")
				center.color = textcolor
				counter.overlays += center
			var/R0 = round(value % 10)
			var/image/right = image('icons/obj/colosseum.dmi', "[R0]")
			right.color = textcolor
			right.pixel_x = 8
			counter.overlays += right

#undef POD_BAR_HEALTH
#undef POD_BAR_FUEL

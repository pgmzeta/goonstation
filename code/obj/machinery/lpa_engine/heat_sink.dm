/obj/item/heat_sink
	/// Max health to set melt_health to on init
	_max_health = 100
	/// a
	var/temperature = T20C
	/// IS we melted
	var/melted = FALSE
	/// Essentially indicates how long this component can be at a dangerous temperature before it melts
	var/melt_health = 100
	/// The dangerous temperature above which this component starts to melt. 1700K is the melting point of steel
	var/melting_point = 1700 KELVIN
	/// Thermal mass. Basically how much energy it takes to heat this up 1Kelvin
	var/thermal_mass = 420*250//specific heat capacity of steel (420 J/KgK) * mass of component (Kg)

/obj/item/heat_sink/New(material="steel")
	..()
	if(istype(material, /datum/material))
		src.setMaterial(material)
	else
		src.setMaterial(getMaterial(material))
	melt_health = _max_health

/obj/item/heat_sink/proc/melt()
	if(src.melted)
		return
	src.melted = TRUE
	src.name = "melted "+src.name
	src.setMaterial(src.material, TRUE, FALSE, FALSE)
	var/obj/machinery/nuclear_reactor/parent = src.loc
	if(istype(parent))
		parent.MarkGridForUpdate()
		parent.UpdateIcon()

/obj/item/heat_sink/proc/processHeat()
	//heat transfer with magnetic endcap
	var/obj/machinery/nuclear_reactor/holder = src.loc
	if(istype(holder))
		var/deltaT = src.temperature - holder.temperature
		var/k = calculateHeatTransferCoefficient(holder.material,src.material)
		var/A = 100 // TODO: Math
		src.temperature = src.temperature - (k * A * (MACHINE_PROC_INTERVAL*8)/src.thermal_mass)*deltaT
		holder.temperature = holder.temperature - (k * A * (MACHINE_PROC_INTERVAL*8)/holder.thermal_mass)*-deltaT
		if(holder.temperature < 0 || src.temperature < 0)
			CRASH("TEMP WENT NEGATIVE")

		holder.material_trigger_on_temp(holder.temperature)
		src.material_trigger_on_temp(src.temperature)
		if((src.temperature > src.melting_point) && (src.melt_health > 0))
			src.melt_health -= rand(10,50)
		if(src.melt_health <= 0)
			src.melt() //oh no


/obj/item/heat_sink/proc/mob_holding_temp_react(mob/user, mult)
	if(src.temperature < T0C + 80)
		return FALSE
	if(ON_COOLDOWN(user, "reactor_comp_burn", 2 SECONDS))
		return

	if(user.equipped(src))
		var/obj/item/clothing/gloves/gloves
		if (ishuman(user))
			var/mob/living/carbon/human/H = user
			gloves = H.gloves
		else
			gloves = null
		if(!gloves || gloves.material?.getProperty("thermal") > 2)
			boutput(user, SPAN_ALERT("\The [src] burns your hand!"))
			user.TakeDamageAccountArmor(user.hand ? "l_arm" : "r_arm", 0, min((src.temperature-T0C)/20, 50) * mult, 0, DAMAGE_BURN)

	if(src.temperature > T0C + 400)
		boutput(user, SPAN_ALERT("<b>\The [src] sets you on fire with its extreme heat!</b>"))
		user.changeStatus("burning", 30 SECONDS)
	return TRUE

/obj/item/heat_sink/pickup(mob/user)
	. = ..()
	if(src.mob_holding_temp_react(user, 1))
		RegisterSignal(user, COMSIG_LIVING_LIFE_TICK, PROC_REF(mob_holding_temp_react))

/obj/item/heat_sink/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_LIFE_TICK)


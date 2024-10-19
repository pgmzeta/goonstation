TYPEINFO(/datum/component/burning)
	initialization_args = list(
		ARG_INFO("cleanable_remains", DATA_INPUT_TYPE, "Cleanable to spawn when burnt up.", BURN_REMAINS_ASH),
		ARG_INFO("fx_pixel_x_offset", DATA_INPUT_NUM, "Pixel X offset for effects", 0),
		ARG_INFO("fx_pixel_y_offset", DATA_INPUT_NUM, "Pixel Y offset for effects", 0),
	)


/// A component to handle object burning
/datum/component/burning
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// What cleanable to spawn if the object is burnt up.
	var/cleanable_remains = BURN_REMAINS_ASH

/datum/component/burning/Initialize(cleanable_remains=BURN_REMAINS_ASH, fx_pixel_x_offset = 0, fx_pixel_y_offset = 0)
	. = ..()
	if (!istype(src.parent, /obj))
		return COMPONENT_INCOMPATIBLE
	if (src in by_cat[TR_CAT_BURNING_ITEMS])
		return COMPONENT_NOTRANSFER
	var/obj/parent = src.parent
	src.cleanable_remains = cleanable_remains
	OTHER_START_TRACKING_CAT(src.parent, TR_CAT_BURNING_ITEMS)
	var/image/I = image('icons/effects/fire.dmi', null, "object_ignition", pixel_x = fx_pixel_x_offset, pixel_y = fx_pixel_y_offset)
	parent.UpdateOverlays(I, "object_ignition")
	parent.add_simple_light("object_ignition", list(255, 110, 135, 110))
	parent.simple_light.pixel_x = fx_pixel_x_offset
	parent.simple_light.pixel_y = fx_pixel_y_offset

/datum/component/burning/proc/process_burning()
	SHOULD_NOT_SLEEP(TRUE)
	var/obj/parent = src.parent
	if (prob(7))
		var/datum/effects/system/bad_smoke_spread/smoke = new /datum/effects/system/bad_smoke_spread()
		smoke.set_up(1, 0, parent.loc)
		smoke.attach(parent)
		smoke.start()

	if (prob(40))
		if (parent._health > 4)
			parent._health /= 2
		else
			parent._health -= 2

	if(parent._health <= 0)
		src.finish_burn()

/datum/component/burning/proc/finish_burn()
	OTHER_STOP_TRACKING_CAT(src.parent, TR_CAT_BURNING_ITEMS)
	var/obj/parent = src.parent
	parent.remove_simple_light("object_igntion")
	parent.ClearSpecificOverlays("object_igntion")
	if(src.cleanable_remains)
		make_cleanable(src.cleanable_remains, get_turf(src.parent))
	qdel(src.parent)

/datum/component/burning/disposing()
	. = ..()


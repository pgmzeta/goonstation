TYPEINFO(/obj/machinery/atmospherics/unary/lpa_emitter)
	// TODO: balance mats
	mats = list(
		"metal" = 10,
	)
/obj/machinery/atmospherics/unary/lpa_emitter
	name = "Ionized Plasma Filamenter"
	desc = "Ionizes a gas into a plasma filament beam, used to generate power with related equipment."
	icon = 'icons/obj/machines/fusion.dmi'
	icon_state = "laser-premade"

	var/obj/linked_laser/lpa/beam = null
	var/is_firing = FALSE

/obj/machinery/atmospherics/unary/lpa_emitter/cheat
	// TODO: atmos tank holder


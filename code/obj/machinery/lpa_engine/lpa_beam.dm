/obj/linked_laser/lpa
	name = "ion filament"
	desc = "A self-contained ionized plasma filament beam."
	icon = 'icons/obj/lasers/lpa_beam.dmi' // TODO: Bespoke beam sprite
	icon_state = "lpa_beam"
	event_handler_flags = USE_FLUID_ENTER
	var/obj/machinery/atmospherics/unary/lpa_emitter/source = null

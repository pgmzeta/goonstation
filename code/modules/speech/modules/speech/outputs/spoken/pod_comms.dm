/datum/speech_module/output/spoken/pod_comms
	id = SPEECH_OUTPUT_SPOKEN_POD_COMMS

/datum/speech_module/output/spoken/pod_comms/format(datum/say_message/message)
	var/obj/machinery/vehicle/ship = message.speaker

	message.format_speaker_prefix = {"\
		<span class='name' style='color:green;'>\
		<b>[bicon(ship)]\
	"}

	message.format_verb_prefix = {"\
		</b></span> \
		<span class='message' style='color:green;'>\
	"}

	message.format_content_prefix = {"\
		, \
	"}

	message.format_content_suffix = {"\
		</span>\
	"}

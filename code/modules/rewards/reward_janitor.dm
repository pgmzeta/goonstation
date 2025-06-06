/datum/item_reward/job/janitor
	required_job = "Janitor"

/datum/item_reward/job/janitor/red_bucket
	title = "Red Bucket"
	desc = "A bucket! And it's red! Wow."
	required_job_level = 5
	needed_item_path = /obj/item/reagent_containers/glass/bucket
	given_item_path = /obj/item/reagent_containers/glass/bucket/red
	success_message = "You turn around for just a second and your bucket is suddenly all red!"
	failure_message = "You need to be holding a bucket in order to claim this reward."

/datum/item_reward/job/janitor/holographic_sign
	title = "Holographic Signs "
	desc = "Gives access to a hologram emitter loaded with various signs."
	required_job_level = 10
	max_redeem_per_round = 5
	given_item_path = /obj/item/holoemitter
	success_message = "You pull a holo-emitter from the future!"

/datum/item_reward/job/janitor/orange_mop
	title = "Orange Mop"
	desc = "A mop! And it's orange! Amazing."
	required_job_level = 15
	needed_item_path = /obj/item/mop
	given_item_path = /obj/item/mop/orange
	success_message = "An orange shade starts to crawl all over the mop's head."
	failure_message = "You need to be holding a mop in order to claim this reward."

/datum/item_reward/job/janitor/sanitation_beret
	title = "Head of Sanitation beret"
	desc = "You've seen it all. You've seen entirely too much. Was it worth it? Maybe this hat will help you forget..."
	required_job_level = 20
	max_redeem_per_round = 1
	given_item_path = /obj/item/clothing/head/janiberet
	success_message = "You pull out your trusty, immaculately-kept beret!"

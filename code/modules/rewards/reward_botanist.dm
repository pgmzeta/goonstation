/datum/item_reward/job/botanist
	required_job = "Botanist"

/datum/item_reward/job/botanist/seed
	title = "Strange Seed"
	desc = "You notice a strange looking seed and grab it instinctually before you realize what happened."
	max_redeem_per_round = 1
	given_item_path = /obj/item/seed/alien

/datum/item_reward/job/botanist/wateringcan
	title = "Golden Watering Can"
	desc = "A Golden Watering can. Seems the same as normal otherwise..."
	required_job_level = 3
	max_redeem_per_round = 1
	needed_item_path = /obj/item/reagent_containers/glass/wateringcan
	given_item_path = /obj/item/reagent_containers/glass/wateringcan/gold
	success_message = "You blink and your watering can seems different..."

/datum/item_reward/job/botanist/blue_apron
	title = "Blue apron"
	desc = "An apron to protect yourself from any workplace spills and messes."
	required_job_level = 5
	max_redeem_per_round = 1
	given_item_path = /obj/item/clothing/suit/apron/botanist
	success_message = "The apron pops into existance!"

/datum/item_reward/job/botanist/wateringcan/weed
	title = "Weed Watering Can"
	desc = "A watering can with the likeness of a certain plant on it. Seems the same as normal otherwise..."
	required_job_level = 8
	given_item_path = /obj/item/reagent_containers/glass/wateringcan/weed

/datum/item_reward/job/botanist/wateringcan/rainbow
	title = "Rainbow Watering Can"
	desc = "A watering can that looks like it's made of rainbows... sorta. Seems the same as normal otherwise..."
	required_job_level = 10
	given_item_path = /obj/item/reagent_containers/glass/wateringcan/rainbow

/datum/item_reward/job/botanist/jumpsuit
	title = "Senior Botanist Jumpsuit"
	desc = "An old jumpsuit with an earthy smell to it."
	required_job_level = 15
	max_redeem_per_round = 1
	given_item_path = /obj/item/clothing/under/misc/hydroponics

/datum/item_reward/job/botanist/wateringcan/old
	title = "Antique Watering Can"
	desc = "A watering can that looks sentimental and nostalgic. Seems the same as normal otherwise..."
	required_job_level = 20
	given_item_path = /obj/item/reagent_containers/glass/wateringcan/old

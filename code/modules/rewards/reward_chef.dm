ABSTRACT_TYPE(/datum/item_reward/job/chef)
/datum/item_reward/job/chef
	required_job = "Chef"

/datum/item_reward/job/chef/itamae_hat
	title = "Sushi Chef Hat"
	desc = "Om nom nom mmmm I love sushi"
	given_item_path = /obj/item/clothing/head/itamaehat
	success_message = "You look down and notice that a whole sushi chef outfit has materialized in your hands! What on earth?"
	max_redeem_per_round = 1

/datum/item_reward/job/chef/itame_uniform
	title = "Sushi Chef Uniform"
	desc = "Om nom nom mmmm I love sushi"
	given_item_path = /obj/item/clothing/under/misc/itamae
	success_message = "You look down and notice that a whole sushi chef outfit has materialized in your hands! What on earth?"
	max_redeem_per_round = 1

/datum/item_reward/job/chef/tall_hat
	title = "Tall Chef Hat"
	desc = "Your iconic toque blanche but tall!"
	required_job_level = 2
	needed_item_path = /obj/item/clothing/head/chefhat/
	given_item_path = /obj/item/clothing/head/chefhattall
	success_message = "Your chef's hat suddenly elongates before your very eyes!"
	failure_message = "You need to be holding a chef's hat in order to claim this reward"

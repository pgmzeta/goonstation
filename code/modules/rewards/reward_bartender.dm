ABSTRACT_TYPE(/datum/item_reward/job/bartender)
/datum/item_reward/job/bartender
	required_job = "Bartender"

/datum/item_reward/job/bartender/spectromonocle
	title = "Spectroscopic Monocle"
	desc = "Now you can look dapper and know which drinks you poisoned at the same time"
	required_job_level = 5
	needed_item_path = /obj/item/clothing/glasses/spectro
	given_item_path = /obj/item/clothing/glasses/spectro/monocle
	success_message = "You break the goggles in half and fashion the lens into a monocle...somehow."
	failure_message = "You need to be holding a pair of spectroscopic scanner goggles to claim this item"

/datum/item_reward/job/bartender/goldenshaker
	title = "Golden Cocktail Shaker"
	desc = "After all your years of service, you've finally managed to gather enough money in tips to buy yourself a present! You regret every cent."
	required_job_level = 20
	max_redeem_per_round = 1
	needed_item_path = /obj/item/reagent_containers/food/drinks/cocktailshaker
	given_item_path = /obj/item/reagent_containers/food/drinks/cocktailshaker/golden
	success_message = "You look away for a second and the shaker turns into golden from top to bottom!"

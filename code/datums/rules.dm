var/global/datum/rules/core/core_rules = new()
var/global/datum/rules/rp/rp_rules = new()

ABSTRACT_TYPE(/datum/rules)
/datum/rules
	var/title
	var/header
	var/preamble
	var/list/rule_list

/datum/rules/ui_state(mob/user)
	return tgui_always_state.can_use_topic(src, user)

/datum/rules/ui_status(mob/user, datum/ui_state/state)
	return tgui_always_state.can_use_topic(src, user)

/datum/rules/ui_interact(mob/user, datum/tgui/ui)
	ui = tgui_process.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Rules")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/rules/ui_static_data(mob/user)
	return list(
		"header" = src.header,
		"preamble" = src.preamble,
		"rule_list" = src.rule_list,
		"title" = src.title,
	)

/datum/rules/core
	title = "Rules"
	header = "Goonstation Server Rules"
	preamble = "The rules - more like guidelines, really - are intended to support an enjoyable experience for all, player and admin alike.  We try to keep limitations on personal playstyle choices as minimal as possible while still allowing for a fair and entertaining game for the players.  They're not intended to gate certain people out of the community, but to keep the community a place people want to be."
	rule_list = list(
		list(
			"rule" = "Don't grief",
			"explainer" = "This isn't limited to just killing people: dismembering, stripping, crippling, force-feeding, force-borging, uploading murder laws to the AI, setting up death traps, wrecking or depowering parts of the station, anything that explodes, lube smokes, placing radioactive flooring, etc. are all griefy.  As a rule of thumb, if it's bad and takes more than 10 minutes for a normal player to fix, or you're intentionally creating an indiscriminate hazard (especially in a high-traffic area), it is covered by this rule. If someone is confirmed (via game mechanics) to be an antagonist, is a cluwne, has agreed to whatever you're planning to do to them, or you've seen them griefing people this round, you can go after them. This means that you shouldn't kill people for annoying you mildly or inconveniencing you, but only if they are actual threats/a cluwne. Feel free to adminhelp for clarification anyways.  Antagonists and emagged cyborgs may ignore this rule whenever they want to. Mindhacks and thralls may ignore this rule when their orders contradict it- see <a href='https://wiki.ss13.co/Mindhack_Rules'>Mindhack Rules</a>. Silicons must ignore this rule if their orders/laws require it of them, but aren't allowed to grief otherwise. Note: braindead people still count as people. They might be coming back.  <b>A longer discussion of grief and what does and doesn't constitute it is available <a href='https://wiki.ss13.co/Grief'>here</a>.</b> <b style='color:red'>Do not harm anyone in arrivals unless they have purposefully retreated there after previously roaming the station, and even then, only if you or they are an antagonist.</b>",
		),
		list(
			"rule" = "Listen to the admins.",
			"explainer" = "We will try to treat you with basic respect, please return the favor: If an admin has to grump at you, take the time to talk to them about it and answer their questions HONESTLY.  We have multiple ways of telling if you are lying about stuff, and if we can't trust what you're saying, there's no point to talking so we're probably going to have to reach for the banhammer.  Also, although nobody expects you to take a talking-to with a smile and a nod, please try to keep a civil tone.  We're just people too, folks.",
		),
		list(
			"rule" = "No metagaming.",
			"explainer" = "Look, we all know that gamers like talking to other gamers, and doing so while gaming - all we ask is that if you are playing SS13, you do not use any out-of-game means to communicate with another player on the same server.  This effectively gives you more eyes and ears on a round than other players, and that's not fair.  Conversely, acting on any information obtained using solely in-game mechanics (<b>yes, deadchat counts</b>) is explicitly NOT metagaming with very few exceptions - going to areas you shouldn't be is the meat of it, check the page for a fuller explanation.  <b>There's a more in-depth discussion of this rule at the <a href='https://wiki.ss13.co/Metagaming'>Metagaming</a> page.</b>",
		),
		list(
			"rule" = "Bigotry and sexual content is a non-negotiable hard 'no'.",
			"explainer" = " If you are unsure what sexual content includes: do not refer to sex acts, genitalia, or anything sexual in nature. This includes erotic roleplay, which encompasses all situations which are erotic or suggestive in nature (e.g. 'spooning', making out, etc.), and not only those which are sexually explicit. Rape 'jokes' are considered sexual content. There is absolutely no reason whatsoever to use the word 'rape' in this game. Yes, you can call people dicks and insult them with terms that are used normally, but don't use bigoted language or slurs. Common examples of bigoted language include calling people 'retards', 'cunts' or 'traps', using 'gay' in a derogatory manner, or using gendered slurs like 'pussy' and 'bitch.' <b>If an admin tells you to knock something off because it breaks the no bigotry or sexual content rule, that is not an invitation for debate. Knock it off or go elsewhere.</b>  Bigoted language (for example, slurs) is also not allowed in your BYOND key, character name, flavor text, or anything else with which you interact with the server, whether as a joke, or masked with misspellings or spoonerisms. This rule also extends to cover bigotry and discrimination based around a player's in-game race, species, or gender identity.",
		),
		list(
			"rule" = "Do not name your character after political or controversial figures.",
			"explainer" = "If you're unsure what might constitute as controversial: avoid naming your character after murderers, abusers, religious figures, or any name you've heard of in the news. Naming yourself Lise Meitner is fine, but naming yourself OJ Simpson is not. <b>If an admin tells you to change your name because it's based on a political or controversial figure, it is not an invitation for debate. Change it or go elsewhere.</b>",
		),
		list(
			"rule" = "Do not modify your BYOND client (dreamseeker) in any way, shape or form.",
			"explainer" = "<u>This is the other automatic 'no' and is not open to discussion or explanation.</u>  If you get a message on connect that implies that the server thinks you're using a modified client, and you're really sure you're not, catch us on Discord and we'll talk about what might have gone wrong - but don't try and pull a fast one.  We have ways of knowing if you're telling the truth, and we will not talk about how.",
		),
		list(
			"rule" = "Don't carry grudges from round to round.",
			"explainer" = "If someone was a tremendous jerk in one round, and you didn't get to enact your revenge before the round ended, kiss it goodbye.  If you try to get back at them in a later round, that is griefing, and see rule number one.",
		),
		list(
			"rule" = "Don't use multiple accounts.",
			"explainer" = "This means if you get killed in a round, you shouldn't login to a new account and rejoin the same server and start playing again. This also means that throughout your time here on Goon, you should stick to a single BYOND account. If you want to switch accounts for whatever reason, please let an admin know. You are not obligated to disclose your reason(s) for switching accounts, but you are required to share your old ckey (account name) and your new ckey. This also allows us transfer your medals and spacebux. If there are other people in your household playing or otherwise sharing an IP address for some reason, please ahelp to let us know (you only have to do this once, not every time you play). All we'll ask is that you not communicate with each other out-of-game about what's happening in the game.",
		),
		list(
			"rule" = "No spoilers.",
			"explainer" = "Many secrets are designed with the fun of the hunt in mind. Please don't rob other players of the joy of discovery - spoiling a secret for someone without their explicit consent is a No-No. You may share secrets with other players, provided that you do not use larger public channels of communication (like the in-game chat or forums) and make clear that you are sharing spoilers. For the Discord specifically, refer to Discord Rule #8: 'Obey Secret Content rules', in <a href='https://wiki.ss13.co/Rules#Discord_Rules'>the Discord Rules</a>. If you are not sure what belongs on the wiki, you can ask for permission from an administrator first.",
		),
		list(
			"rule" = "Do not impersonate admins under any circumstances.",
			"explainer" = "Do not threaten to get other people banned.  This will not end well for you!",
		),
		list(
			"rule" = "End of Round Grief.",
			"explainer" = "You are welcome to bomb the shuttle, beat other players or generally cause problems once the shuttle has arrived at Centcom - but only AFTER the line saying 'Further actions will have no impact on round results. Go hog wild!' has appeared.",
		),
		list(
			"rule" = "Communication must primarily be in English.",
			"explainer" = "Because this is fundamentally a game based around social interaction, players who do not speak a common language are isolated from the round and cannot understand communications from administrators. Players who share a language other than English should avoid excessive use so as not to exclude other players from their communication.",
		),
		list(
			"rule" = "This is not an exhaustive list.",
			"explainer" = "Rules-lawyering is STRONGLY discouraged.  If an admin asks you to knock something off, 'well it's not in the rules' is not really an argument.  If you feel this rule is being abused, please feel absolutely free to make use of the Admin Complaints forum - we won't punish you for posting a complaint.",
		),
	)

/datum/rules/rp
	title = "RP Rules"
	header = "Goonstation RP Server Guidelines and Rules"
	preamble = "The roleplay servers use our main rules and unique roleplay rules listed below. If you do not agree to this second set of rules, please play on our Classic servers."
	rule_list = list(
		list(
			"rule" = "Make an effort to roleplay.",
			"explainer" = "Play a coherent, believable character. Playing a violent or racist character is not allowed. Play your character as though they wish to keep their job at Nanotrasen. This includes listening to security and the chain of command and, if you are a member of command, taking your job as a leader seriously in-character. Only minor crime is permitted for non-antagonists. Avoid memes (e.g. sus, pog, amogus), txt spk (e.g. lol, wtf), and out of game terminology when you are playing your character. LOOC is available if you need to communicate out of character."
		),
		list(
			"rule" = "Escalate through roleplay before attacking other players.",
			"explainer" = "The goal of the roleplay server is character interaction and interesting scenarios. Both crew and antagonists are expected to roleplay escalation before engaging in hostilities. As an antagonist, your goal is to increase, not decrease, roleplay opportunities. Give people a sense of dread, an obvious motive, or some means of roleplaying and reacting, before you harm them. As security, your priority is the crew's safety and maintaining the peace. You should treat criminals fairly and determine appropriate consequences for their actions. Enemies to Nanotrasen such as confirmed non-human antagonists and open syndicate members may be treated harshly."
		),
		list(
			"rule" = "After you've selected a job, be sure to stay in your lane.",
			"explainer" = "While you are capable of doing anything within the game mechanics, allow those who have selected the relevant job to attempt the task first. As an example, breaking into medical and treating yourself when there are medical staff present is not okay. Choosing captain just to go and work the genetics machine all round is not acceptable."
		),
		list(
			"rule" = "As an antagonist you are free to kill and grief, provided you escalate per rule 2.",
			"explainer" = "You are not required to be evil, but you do have a broad toolset to push the round forward and make things exciting. Treat your role as an interesting challenge and not an excuse to destroy other people's game experiences. Your objectives do not allow you to ignore any rule, RP or otherwise. As an antagonist, you are not protected against being murdered or griefed, but it is expected that the crew roleplays and does not kill you just for the sake of killing an antagonist."
		),
		list(
			"rule" = "Do not use out of game information in game.",
			"explainer" = "Only use in-game information; the things your character can perceive or could know. While we have no hard rule on what a character can and cannot know, be reasonable about your character's knowledge and capabilities. Do not call out antagonists based on information that is only obvious as a player. For example, the drowsiness effects on your screen are not a good in-character basis to call out a changeling. The debris and adventure zones are for enhancing roleplay. Rushing through them for the sake of items alone is prohibited. It is reasonable for the crew to assume people with syndicate gear such as red space suits are antagonists."
		),
		list(
			"rule" = "Be kind to other players.",
			"explainer" = "Be respectful and considerate of other players, as their experiences are just as important as your own. Do not use LOOC or other means of communication to put down other players or accuse them of rulebreaking. If your problem with another player extends to rulebreaking, press F1 to contact the admins. It is your responsibility to respect the boundaries of others when you RP. If you feel uncomfortable, or worry that people are uncomfortable, don't be afraid to use LOOC to communicate. Furthermore, do not advantage your friends in game or exclude others from roleplaying opportunities without good cause."
		),
		list(
			"rule" = "These rules are extra rules for the roleplay server.",
			"explainer" = "The core rules still apply to the roleplay server. Do not argue with the administration about the RP rules or core rules."
		)
	)

//for trait / genetics checks
#define isalcoholresistant(x) ((x.bioHolder && x.bioHolder.HasEffect("resist_alcohol")) || (x.traitHolder && x.traitHolder.hasTrait("training_drinker")))

/// Returns true if the mob is currently atheist
#define isatheist(x) ((x.traitHolder && x.traitHolder.hasTrait("atheist")) && !(x.hasStatus("atheist_doubt")))

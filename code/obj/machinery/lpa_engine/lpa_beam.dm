/// Impedance of free space η₀ = √(μ₀/ε₀), Ω
#define LPA_ETA_0         376.73
/// √(Nₐ·e²/(ε₀·mₑ)) in rad·s⁻¹·√(m³/mol) — converts free-electron molar density to plasma angular frequency
#define LPA_PLASMA_FREQ_K 4.377e13
/// Characteristic beam cross-sectional area in m². Tune this for power balance.
/// At ~800 nm, 1 atm plasma, LPA_BEAM_AREA = 1e-2 m² (~11 cm diameter) → ~500 A yields ~1 MW.
#define LPA_BEAM_AREA     1e-2

/obj/linked_laser/lpa
	name = "ion filament"
	desc = "A self-contained ionized plasma filament beam."
	icon = 'icons/obj/lasers/lpa_beam.dmi' // TODO: Bespoke beam sprite
	icon_state = "lpa_beam"
	event_handler_flags = USE_FLUID_ENTER
	var/obj/machinery/atmospherics/unary/lpa_emitter/source = null
	/// Oscillation frequency of the filament, set by the emitter on creation. Higher values yield more power. // TODO: balance
	var/frequency = 1.0 // Hz
	/// Peak drive current (A) of the AC waveform energizing the field coils. Power scales as I². Paired with frequency to define the drive signal.
	var/drive_current = 1.0
	/// Unified beam health metric (0.0–1.0): the pre-ionized channel IS the containment mechanism.
	/// Seeded each tick by the emitter from pipe gas ionization efficiency (pressure × electron yield / ionization energy).
	/// Decays per hop as the channel disperses with distance; paramagnetic fuel gas slows this decay.
	/// Directly scales power output — a degraded channel carries proportionally less power.
	var/channel_quality = 0.0

/obj/linked_laser/lpa/copy_laser(turf/T, dir)
	var/obj/linked_laser/lpa/new_laser = ..(T, dir)
	new_laser.source = src.source
	new_laser.frequency = src.frequency
	new_laser.drive_current = src.drive_current
	// Channel quality decays per hop as the pre-ionized path disperses with distance.
	// Paramagnetic fuel magnetically pinches the channel, slowing dispersal.
	// Base retention 0.97/hop; toxins fuel (susceptibility 50) approaches 0.999/hop.
	var/datum/gas_mixture/fuel = src.source?.get_fuel_gas()
	// Magnetic retention: paramagnetic fuel pinches the channel, slowing dispersal.
	var/mag_suscept = fuel ? fuel.magnetic_susceptibility() : 0.0
	var/retention = 0.97 + 0.029 * clamp(mag_suscept / 50, 0.0, 1.0)
	// Ohmic loss: hotter fuel has higher conductivity (Spitzer σ ∝ T^1.5) → resistive dissipation per hop.
	// Negligible at room temp (σ≈100 for toxins); significant at plasma temps (σ≈3000 at 3000 K).
	// TODO: balance — reference constant 60000 chosen so toxins at 3000 K loses ~5% per hop.
	var/conductivity = fuel ? fuel.electrical_conductivity() : 0.0
	var/ohmic_loss = 1.0 - clamp(conductivity / 60000, 0.0, 0.5)
	new_laser.channel_quality = min(1.0, src.channel_quality * retention * ohmic_loss)

	return new_laser

/// Estimates moles of protons in a gas mixture, weighted by proton count of each gas.
/// Used to determine magnetic containment effectiveness.
/datum/gas_mixture/proc/proton_moles()
	return \
		oxygen         * 16 + \
		nitrogen       * 14 + \
		carbon_dioxide * 22 + \
		toxins         * 60 + \
		farts          * 10 + \
		radgas         * 86 + \
		nitrous_oxide  * 22 + \
		oxygen_agent_b * 20

/// Estimates moles of neutrons in a gas mixture, weighted by neutron count of each gas.
/// Neutron count = Mass number - Atomic number (protons).
/datum/gas_mixture/proc/neutron_moles()
	return \
		oxygen         * 16 + \
		nitrogen       * 14 + \
		carbon_dioxide * 22 + \
		toxins         * 50 + \
		farts          * 6  + \
		radgas         * 136+ \
		nitrous_oxide  * 22 + \
		oxygen_agent_b * 18

/// Estimates moles of electrons in a gas mixture, weighted by electrons-per-molecule of each gas.
/datum/gas_mixture/proc/electron_moles()
	return \
		oxygen         * 16 + \
		nitrogen       * 14 + \
		carbon_dioxide * 22 + \
		toxins         * 50 + \
		farts          * 10 + \
		radgas         * 86 + \
		nitrous_oxide  * 22 + \
		oxygen_agent_b * 24

/// Calculates the effective magnetic susceptibility of the gas mixture.
/// Positive = paramagnetic (attracted to magnetic fields), Negative = diamagnetic (repelled).
/// Used to determine how well beams can be magnetically confined.
/// Values are empirically derived from SI susceptibility coefficients (×1e-6).
/datum/gas_mixture/proc/magnetic_susceptibility()
	var/total_moles = TOTAL_MOLES(src)
	if (total_moles == 0)
		return 0

	var/weighted_susceptibility = \
		oxygen         * 2.1  + \
		nitrogen       * -0.7 + \
		carbon_dioxide * -0.99+ \
		toxins         * 50   + \
		farts          * -0.3 + \
		radgas         * -0.4 + \
		nitrous_oxide  * -0.49+ \
		oxygen_agent_b * 3.8

	return weighted_susceptibility / total_moles

/// Enthalpy of fusion is the energy per mole needed to transition from solid to liquid.
/datum/gas_mixture/proc/enthalpy_of_fusion()
	return \
		oxygen         * 0.44  + \
		nitrogen       * 0.36  + \
		carbon_dioxide * 9.02  + \
		toxins         * 45    + \
		farts          * 0.94  + \
		radgas         * 2.3   + \
		nitrous_oxide  * 16.86 + \
		oxygen_agent_b * 0.5


/// Enthalpy of vaporization is the energy per mole needed to transition from liquid to gas.
/datum/gas_mixture/proc/enthalpy_of_vaporization()
	return \
		oxygen         * 6.8   + \
		nitrogen       * 5.57  + \
		carbon_dioxide * 25.2  + \
		toxins         * 100   + \
		farts          * 8.16  + \
		radgas         * 16.4  + \
		nitrous_oxide  * 16.9  + \
		oxygen_agent_b * 7.0

/// Enthalpy of ionization is the energy per mole needed to remove an electron and form a cation.
/// Values are first ionization energies in kJ/mol; lower values indicate gases that are easier to ionize into plasma.
/datum/gas_mixture/proc/enthalpy_of_ionization()
	return \
		oxygen         * 1165  + \
		nitrogen       * 1503  + \
		carbon_dioxide * 1330  + \
		toxins         * 500   + \
		farts          * 1215  + \
		radgas         * 1037  + \
		nitrous_oxide  * 1244  + \
		oxygen_agent_b * 1200

/// Relative electric permittivity (εᵣ) of the gas mixture.
/// Determines how the medium stores electric field energy. Vacuum = 1.0; sub-unity indicates plasma-like behavior.
/// Values are static εᵣ at ~20°C, 1 atm; returns a mole-weighted average.
/datum/gas_mixture/proc/electric_permittivity()
	var/total_moles = TOTAL_MOLES(src)
	if (total_moles == 0)
		return 1 // vacuum

	var/weighted_permittivity = \
		oxygen         * 1.000547 + \
		nitrogen       * 1.000548 + \
		carbon_dioxide * 1.000922 + \
		toxins         * 0.95     + \
		farts          * 1.000944 + \
		radgas         * 1.000180 + \
		nitrous_oxide  * 1.001134 + \
		oxygen_agent_b * 1.000650

	return weighted_permittivity / total_moles

/// Electrical conductivity (σ) of the gas mixture in S/m.
/// Neutral gases are effectively non-conducting; ionized plasma gases contribute significantly.
/// Returns a mole-weighted average.
/datum/gas_mixture/proc/electrical_conductivity()
	var/total_moles = TOTAL_MOLES(src)
	if (total_moles == 0)
		return 0

	var/weighted_conductivity = \
		oxygen         * 1e-6  + \
		nitrogen       * 5e-7  + \
		carbon_dioxide * 1e-6  + \
		toxins         * 100.0 + \
		farts          * 1e-6  + \
		radgas         * 0.01  + \
		nitrous_oxide  * 2e-6  + \
		oxygen_agent_b * 1e-6

	// Spitzer conductivity: σ ∝ T^(3/2) — hotter plasma has longer electron mean-free-path and conducts better.
	// Normalised to 300 K so room-temperature values match the table entries.
	var/T_scale = (temperature / 300) ** 1.5
	return (weighted_conductivity / total_moles) * T_scale

/// Thermal ionization fraction: fraction of molecules that have shed at least one electron at the mixture's temperature.
/// Uses a Michaelis-Menten approximation f = T / (T + T_ref), where T_ref scales with first ionization energy.
/// T_ref is defined as the temperature at which 50% of the gas is ionized.
/// Toxins (E_ion=500 kJ/mol) → T_ref=3000 K; nitrogen (1503 kJ/mol) → T_ref=9018 K.
/// At room temperature (~300 K), nearly all gas is neutral; useful ionization requires superheating.
/datum/gas_mixture/proc/ionization_fraction()
	var/total = TOTAL_MOLES(src)
	if (total <= 0)
		return 0.0
	var/avg_ion_energy = enthalpy_of_ionization() / total // mole-weighted average, kJ/mol
	if (avg_ion_energy <= 0)
		return 1.0
	var/T_ref = avg_ion_energy * 6 // scaling constant: 500*6=3000 K for toxins
	return temperature / (temperature + T_ref)

/// Returns the Poynting power (W) carried by this beam segment.
/// Formula: P = ½·η·I²·A·containment_ratio
/// where η = η₀·√(μᵣ/εᵣ_eff) is the wave impedance of the plasma medium,
/// and εᵣ_eff = εᵣ_static·(1 − (ωₚ/ω)²) accounts for plasma dispersion.
/// Returns 0 if the drive frequency is below the plasma cutoff frequency.
/obj/linked_laser/lpa/get_source_power()
	var/datum/gas_mixture/air = source?.get_fuel_gas()
	if (!air)
		return 0

	// Free-electron molar density: bound electrons scaled by thermal ionization fraction.
	// ionization_fraction() ≈ 0.09 at 300 K for toxins; ≈ 0.5 at 3000 K; approaches 1 at very high temps.
	// Higher temperature → more free electrons → higher plasma cutoff → beam approaches cutoff → more power,
	// but overshoot and ω ≤ ωₚ → beam dies entirely. There is a sweet-spot temperature for each setup.
	var/n_e_density = (air.electron_moles() * air.ionization_fraction()) / (air.volume * 1e-3)

	// Plasma angular frequency ωₚ = K·√(nₑ), where K = √(Nₐe²/(ε₀mₑ))
	var/omega_p = LPA_PLASMA_FREQ_K * sqrt(n_e_density)
	var/omega = 2 * pi * frequency

	// Below the plasma cutoff the wave is evanescent and carries no power.
	if (omega <= omega_p)
		return 0

	// Effective permittivity: εᵣ_eff = εᵣ·(1 − (ωₚ/ω)²)
	// Clamped away from zero — the lossless model diverges at cutoff;
	// conductivity would regularise this in a complete treatment.
	var/eps_r_eff = max(0.01, air.electric_permittivity() * (1 - (omega_p / omega) ** 2))

	// Wave impedance η = η₀·√(μᵣ/εᵣ_eff)
	// magnetic_susceptibility() returns χₘ in units of 10⁻⁶ (SI), so μᵣ = 1 + χₘ×10⁻⁶ ≈ 1 for all gases
	var/mu_r = 1 + air.magnetic_susceptibility() * 1e-6
	var/eta = LPA_ETA_0 * sqrt(mu_r / eps_r_eff)

	// Poynting flux: P = ½·η·H₀²·A·containment_ratio
	// H₀ ≈ drive_current (A); coil geometry absorbed into LPA_BEAM_AREA
	return (eta / 2) * drive_current * drive_current * LPA_BEAM_AREA * channel_quality

#undef LPA_ETA_0
#undef LPA_PLASMA_FREQ_K
#undef LPA_BEAM_AREA

/// Plasma bolt fired when an unterminated LPA beam builds up enough unstable energy.
/// Spawned at the beam's endpoint and scaled to the accumulated energy at time of failure.
/// Damage and explosion scale with the accumulated energy at time of firing.
/datum/projectile/lpa_plasma_bolt
	name = "plasma bolt"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "beam"
	damage_type = D_ENERGY
	projectile_speed = 40
	max_range = 20
	dissipation_rate = 0.5
	dissipation_delay = 4
	brightness = 1
	color_red = 1.0
	color_green = 0.4
	color_blue = 0.0
	has_impact_particles = TRUE

/// Sets projectile damage proportional to accumulated unstable_energy vs. the failure threshold (1e6 W·ticks). TODO: balance
/datum/projectile/lpa_plasma_bolt/proc/set_power_from_energy(energy)
	damage = clamp(energy / 1e6 * 100, 10, 200)

/datum/projectile/lpa_plasma_bolt/on_hit(atom/hit, angle, obj/projectile/O)
	explosion_new(O, get_turf(hit), clamp(O.power / 20, 0.5, 6), 1.5)
	. = ..()

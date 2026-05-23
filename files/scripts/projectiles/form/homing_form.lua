dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function shot( proj )
	add_comp_remove_dupli( proj, 'HomingComponent', 'homing_form', {
		_tags = 'homing_form',
		homing_targeting_coeff = 130,
		homing_velocity_multiplier = 0.86,
	} )
end

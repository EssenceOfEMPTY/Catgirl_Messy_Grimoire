dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local command = 'projectile_speed_set'
local command_shot_velxy = command .. '_shot_velxy'

function shot( proj )
	if ( EntityHasTag( proj, command_shot_velxy ) ) then
		local varia_comps = EntityGetComponent( proj, 'VariableStorageComponent', command_shot_velxy )

		for _, varia_comp in ipairs( varia_comps or { } ) do
			local vel_x = ComponentGetValue2( varia_comp, 'value_float' )
			local vel_y = tonumber( ComponentGetValue2( varia_comp, 'value_string' ) ) or 0

			set_comp_value( proj, 'VelocityComponent', nil, {
				mVelocity = { vel_x, vel_y },
			}, nil, nil )

			EntityRemoveComponent( proj, varia_comp )
		end
	end
end

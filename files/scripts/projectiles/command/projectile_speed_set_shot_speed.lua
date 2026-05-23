dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local command = 'projectile_speed_set'
local command_shot_speed = command .. '_shot_speed'

function shot( proj )
	if ( EntityHasTag( proj, command_shot_speed ) ) then
		local varia_comps = EntityGetComponent( proj, 'VariableStorageComponent', command_shot_speed )

		for _, varia_comp in ipairs( varia_comps or { } ) do
			local speed = ComponentGetValue2( varia_comp, 'value_float' )

			set_comp_value( proj, 'VelocityComponent', nil, nil, function ( comp )
				local vel_x, vel_y = ComponentGetValue2( comp, 'mVelocity' )

				vel_x, vel_y = change_vel( vel_x, vel_y or 0, speed )

				ComponentSetValue2( comp, 'mVelocity', vel_x, vel_y )
			end, nil )

			EntityRemoveComponent( proj, varia_comp )
		end
	end
end

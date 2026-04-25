dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_shoot_angle_add'
local command_delay = command .. '_delay'

if ( entity ~= NULL_ENTITY ) then
	local varia_comps = EntityGetComponent( entity, 'VariableStorageComponent', command_delay )
	local count = 0

	for i, varia_comp in ipairs( varia_comps or { } ) do
		local angle = ComponentGetValue2( varia_comp, 'value_float' )

		local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }
		count = count + #v_comps

		for _, v_comp in ipairs( v_comps ) do
			local vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )

			vel_x, vel_y = rot_vel( vel_x, vel_y or 0, angle )

			ComponentSetValue2( v_comp, 'mVelocity', vel_x, vel_y )
		end

		EntityRemoveComponent( entity, varia_comp )
	end

	if ( count > 0 ) then
		command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
	else
		command_print( command .. '(', '$empty_command_error_no_projectile_change' )
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_speed_set'

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )
	local l_comps = EntityGetComponent( entity, 'LuaComponent', command .. '_dupli' )

	if ( paras ) then
		if ( EntityHasTag( entity, command .. '_delay' ) or ( paras.vel_x and paras.vel_y ) ) then
			EntityRemoveTag( entity, command .. '_delay' )

			if ( paras.speed ) then
				e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.speed )
			end

			if ( paras.vel_x and paras.vel_y ) then
				e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.vel_x, paras.vel_y )
			end

			for _, l_comp in ipairs( l_comps or { } ) do
				EntityRemoveComponent( entity, l_comp )
			end
		else
			EntityAddTag( entity, command .. '_delay' )

			ComponentSetValue2( GetUpdatedComponentID( ), 'mNextExecutionTime', GameGetFrameNum( ) )

			if ( paras.speed ) then
				local p_comps = EntityGetComponent( entity, 'ProjectileComponent' ) or { }

				for _, p_comp in ipairs( p_comps ) do
					ComponentSetValue2( p_comp, 'speed_min', paras.speed )
					ComponentSetValue2( p_comp, 'speed_max', paras.speed )
				end
			end

			local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }

			remove_speed_limit( v_comps )

			for _, l_comp in ipairs( l_comps or { } ) do
				if ( l_comp ~= GetUpdatedComponentID( ) ) then
					EntityRemoveComponent( entity, l_comp )
				end
			end
		end
	end
end

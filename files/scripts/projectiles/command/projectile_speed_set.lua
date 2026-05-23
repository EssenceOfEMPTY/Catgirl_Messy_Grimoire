dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )
local command = 'projectile_speed_set'
local command_speed = command .. '_speed'
local command_xy = command .. '_xy'

if ( entity ~= NULL_ENTITY and not ( EntityHasTag( entity, command_speed ) and EntityHasTag( entity, command_xy ) ) ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.speed ) then
			e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.speed )

			EntityAddTag( entity, command_speed )
		end

		if ( paras.vel_x and paras.vel_y ) then
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.vel_x, paras.vel_y )

			EntityAddTag( entity, command_xy )
		end
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )
local command = 'projectile_shoot_angle_set'
local command_delay = command .. '_delay'

if ( entity ~= NULL_ENTITY and not ( EntityHasTag( entity, command ) and EntityHasTag( entity, command_delay ) ) ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.angle_delay and ( paras.delay and paras.delay > 0 ) ) then
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.angle_delay, paras.delay )

			EntityAddTag( entity, command_delay )
		end

		if ( paras.angle ) then
			e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.angle )

			EntityAddTag( entity, command )
		end
	end
end

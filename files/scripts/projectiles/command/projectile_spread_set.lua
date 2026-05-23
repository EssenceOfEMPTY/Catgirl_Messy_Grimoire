dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )
local command = 'projectile_spread_set'

if ( entity ~= NULL_ENTITY and not EntityHasTag( entity, command ) ) then
	EntityAddTag( entity, command )

	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.angle )
	end
end

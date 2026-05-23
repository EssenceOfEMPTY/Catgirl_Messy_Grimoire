dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )
local command = 'color_set'

if ( entity ~= NULL_ENTITY and not EntityHasTag( entity, command ) ) then
	EntityAddTag( entity, command )

	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.a ) then
			e_cmd_funcs[ command ].action_4_paras( { }, true, paras.shooter, paras.r, paras.g, paras.b, paras.a )
		else
			e_cmd_funcs[ command ].action_3_paras( { }, true, paras.shooter, paras.r, paras.g, paras.b )
		end
	end
end

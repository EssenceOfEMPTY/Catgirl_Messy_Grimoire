dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'explode'

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.tar ) then
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.radius, paras.tar )
		end

		if ( paras.x and paras.y ) then
			e_cmd_funcs[ command ].action_3_paras( { }, true, paras.shooter, paras.radius, paras.x, paras.y )
		end
	end

	EntityKill( entity )
end

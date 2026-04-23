dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_gravity_set'

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.gravity_x == nil ) then
			e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.gravity_y )
		else
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.gravity_y, paras.gravity_x )
		end
	end

	local l_comps = EntityGetComponent( entity, 'LuaComponent', command .. '_dupli' )

	for _, l_comp in ipairs( l_comps or { } ) do
		EntityRemoveComponent( entity, l_comp )
	end
end

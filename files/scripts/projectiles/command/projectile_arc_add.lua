dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_arc_add'

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.duration and paras.duration > 0 ) then
			e_cmd_funcs[ command ].action_4_paras( { }, true, paras.shooter, paras.angle_delay, paras.inc_delay, paras.delay, paras.duration )
		elseif ( paras.delay and paras.delay > 0 ) then
			e_cmd_funcs[ command ].action_3_paras( { }, true, paras.shooter, paras.angle_delay, paras.inc_delay, paras.delay )
		end

		if ( paras.inc and paras.inc ~= 0 ) then
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.angle, paras.inc )
		elseif ( paras.angle and paras.angle ~= 0 ) then
			e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.angle )
		end
	end

	local l_comps = EntityGetComponent( entity, 'LuaComponent', command .. '_dupli' )

	for _, l_comp in ipairs( l_comps or { } ) do
		EntityRemoveComponent( entity, l_comp )
	end
end

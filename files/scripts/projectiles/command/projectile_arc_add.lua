dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )
local command = 'projectile_arc_add'
local command_12 = command .. '_12'
local command_34 = command .. '_34'

if ( entity ~= NULL_ENTITY and not ( EntityHasTag( entity, command_12 ) and EntityHasTag( entity, command_34 ) ) ) then
	local paras = parse_and_evaluate_command_paras( command, entity, e_cmd_funcs[ command ].para_names.all )

	if ( paras ) then
		if ( paras.duration and paras.duration > 0 ) then
			e_cmd_funcs[ command ].action_4_paras( { }, true, paras.shooter, paras.angle_delay, paras.inc_delay, paras.delay, paras.duration )

			EntityAddTag( entity, command_34 )
		elseif ( paras.delay and paras.delay > 0 ) then
			e_cmd_funcs[ command ].action_3_paras( { }, true, paras.shooter, paras.angle_delay, paras.inc_delay, paras.delay )

			EntityAddTag( entity, command_34 )
		end

		if ( paras.inc and paras.inc ~= 0 ) then
			e_cmd_funcs[ command ].action_2_paras( { }, true, paras.shooter, paras.angle, paras.inc )

			EntityAddTag( entity, command_12 )
		elseif ( paras.angle and paras.angle ~= 0 ) then
			e_cmd_funcs[ command ].action_1_paras( { }, true, paras.shooter, paras.angle )

			EntityAddTag( entity, command_12 )
		end
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = GetUpdatedEntityID( )

if ( entity ~= NULL_ENTITY ) then
	local params = parse_and_evaluate_command_params( 'empty_tp', entity, { 'tp_entities', 'tar', 'x', 'y' }, 0 )

	if ( params ) then
		if ( params.tar ) then
			empty_command_functions[ 'tp' ].action_2_paras( { }, true, params.shooter, params.tp_entities, params.tar )
		else
			empty_command_functions[ 'tp' ].action_3_paras( { }, true, params.shooter, params.tp_entities, params.x, params.y )
		end
	end
end

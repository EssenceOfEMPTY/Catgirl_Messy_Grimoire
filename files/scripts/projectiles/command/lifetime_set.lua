dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local params = parse_and_evaluate_command_params( 'empty_lifetime_set', entity, { 'lifetime' } )

	if ( params ) then
		empty_command_functions[ 'lifetime_set' ].action_1_paras( { }, true, params.shooter, params.lifetime )
	end
end

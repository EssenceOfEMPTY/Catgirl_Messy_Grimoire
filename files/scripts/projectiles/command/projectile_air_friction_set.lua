dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras= parse_and_evaluate_command_params( 'empty_projectile_air_friction_set', entity, { 'air_friction' } )

	if ( paras) then
		empty_command_functions[ 'projectile_air_friction_set' ].action_1_paras( { }, true, paras.shooter, paras.air_friction )
	end
end

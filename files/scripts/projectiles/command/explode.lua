dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras= parse_and_evaluate_command_params( 'empty_explode', entity, { 'radius', 'tar', 'x', 'y' } )

	if ( paras) then
		if ( paras.tar ) then
			empty_command_functions[ 'explode' ].action_2_paras( { }, true, paras.shooter, paras.radius, paras.tar )
		end

		if ( paras.x and paras.y ) then
			empty_command_functions[ 'explode' ].action_3_paras( { }, true, paras.shooter, paras.radius, paras.x, paras.y )
		end
	end
end

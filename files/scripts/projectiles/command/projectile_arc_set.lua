dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( 'empty_projectile_arc_set', entity, { 'angle', 'inc' } )

	if ( paras ) then
		if ( paras.inc == nil ) then
			empty_command_functions[ 'projectile_arc_set' ].action_1_paras( { }, true, paras.shooter, paras.angle )
		else
			empty_command_functions[ 'projectile_arc_set' ].action_2_paras( { }, true, paras.shooter, paras.angle, paras.inc )
		end
	end
end

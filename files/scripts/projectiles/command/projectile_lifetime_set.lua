dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( 'empty_projectile_lifetime_set', entity, { 'lifetime' } )

	if ( paras ) then
		empty_command_functions[ 'projectile_lifetime_set' ].action_1_paras( { }, true, paras.shooter, paras.lifetime )
	end

	local l_comps = EntityGetComponent( entity, 'LuaComponent', 'empty_projectile_lifetime_set_dupli' )

	for _, l_comp in ipairs( l_comps or { } ) do
		EntityRemoveComponent( entity, l_comp )
	end
end

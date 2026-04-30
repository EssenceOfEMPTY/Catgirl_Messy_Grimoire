dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local x, y = EntityGetTransform( entity )

	EntityLoad( empty_path .. 'entities/misc/perks/curse_death_trail.xml', x, y )
end

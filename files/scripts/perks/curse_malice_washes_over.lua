dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local cloud = GetUpdatedEntityID( )
local tar = EntityGetRootEntity( cloud )

if ( tar ~= NULL_ENTITY and EntityGetIsAlive( tar ) ) then
	local x1, y1 = EntityGetTransform( cloud )
	local x2, y2 = EntityGetTransform( tar )

	local x, y = move_toward( x1, y1, x2, y2, 1.0 )

	EntitySetTransform( cloud, x, y )
end

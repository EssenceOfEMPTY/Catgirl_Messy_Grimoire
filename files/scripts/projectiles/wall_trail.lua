dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity	= EntityGetRootEntity( GetUpdatedEntityID( ) )
local x, y = EntityGetTransform( entity )

local wall_pieces = shoot_projectile_from_projectile( entity, empty_path .. 'entities/projectiles/wall_piece.xml', x, y, 0, 0 )

local ng_num = get_ng_num( )

if ( ng_num > 0 ) then
	local comps = EntityGetComponent( wall_pieces, 'ProjectileComponent' )

	for _, comp in ipairs( comps or { } ) do
		local dmg, lifetime = ComponentGetValue2( comp, 'damage' ), ComponentGetValue2( comp, 'lifetime' )
		dmg, lifetime = ( 4 ^ ng_num ) * dmg, ( 1 + 0.2 * ng_num ) * lifetime

		ComponentSetValue2( comp, 'damage', dmg )
		ComponentSetValue2( comp, 'lifetime', lifetime )
	end
end

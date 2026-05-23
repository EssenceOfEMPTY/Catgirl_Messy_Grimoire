dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )

local wall = EntityLoad( empty_path .. 'entities/projectiles/wall_piece.xml', x, y )

local ng_num = get_ng_count( )

if ( ng_num > 0 ) then
	set_comp_value( wall, 'ProjectileComponent', nil, nil, function ( comp )
		local dmg, lifetime = ComponentGetValue2( comp, 'damage' ), ComponentGetValue2( comp, 'lifetime' )

		ComponentSetValue2( comp, 'damage', ( 4 ^ ng_num ) * dmg )
		ComponentSetValue2( comp, 'lifetime', ( 1 + 0.2 * ng_num ) * lifetime )
	end, nil )
end

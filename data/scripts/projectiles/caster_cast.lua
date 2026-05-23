dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity	= get_root_entity( )
local shooter = get_comp_info( entity, 'ProjectileComponent', nil, {
	{ 'mWhoShot', nil }
}, nil )

local comp = EntityGetFirstComponent( entity, 'ProjectileComponent' )

if ( comp ) then
	shooter = ComponentGetValue2( comp, 'mWhoShot' )
end

if ( shooter and shooter ~= NULL_ENTITY and EntityHasTag( shooter, 'teleportable_NOT' ) ) then
	return
end

if ( shooter ) and ( shooter ~= NULL_ENTITY ) then
	local tx, ty = EntityGetFirstHitboxCenter( shooter )

	EntitySetTransform( entity, tx, ty )
end

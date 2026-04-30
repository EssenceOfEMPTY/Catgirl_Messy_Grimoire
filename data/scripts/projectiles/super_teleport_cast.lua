dofile_once( 'data/scripts/lib/utilities.lua' )

local entity	= GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity )

local projectile_comp = EntityGetFirstComponent( entity, 'ProjectileComponent' )
local shooter = NULL_ENTITY

if ( projectile_comp ) then
	shooter = ComponentGetValue2( projectile_comp, 'mWhoShot' )
end

if ( shooter ~= NULL_ENTITY and EntityHasTag( shooter, 'teleportable_NOT' ) ) then
	return
end

local comp = EntityGetFirstComponent( entity, 'VelocityComponent' )

local vel_x, vel_y = nil, nil

if ( comp ) then
	vel_x, vel_y = ComponentGetValue2( comp, 'mVelocity' )
end

local angle = 0 - math.atan( vel_y or 0, vel_x )

local end_x = pos_x + math.cos( angle ) * 120
local end_y = pos_y - math.sin( angle ) * 120

local success, ex, ey = RaytracePlatforms( pos_x, pos_y, end_x, end_y )

if ( not success ) then
	ex = end_x
	ey = end_y
end

EntitySetTransform( entity, ex, ey )

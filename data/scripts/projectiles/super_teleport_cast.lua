dofile_once( 'data/scripts/lib/utilities.lua' )

local entity_id	= GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity_id )

local projectile_comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )
local shooter
if ( projectile_comp ) then
	shooter = ComponentGetValue2( projectile_comp, 'mWhoShot' )
end

-- 检查发射者是否有 teleportable_NOT 标签（传送免疫）
if ( shooter and shooter ~= NULL_ENTITY and EntityHasTag( shooter, 'teleportable_NOT' ) ) then
	return
end

local vel_x,vel_y

edit_component( entity_id, 'VelocityComponent', function( comp, vars )
	vel_x, vel_y = ComponentGetValueVector2( comp, 'mVelocity' )
	if not ( vel_x ) then
		vel_x = 0
	end
	if not ( vel_y ) then
		vel_y = 0
	end
end)

local angle = 0 - math.atan( vel_y, vel_x )

local end_x = pos_x + math.cos( angle ) * 120
local end_y = pos_y - math.sin( angle ) * 120

local success, ex, ey = RaytracePlatforms( pos_x, pos_y, end_x, end_y )

if not ( success ) then
	ex = end_x
	ey = end_y
end

EntitySetTransform( entity_id, ex, ey )

dofile_once('data/scripts/lib/utilities.lua')

local entity_id = GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity_id )
local vel_x, vel_y = 0, 0

local comps = EntityGetComponent( entity_id, 'VelocityComponent' )
if ( comps ) then
	local comp = comps[ 1 ]
	local temp_x, temp_y = ComponentGetValueVector2( comp, 'mVelocity' )
	vel_x, vel_y = temp_x or 0, temp_y or 0
end

if ( vel_x ~= 0 ) or ( vel_y ~= 0 ) then
	local angle = 0 - math.atan( vel_y, vel_x )
	local length = 1600

	local angle_up = angle + math.pi * 0.5
	local angle_down = angle - math.pi * 0.5

	vel_x = math.cos( angle_up ) * length
	vel_y = -math.sin( angle_up ) * length

	shoot_projectile_from_projectile( entity_id, 'data/entities/projectiles/deck/nuke.xml', pos_x, pos_y, vel_x, vel_y )

	vel_x = math.cos( angle_down ) * length
	vel_y = -math.sin( angle_down ) * length

	shoot_projectile_from_projectile( entity_id, 'data/entities/projectiles/deck/nuke.xml', pos_x, pos_y, vel_x, vel_y )
end

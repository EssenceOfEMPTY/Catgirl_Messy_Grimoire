dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity )

local shooter = '0'
local herd_id = '0'
comp_id = EntityGetFirstComponent( entity, 'ProjectileComponent' )
if ( comp_id ) then
	shooter = ComponentGetValue2( comp_id, 'mWhoShot' ) or '0'
	herd_id = ComponentGetValue2( comp_id, 'mShooterHerdId' ) or '0'
end

local how_many = 8
local angle_inc = ( 2 * math.pi ) / how_many
local theta = 0
local length = 100

for _ = 1, how_many do
	GameEntityPlaySound( entity, 'duplicate' )
	entity = EntityLoad( empty_path .. 'entities/projectiles/orb_timer_circle_no_copy.xml', pos_x, pos_y )

	comp_id = EntityGetFirstComponent( entity, 'ProjectileComponent' )
	if ( comp_id ) then
		ComponentSetValue2( comp_id, 'mWhoShot', shooter )
		ComponentSetValue2( comp_id, 'mShooterHerdId', herd_id )
	end

	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	comp_id = EntityGetFirstComponent( entity, 'VelocityComponent' )

	if ( comp_id ) then
		ComponentSetValueVector2( comp_id, 'mVelocity', vel_x, vel_y )
	end
end

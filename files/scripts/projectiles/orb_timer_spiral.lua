dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity )

local angle = deg_to_rad( GameGetFrameNum( ) ) * 3
local length = 100
local vel_x = math.cos( angle ) * length
local vel_y = - math.sin( angle ) * length

GameEntityPlaySound( entity, 'duplicate' )
entity = EntityLoad( empty_path .. 'entities/projectiles/orb_timer_spiral_no_copy.xml', pos_x, pos_y )

local shooter = '0'
local herd_id = '0'
local comp_id = EntityGetFirstComponent( entity, 'ProjectileComponent' )
if ( comp_id ) then
	ComponentSetValue2( comp_id, 'mWhoShot', shooter )
	ComponentSetValue2( comp_id, 'mShooterHerdId', herd_id )
end

comp_id = EntityGetFirstComponent( entity, 'VelocityComponent' )
if ( comp_id ) then
	ComponentSetValueVector2( comp_id, 'mVelocity', vel_x, vel_y )
end

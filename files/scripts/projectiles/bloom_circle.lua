dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity_id = GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity_id )
local how_many = 8
local a, b = time_for_vec3()
local angle_inc = ( 2 * math.pi ) / how_many + ( a / b )
local theta = 0
local length = 300

local comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )
local shooter = 0
if ( comp ) then
	shooter = ComponentGetValue2( comp, 'mWhoShot' )
end

for _ = 1, how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc
	local p = shoot_projectile( entity_id, empty_path .. 'entities/projectiles/bloom_circle_projectile.xml', pos_x, pos_y, vel_x, vel_y, false )
	local p_comp = EntityGetFirstComponent( p, 'ProjectileComponent' )
	if ( p_comp and shooter ~= 0 ) then
		ComponentSetValue2( p_comp, 'mWhoShot', shooter )
	end
end

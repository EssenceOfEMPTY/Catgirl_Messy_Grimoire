dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local x, y = EntityGetTransform( entity )
local how_many, theta, length = 12, 0, 300
local angle_inc = p2 / how_many

local shooter = get_comp_info( entity, 'ProjectileComponent', nil, {
	{ 'mWhoShot', 0 },
}, nil )

for _ = 1, how_many do
	local vel_x, vel_y = math.cos( theta ) * length, math.sin( theta ) * length

	theta = theta + angle_inc

	local p = shoot_projectile( entity, empty_path .. 'entities/projectiles/ice_circle_projectile.xml', x, y, vel_x, vel_y, false )

	if ( is_alive( shooter ) ) then
		set_comp_value( p, 'ProjectileComponent', nil, {
			mWhoShot = shooter,
		}, nil, nil )
	end
end

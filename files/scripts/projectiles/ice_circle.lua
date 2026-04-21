dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity_id = GetUpdatedEntityID( )
local pos_x, pos_y = EntityGetTransform( entity_id )
local how_many = 12
local angle_inc = p2 / how_many
local theta = 0
local length = 300

local comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )
local shooter = 0
if ( comp ) then
	shooter = ComponentGetValue2( comp, 'mWhoShot' )
end

local bool = shooter ~= NULL_ENTITY

for _ = 1, how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc
	local p = shoot_projectile( entity_id, empty_path .. 'entities/projectiles/ice_circle_projectile.xml', pos_x, pos_y, vel_x, vel_y, false )
	if ( bool ) then
		local p_comps = EntityGetComponent( p, 'ProjectileComponent' )

		for _, p_comp in ipairs( p_comps or { } ) do
			ComponentSetValue2( p_comp, 'mWhoShot', shooter )
		end
	end
end

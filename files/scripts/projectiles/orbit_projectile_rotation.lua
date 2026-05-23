dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )

local speed = get_comp_info( entity, 'VariableStorageComponent', 'orbit_projectile', {
	{ 'value_int', 1 },
}, nil )

local orbits, dist = get_all_child( entity, 'orbit_projectile' ), 24

for _, orbit in ipairs( orbits ) do
	local angle = math.pi * 0.5 * _ + GameGetFrameNum( ) * speed
	local rot = math.pi * 0.5 - angle

	local px, py = x + math.cos( angle ) * dist, y - math.sin( angle ) * dist

	EntityApplyTransform( orbit, px, py, rot )
end

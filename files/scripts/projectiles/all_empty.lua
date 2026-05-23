
local p_s = EntityGetWithTag( 'projectile' )

for _, p in ipairs( p_s or { } ) do
	EntityKill( p )
end

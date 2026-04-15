
local projectiles = EntityGetWithTag( 'projectile' )

if ( #projectiles > 0 ) then
	for _, projectile in ipairs( projectiles ) do
		EntityKill( projectile )
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local projectile_comp = EntityGetFirstComponent( entity, 'ProjectileComponent' )
local shooter

if ( projectile_comp ) then
	shooter = ComponentGetValue2( projectile_comp, 'mWhoShot' )
end

if ( shooter and shooter ~= NULL_ENTITY ) then
	local projectiles = EntityGetWithTag( 'projectile' ) or {}
	if ( #projectiles > 0 ) then
		local controls = EntityGetFirstComponentIncludingDisabled( shooter, 'ControlsComponent' )
		if ( controls ) then
			local cursor_x, cursor_y = ComponentGetValue2( controls, 'mMousePosition' )
			if ( cursor_x and cursor_y ) then
				for _ = 1, #projectiles do
					local projectile = projectiles[_]

					local velcomp = EntityGetFirstComponentIncludingDisabled( projectile, 'VelocityComponent' )
					local projectile_x, projectile_y = EntityGetTransform( projectile )
					if ( velcomp ) then
						local length = 500
						local divergence = ( ( math.random( ) - 0.5 ) * 0.174533 )
						local angle = ( math.pi - math.atan( ( cursor_y - projectile_y ), ( cursor_x - projectile_x ) ) ) + divergence
						local vel_x = - math.cos( angle ) * length
						local vel_y = math.sin( angle ) * length
						ComponentSetValue2( velcomp, 'mVelocity', vel_x, vel_y )
					end
				end
			end
		end
	end
end

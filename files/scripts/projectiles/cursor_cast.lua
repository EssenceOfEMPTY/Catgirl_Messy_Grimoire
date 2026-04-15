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
	local controls = EntityGetFirstComponentIncludingDisabled( shooter, 'ControlsComponent' )
	if ( controls ) then
		local cursor_x, cursor_y = ComponentGetValue2( controls, 'mMousePosition' )
		if ( cursor_x and cursor_y ) then
			EntitySetTransform( entity, cursor_x, cursor_y )
		end
	end
end

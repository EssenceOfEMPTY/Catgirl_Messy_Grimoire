dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

local shooter = get_comp_info( entity, 'ProjectileComponent', nil, {
	{ 'mWhoShot', 0 }
}, nil )

if ( is_alive( shooter ) ) then
	local c_comp = EntityGetFirstComponentIncludingDisabled( shooter, 'ControlsComponent' )

	if ( c_comp ) then
		local cursor_x, cursor_y = ComponentGetValue2( c_comp, 'mMousePosition' )
		local x, y = EntityGetTransform( entity )

		EntitySetTransform( entity, cursor_x or x, cursor_y or y )
	end
end

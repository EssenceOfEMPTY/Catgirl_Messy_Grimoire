dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local x, y = EntityGetTransform( entity )

local tars = EntityGetInRadiusWithTag( x, y, 128, 'homing_target' )

if ( #tars > 0 ) then
	for _, tar in ipairs( tars ) do
		local pos_x, pos_y = EntityGetTransform( tar )
		local off_x, off_y = vec_normalize( pos_x - x, pos_y - y )

		local e = EntityLoad( empty_path .. 'entities/misc/radiance_repell.xml', pos_x, pos_y )

		EntityAddChild( tar, e )

		set_comp_value( tar, 'CharacterDataComponent', nil, nil, function ( comp )
			local vel_x, vel_y = ComponentGetValue2( comp, 'mVelocity' )

			vel_x, vel_y = vel_x + off_x * 90, vel_y + off_y * 90

			ComponentSetValue2( comp, 'mVelocity', vel_x, vel_y )
		end, nil )

		PhysicsApplyForce( tar, off_x * 200, off_y * 200 )
	end
end

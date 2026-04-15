dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity_id = GetUpdatedEntityID( )
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 128, 'homing_target' )

if ( #targets > 0 ) then
	for i, target_id in ipairs( targets ) do
		local pos_x, pos_y = EntityGetTransform( target_id )
		local eid = EntityLoad( empty_path .. 'entities/misc/radiance_repell.xml', pos_x, pos_y )
		EntityAddChild( target_id, eid )

		local offset_x, offset_y = vec_normalize( pos_x - x, pos_y - y )
		edit_component( target_id, 'CharacterDataComponent',
			function( comp, vars )
				local vel_x, vel_y = ComponentGetValueVector2( comp, 'mVelocity' )
				vel_x = vel_x + offset_x * 90
				vel_y = vel_y + offset_y * 90
				ComponentSetValueVector2( comp, 'mVelocity', vel_x, vel_y )
			end
		)
		PhysicsApplyForce( target_id, offset_x * 200, offset_y * 200 )
	end
end

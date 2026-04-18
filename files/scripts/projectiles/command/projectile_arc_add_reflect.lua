dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local v_comp = EntityGetFirstComponent( entity, 'VariableStorageComponent', 'projectile_arc_set' )

	if ( v_comp ) then
		local paras = {
			frame = ComponentGetValue2( v_comp, 'value_int' ) or 0,
			angle = tonumber( ComponentGetValue2( v_comp, 'value_string' ) ) or 0,
			inc = ComponentGetValue2( v_comp, 'value_float' ) or 0,
		}

		paras.frame = paras.frame + 1

		local v_comps = EntityGetComponent( entity, 'VelocityComponent' )

		for i, _ in ipairs( v_comps or { } ) do
			local vel_x, vel_y = ComponentGetValue2( _, 'mVelocity' )

			vel_x, vel_y = rot_vel( vel_x, vel_y or 0, paras.angle + paras.frame * paras.inc )

			ComponentSetValue2( _, 'mVelocity', vel_x, vel_y )
		end

		ComponentSetValue2( v_comp, 'value_int', paras.frame )
	end
end

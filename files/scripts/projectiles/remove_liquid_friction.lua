dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local v_comps = EntityGetComponent( entity, 'VelocityComponent' )

	for _, v_comp in ipairs( v_comps or { } ) do
		ComponentSetValue2( v_comp, 'liquid_drag', 0 )
	end
end

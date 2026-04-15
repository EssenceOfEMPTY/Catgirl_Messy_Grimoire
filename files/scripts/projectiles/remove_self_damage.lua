dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local p_comps = EntityGetComponent( entity, 'ProjectileComponent' )
	for _, p_comp in ipairs( p_comps or {} ) do
		ComponentSetValue2( p_comp, 'friendly_fire', false )
		ComponentSetValue2( p_comp, 'collide_with_shooter_frames', -1 )
	end
end

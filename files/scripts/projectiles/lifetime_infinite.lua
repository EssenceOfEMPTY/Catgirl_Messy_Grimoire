dofile_once( 'data/scripts/lib/utilities.lua' )

local entity_id = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity_id ~= NULL_ENTITY ) then
	local projectile_components = EntityGetComponent( entity_id, 'ProjectileComponent' )

	for _, comp in ipairs( projectile_components or { } ) do
		ComponentSetValue2( comp, 'friendly_fire' , true )
		ComponentSetValue2( comp, 'collide_with_shooter_frames' , 60 )
		ComponentSetValue2( comp, 'lifetime' , -1 )
	end
end

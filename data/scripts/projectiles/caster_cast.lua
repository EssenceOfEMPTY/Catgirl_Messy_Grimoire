dofile_once( 'data/scripts/lib/utilities.lua' )

local entity_id	= GetUpdatedEntityID()
local owner_id = 0

local comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )

if ( comp ) then
	owner_id = ComponentGetValue2( comp, 'mWhoShot' )
end

if ( owner_id and owner_id ~= NULL_ENTITY and EntityHasTag( owner_id, 'teleportable_NOT' ) ) then
	return
end

if ( owner_id ) and ( owner_id ~= NULL_ENTITY ) then
	local tx, ty = EntityGetFirstHitboxCenter( owner_id )

	EntitySetTransform( entity_id, tx, ty )
end

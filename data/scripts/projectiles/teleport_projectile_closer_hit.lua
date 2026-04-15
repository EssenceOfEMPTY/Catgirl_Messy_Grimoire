dofile_once('data/scripts/lib/utilities.lua')

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local enemy_id = EntityGetRootEntity( entity_id )

if ( enemy_id and enemy_id ~= NULL_ENTITY and EntityHasTag( enemy_id, 'teleportable_NOT' ) ) then
	return
end

local projectiles = EntityGetInRadiusWithTag( x, y, 32, 'teleport_projectile_closer' )

if ( #projectiles > 0 ) then
	local pid = projectiles[ 1 ]
	local comps = EntityGetComponent( pid, 'VariableStorageComponent', 'teleport_closer' )
	local ox, oy

	for i, _ in ipairs( comps or { } ) do
		local n = ComponentGetValue2( _, 'name' )

		if ( n == 'origin_x' ) then
			ox = ComponentGetValue2( _, 'value_float' )
		elseif ( n == 'origin_y' ) then
			oy = ComponentGetValue2( _, 'value_float' )
		end
	end

	if ( ox ) and ( oy ) then
		EntitySetTransform( enemy_id, ox, oy )
		EntityApplyTransform( enemy_id, ox, oy )
	end
end

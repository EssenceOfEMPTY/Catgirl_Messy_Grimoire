
local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local comps = EntityGetComponent( entity, 'GameEffectComponent' )

	for _, comp in ipairs( comps or { } ) do
		local eff = ComponentGetValue2( comp, 'effect' )

		if ( eff == 'TELEPORTATION' or eff == 'TELEPORTITIS' ) then
			EntityRemoveComponent( entity, comp )
		end
	end
end

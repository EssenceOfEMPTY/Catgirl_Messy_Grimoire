
local p_comps = EntityGetComponent( EntityGetRootEntity( GetUpdatedEntityID( ) ), 'ProjectileComponent' )

for _, each in ipairs( p_comps or { } ) do
	local projectile = ComponentGetValue2( each, 'damage' ) or 0
	local fire = ComponentObjectGetValue2( each, 'damage_by_type', 'fire' ) or 0
	local explosion = ( ComponentObjectGetValue2( each, 'damage_by_type', 'explosion' ) or 0 ) + ( ComponentObjectGetValue2( each, 'config_explosion', 'damage' ) or 0 )
	local electricity = ComponentObjectGetValue2( each, 'damage_by_type', 'electricity' ) or 0
	local ice = ComponentObjectGetValue2( each, 'damage_by_type', 'ice' ) or 0
	local radioactive = ComponentObjectGetValue2( each, 'damage_by_type', 'radioactive' ) or 0
	local poison = ComponentObjectGetValue2( each, 'damage_by_type', 'poison' ) or 0
	local slice = ComponentObjectGetValue2( each, 'damage_by_type', 'slice' ) or 0
	local drill = ComponentObjectGetValue2( each, 'damage_by_type', 'drill' ) or 0
	local melee = ComponentObjectGetValue2( each, 'damage_by_type', 'melee' ) or 0
	local physics_hit = ComponentObjectGetValue2( each, 'damage_by_type', 'physics_hit' ) or 0
	local curse = ComponentObjectGetValue2( each, 'damage_by_type', 'curse' ) or 0
	local holy = ComponentObjectGetValue2( each, 'damage_by_type', 'holy' ) or 0
	local healing = ComponentObjectGetValue2( each, 'damage_by_type', 'healing' ) or 0

	local total_damage = 0.04
		+ fire
		+ (
			projectile
			+ explosion
			+ electricity
			+ ice
			+ radioactive
			+ poison
			+ slice
			+ drill
			+ melee
			+ physics_hit
			+ curse
			+ holy
			- healing
		) / 2

	ComponentSetValue2( each, 'damage', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'fire', total_damage )
	ComponentObjectSetValue2( each, 'damage_by_type', 'explosion', 0 )
	ComponentObjectSetValue2( each, 'config_explosion', 'damage', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'electricity', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'ice', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'radioactive', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'poison', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'slice', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'drill', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'melee', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'physics_hit', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'curse', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'holy', 0 )
	ComponentObjectSetValue2( each, 'damage_by_type', 'healing', 0 )
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

-- NOTE( Petri ):
-- There is a mods/nightmare potion.lua which overwrites this one.

materials_standard =
{
	{
		material='lava',
		cost=300,
	},
	{
		material='water',
		cost=200,
	},
	{
		material='blood',
		cost=200,
	},
	{
		material='alcohol',
		cost=200,
	},
	{
		material='oil',
		cost=200,
	},
	{
		material='slime',
		cost=200,
	},
	{
		material='acid',
		cost=400,
	},
	{
		material='radioactive_liquid',
		cost=300,
	},
	{
		material='gunpowder_unstable',
		cost=400,
	},
	{
		material='liquid_fire',
		cost=400,
	},
	{
		material='blood_cold',
		cost=300,
	},
	{
		material='plastic_molten',
		cost=300,
	},
	{
		material='blood_worm',
		cost=300,
	},
	{
		material='glass_molten',
		cost=300,
	},
}

materials_magic =
{
	{
		material='magic_liquid_teleportation',
		cost=700,
	},
	{
		material='magic_liquid_unstable_teleportation',
		cost=500,
	},
	{
		material='magic_liquid_polymorph',
		cost=500,
	},
	{
		material='magic_liquid_random_polymorph',
		cost=500,
	},
	{
		material='magic_liquid_berserk',
		cost=500,
	},
	{
		material='magic_liquid_charm',
		cost=800,
	},
	{
		material='magic_liquid_invisibility',
		cost=700,
	},
	{
		material='material_confusion',
		cost=600,
	},
	{
		material='magic_liquid_movement_faster',
		cost=500,
	},
	{
		material='magic_liquid_faster_levitation',
		cost=500,
	},
	{
		material='magic_liquid_worm_attractor',
		cost=600,
	},
	{
		material='magic_liquid_protection_all',
		cost=800,
	},
	{
		material='magic_liquid_mana_regeneration',
		cost=500,
	},
	{
		material='magic_liquid_hp_regeneration',
		cost=800,
	},
	{
		material='magic_liquid_hp_regeneration_unstable',
		cost=700,
	},
	{
		material='midas_precursor',
		cost=800,
	},
	{
		material='void_liquid',
		cost=700,
	},
	{
		material='material_darkness',
		cost=600,
	},
	{
		material='gold_molten',
		cost=600,
	},
	{
		material='mimic_liquid',
		cost=800,
	},
	{
		material='just_death',
		cost=500,
	},
	{
		material='magic_liquid_weakness',
		cost=700,
	},
	{
		material='porridge',
		cost=800,
	},
}

function init( entity_id )
	local potion_material = nil

	local components = EntityGetComponent( entity_id, 'VariableStorageComponent' )

	if ( components ) then
		for key, comp_id in pairs( components ) do
			local var_name = ComponentGetValue2( comp_id, 'name' )
			if ( var_name == 'potion_material' ) then
				potion_material = ComponentGetValue2( comp_id, 'value_string' )
			end
		end
	end

	if ( not potion_material or potion_material == '' ) then
		local players = EntityGetWithTag( 'player_unit' ) or { }
		local px, py = 0, 0
		if #players > 0 then
			for _, player in ipairs( players ) do
				local tempx, tempy = EntityGetTransform( player )
				px = px + tempx
				py = py + tempy
			end
			px = px / #players
			py = py / #players
		end
		local x, y = EntityGetTransform( entity_id )
		local a, b, c = time_for_vec3( )
		SetRandomSeed( x + px + a - c, y + py + b - c )

		if ( Random( 1, 100 ) <= 80 ) then
			if ( Random( 1, 100 ) <= 3 ) then
				potion_material = 'purifying_powder'
			else
				potion_material = random_from_array( materials_magic )
				potion_material = potion_material.material
			end
		else
			potion_material = random_from_array( materials_standard )
			potion_material = potion_material.material
		end

		if ( Random( 1, 100 ) <= 3 ) then
			local rnd = Random( 1, 7 )
			if ( rnd <= 2 ) then
				potion_material = 'sima'
			elseif ( rnd <= 4 ) then
				potion_material = 'juhannussima'
			elseif ( rnd <= 6 ) then
				potion_material = 'beer'
			else
				potion_material = 'mammi'
			end
		end
	end

	local total_capacity = tonumber( GlobalsGetValue( 'EXTRA_POTION_CAPACITY_LEVEL', '2000' ) ) or 2000
	if ( total_capacity > 2000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, 'MaterialSuckerComponent' )
		if ( comp ) then
			ComponentSetValue2( comp, 'barrel_size', total_capacity )
		end
		EntityAddTag( entity_id, 'extra_potion_capacity' )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

-- NOTE( Petri ):
-- There is a mods/nightmare potion.lua which overwrites this one.

materials_standard =
{
	{
		material='sand',
		cost=300,
	},
	{
		material='soil',
		cost=200,
	},
	{
		material='snow',
		cost=200,
	},
	{
		material='salt',
		cost=200,
	},
	{
		material='coal',
		cost=200,
	},
	{
		material='gunpowder',
		cost=200,
	},
	{
		material='fungisoil',
		cost=200,
	},
}

materials_magic =
{
	{
		material='copper',
		cost=500,
	},
	{
		material='silver',
		cost=500,
	},
	{
		material='gold',
		cost=500,
	},
	{
		material='brass',
		cost=500,
	},
	{
		material='bone',
		cost=800,
	},
	{
		material='purifying_powder',
		cost=800,
	},
	{
		material='fungi',
		cost=800,
	},
	{
		material='diamond',
		cost=600,
	},
	{
		material='sodium',
		cost=500,
	},
	{
		material='grass_holy',
		cost=1000,
	},
	{
		material='fungi_creeping',
		cost=800,
	},
	{
		material='orb_powder',
		cost=1000,
	},
	{
		material='monster_powder_test',
		cost=1000,
	},
}

function init( entity_id )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )
	local potion_material = 'sand'

	if ( Random( 0, 100 ) <= 75 ) then
		-- 0.05% chance of magic_liquid_
		potion_material = random_from_array( materials_magic )
		potion_material = potion_material.material
	else
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end

	local total_capacity = tonumber( GlobalsGetValue( 'EXTRA_POTION_CAPACITY_LEVEL', '2000' ) ) or 2000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, 'MaterialSuckerComponent' )

		if ( comp ) then
			ComponentSetValue2( comp, 'barrel_size', total_capacity )
		end

		EntityAddTag( entity_id, 'extra_potion_capacity' )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end
dofile_once( 'data/scripts/perks/perk.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

CHEST_LEVEL = 10

g_cartlike =
{
	total_prob = 0,
	{
		prob		= 1.2,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -3,
		entity	= 'data/entities/props/physics/minecart.xml'
	},
	{
		prob		= 1,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -5,
		entity	= 'data/entities/props/physics_cart.xml'
	},
	{
		prob		= 0.8,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -7,
		entity	= 'data/entities/props/physics_skateboard.xml'
	},
	{
		prob		= 0.5,
		min_count	= 1,
		max_count	= 1,
		entities = {
			{
				min_count = 1,
				max_count = 15,
				entity = 'data/entities/props/physics_barrel_oil.xml',
			}
		},
	},
	{
		prob		= 0.5,
		min_count	= 1,
		max_count	= 1,
		entities = {
			{
				min_count = 1,
				max_count = 15,
				entity = 'data/entities/props/physics_box_explosive.xml',
			}
		},
	},
	{
		prob		= 0.5,
		min_count	= 1,
		max_count	= 1,
		entities = {
			{
				min_count = 1,
				max_count = 15,
				entity = 'data/entities/props/physics_barrel_radioactive.xml',
			}
		},
	},
}

local old_spawn_crate = spawn_crate
function spawn_crate( x, y )
	EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

	local e = EntityLoad( empty_path .. 'entities/buildings/teleport_pyramid.xml', x - 512, y - 128 )

	set_comp_value( e, 'LifetimeComponent', nil, {
		lifetime = 18000,
	}, nil )

	old_spawn_crate( x, y )
end

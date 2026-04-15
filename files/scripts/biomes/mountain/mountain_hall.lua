dofile_once( 'data/scripts/perks/perk.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

CHEST_LEVEL = 10

g_cartlike =
{
	total_prob = 0,
	{
		prob		= 4,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -3,
		entity	= 'data/entities/props/physics/minecart.xml'
	},
	{
		prob		= 4,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -5,
		entity	= 'data/entities/props/physics_cart.xml'
	},
	{
		prob		= 2,
		min_count	= 1,
		max_count	= 1,
		offset_y	= -7,
		entity	= 'data/entities/props/physics_skateboard.xml'
	},
	{
		prob		= 0.5,
		min_count	= 1,
		max_count	= 1,
		offset_y	= 0,
		entity	= 'data/entities/props/physics_box_explosive.xml'
	},
	{
		prob		= 0.4,
		min_count	= 1,
		max_count	= 1,
		offset_y	= 0,
		entity	= 'data/entities/props/physics_barrel_radioactive.xml'
	},
	{
		prob		= 0.3,
		min_count	= 1,
		max_count	= 1,
		offset_y	= 0,
		entity	= 'data/entities/props/physics_barrel_oil.xml'
	},
}

local old_spawn_crate = spawn_crate
function spawn_crate( x, y )
	old_spawn_crate( x, y )

	EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

	empty_spawn_all_curses( x + 48, y - 64 )

	EntityLoad( empty_path .. 'entities/buildings/teleport_pyramid.xml', x - 384, y - 128 )
end

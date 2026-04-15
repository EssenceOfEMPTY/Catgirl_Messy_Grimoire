dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

CHEST_LEVEL = 10

local table_need_remove_limit = {
	g_small_enemies_helpless,
	g_small_enemies, g_big_enemies, g_small_enemies_sky, g_big_enemies_sky, g_large_enemies,
	g_lamp, g_lamp2,
	g_unique_enemy, g_unique_enemy2, g_unique_enemy3,
	g_fungi, g_physics_fungi,
	g_items, g_stash, g_bottle, g_chest,
	g_robots,
	g_props, g_props2, g_props3,
	g_nest,
}

for i, each in ipairs( table_need_remove_limit ) do
	local temp = each or {}
	if ( #temp > 0 ) then
		for _ = #temp, 1, -1 do
			if ( type( temp[ _ ] ) == 'table' ) then
				if ( temp[ _ ].entity and type( temp[ _ ].entity ) == 'string' ) then
					if ( not temp[ _ ].entity:find( '%S' ) ) then
						table.remove( temp, _ )
					else
						if ( temp[ _ ].spawn_check ) then
							temp[ _ ].spawn_check = nil
						end
					end
				elseif ( temp[ _ ].entities and type( temp[ _ ].entities ) == 'table' ) then
					--
				end
			end
		end
	end
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.SPAWN_MANY_ENEMIES' ) ) then
	local table_need_multiple_spawn = {
		g_small_enemies_helpless,
		g_small_enemies, g_big_enemies, g_small_enemies_sky, g_big_enemies_sky, g_large_enemies,
		g_unique_enemy, g_unique_enemy2, g_unique_enemy3,
		g_robots,
	}

	for i, each in ipairs( table_need_multiple_spawn ) do
		local temp = each or {}
		if ( #temp > 0 ) then
			for _ = #temp, 1, -1 do
				if ( type( temp[ _ ] ) == 'table' ) then
					if ( temp[ _ ].entity and type( temp[ _ ].entity ) == 'string' ) then
						if ( not temp[ _ ].entity:find( '%S' ) ) then
							table.remove( temp, _ )
						else
							temp[ _ ].min_count = temp[ _ ].min_count * 2
							temp[ _ ].max_count = temp[ _ ].max_count * 5
						end
					elseif ( temp[ _ ].entities and type( temp[ _ ].entities ) == 'table' ) then
						temp[ _ ].min_count = temp[ _ ].min_count * 2
						temp[ _ ].max_count = temp[ _ ].max_count * 3
					end
				end
			end
		end
	end
end

if ( spawn_chest ) then
	function spawn_chest( x, y )
		local a, b, c = time_for_vec3( )
		SetRandomSeed( x + a - c, y + b - c )
		local rnd = Random( 1, 3 )
		if ( rnd >= 3 ) then
			EntityLoad( 'data/entities/items/pickup/chest_random_super.xml', x, y )
		else
			EntityLoad( 'data/entities/items/pickup/chest_random.xml', x, y )
		end
	end
end

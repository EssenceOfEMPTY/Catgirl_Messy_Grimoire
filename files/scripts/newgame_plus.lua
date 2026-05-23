dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function do_newgame_plus( )
	local ng_count = get_ng_count( )

	local ng_change = {
		hp_scl_min = 2.5 * ng_count + 7,
		hp_scl_max = 10 * ng_count + 25,
		atk_speed = 0.5 ^ ( ng_count + 1 )
	}

	local d_muls = {
		melee = 3,
		projectile = 2,
		explosion = 2,
		fire = 2,
		electricity = 2,
		drill = 2,
		slice = 2,
		ice = 2,
		--physics_hit = 1,
		radioactive = 2,
		poison = 3,
		--curse = 1,
		--holy = 1,
		--healing = 1,
	}

	SessionNumbersSetValue( 'NEW_GAME_PLUS_COUNT', tostring( ng_count + 1 ) )

	if ( ModSettingGet( 'empty_the_blackhole_catgirl.EASY_NG+' ) ) then
		ng_change.hp_scl_min = ng_change.hp_scl_min / 2
		ng_change.hp_scl_max = ng_change.hp_scl_max / 4
		ng_change.atk_speed = 0.85 ^ ( ng_count + 1 )

		for _, v in pairs( d_muls ) do
			d_muls[ _ ] = 1.08
		end
	end

	SessionNumbersSetValue( 'DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN', tostring( ng_change.hp_scl_min ) )
	SessionNumbersSetValue( 'DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX', tostring( ng_change.hp_scl_max ) )
	SessionNumbersSetValue( 'DESIGN_NEW_GAME_PLUS_ATTACK_SPEED', tostring( ng_change.atk_speed ) )

	local players = get_all_players( )

	set_comp_obj_value( players, 'DamageModelComponent', nil, nil, function ( comp )
		for _, v in pairs( d_muls ) do
			local d_mul = v * ( ComponentObjectGetValue2( comp, 'damage_multipliers', _ ) or 1 )

			ComponentObjectSetValue2( comp, 'damage_multipliers', _, d_mul )
		end
	end, nil )

	if ( ModSettingGet( 'empty_the_blackhole_catgirl.CHAOS_CONNECTED_WORLD' ) ) then
		BiomeMapLoad_KeepPlayer( 'data/biome_impl/biome_map_newgame_plus.lua', 'data/biome/_pixel_scenes_newgame_plus.xml' )
	else
		BiomeMapLoad_KeepPlayer( 'data/biome_impl/biome_map_newgame_plus.lua', 'data/biome/_pixel_scenes_newgame_plus.xml' )
	end

	SessionNumbersSave( )

	LoadPixelScene( 'data/biome_impl/clean_entrance.png', '', 128, 1534, '', true, true )
	LoadPixelScene( 'data/biome_impl/clean_entrance.png', '', 128, 3070, '', true, true )
	LoadPixelScene( 'data/biome_impl/clean_entrance.png', '', 128, 6655, '', true, true )
	LoadPixelScene( 'data/biome_impl/clean_entrance.png', '', 128, 10750, '', true, true )

	local title = GameTextGet( '$new_game_for_newgame_plus' )
	local desc = GameTextGet( '$empty_ng_plus_desc' )

	GamePrintImportant( title .. ' ' .. string.rep( '+', ng_count ), desc )
end

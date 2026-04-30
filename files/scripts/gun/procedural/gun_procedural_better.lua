dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function generate_gun( cost, level, force_unshuffle )
	local entity_id = GetUpdatedEntityID( )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )

	SetRandomSeed( x + a - c, y + b - c )

	local ability_comp = EntityGetFirstComponent( entity_id, 'AbilityComponent' ) or 0

	if ( level == 1 ) then
		if ( Random( 0,10 ) < 5 ) then
			cost = cost + 15
		end
	end

	cost = cost + Random( -10, 15 )
	local gun = { }
	gun[ 'cost' ]	 = cost
	gun[ 'deck_capacity' ] = 0
	gun[ 'actions_per_round' ] = 0
	gun[ 'reload_time' ] = 0
	gun[ 'shuffle_deck_when_empty' ] = true
	gun[ 'fire_rate_wait' ] = 0
	gun[ 'spread_degrees' ] = 0
	gun[ 'speed_multiplier' ] = 0
	gun[ 'prob_unshuffle' ] = 0.1
	gun[ 'prob_draw_many' ] = 0.15
	gun[ 'mana_charge_speed' ] = 50 * level + Random( -5, 5 * level )
	gun[ 'mana_max' ] = 50 + ( 150 * level ) + ( Random( -5, 5 ) * 10 )
	gun[ 'force_unshuffle' ] = 0

	p = Random( 0, 100 )

	if ( p < 20 ) then
		gun[ 'mana_charge_speed' ] = ( 50 * level + Random( -5, 5 * level ) ) / 5
		gun[ 'mana_max' ] = ( 50 + ( 150 * level ) + ( Random( -5, 5 ) * 10 ) ) * 3

		if ( gun[ 'mana_charge_speed' ] < 10 ) then
			gun[ 'mana_charge_speed' ] = 10
		end
	end

	p = Random( 0, 100 )
	if ( p < 15 + level * 6 ) then
		gun[ 'force_unshuffle' ] = 1
	end

	local is_rare = 0
	p = Random( 0,100 )
	if ( p < 5 ) then
		is_rare = 1
		-- gun[ 'cost' ] = gun[ 'cost' ] * 2.5
		gun[ 'cost' ] = gun[ 'cost' ] + 65
		local light_comp = EntityGetFirstComponent( entity_id, 'LightComponent' )
		if ( light_comp ) then
			ComponentSetValue2( light_comp, 'update_properties', '1' )
			ComponentSetValue2( light_comp, 'r', '127' )
			ComponentSetValue2( light_comp, 'g', '0' )
			ComponentSetValue2( light_comp, 'b', '255' )
		end
	end
	-- based on capacity:
	-- deck_capacity, shuffle_deck_when_empty, actions_per_round,
	-- reload_time, fire_rate_wait, spread_degrees, speed_multiplier

	local var_1 = { 'reload_time', 'fire_rate_wait', 'spread_degrees', 'speed_multiplier', 'deck_capacity' }
	local var_2 = { 'shuffle_deck_when_empty', 'actions_per_round' }

	loc_shuffle( var_1 );
	if ( gun[ 'force_unshuffle' ] ~= 1 ) then
		loc_shuffle( var_2 )
	end

	for k, _ in pairs( var_1 ) do
		apply_random_variable( gun, _ )
	end

	for k, _ in pairs( var_2 ) do
		apply_random_variable( gun, _ )
	end

	-- Do this in 99% of the cases
	if ( gun[ 'cost' ] > 5 and Random( 0,1000 ) < 995 ) then
		if ( gun[ 'shuffle_deck_when_empty' ] ) then
			gun[ 'deck_capacity' ] = gun[ 'deck_capacity' ] + ( gun[ 'cost' ] / 5 )
			gun[ 'cost' ] = 0
		else
			-- I don't know if this is correct or not...?
			gun[ 'deck_capacity' ] = gun[ 'deck_capacity' ] + ( gun[ 'cost' ] / 10 )
			gun[ 'cost' ] = 0
		end
	end

	local name = ComponentGetValue2( ability_comp, 'ui_name' )
	if ( gun_names ) then
		name = gun_names[ Random( 1, #gun_names ) ] .. ' ' .. name
	end

	if ( gun[ 'shuffle_deck_when_empty' ] == true and Random( 1, 100 ) < 10 ) then
		gun[ 'shuffle_deck_when_empty' ] = false
	end

	if ( GlobalsGetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '0' ) == '1' ) then
		gun[ 'shuffle_deck_when_empty' ] = true

		if ( gun[ 'fire_rate_wait' ] > 0 ) then
			gun[ 'fire_rate_wait' ] = gun[ 'fire_rate_wait' ] / 2
		else
			gun[ 'fire_rate_wait' ] = gun[ 'fire_rate_wait' ] * 2
		end
		if ( gun[ 'reload_time' ] > 0 ) then
			gun[ 'reload_time' ] = gun[ 'reload_time' ] / 2
		else
			gun[ 'reload_time' ] = gun[ 'reload_time' ] * 2
		end
	end

	if ( force_unshuffle or ( GlobalsGetValue( 'PERK_NO_MORE_SHUFFLE_WANDS', '0' ) == '1' ) ) then
		gun[ 'shuffle_deck_when_empty' ] = false
	end

	if ( Random( 0, 10000 ) <= 9995 ) then
		gun[ 'deck_capacity' ] = clamp( gun[ 'deck_capacity' ], 0, 30 )
	end

	if ( GlobalsGetValue( 'EMPTY_CURSE_SHORT_WAND', '0' ) == '1' ) then
		if ( gun[ 'deck_capacity' ] <= 15 ) then
			gun[ 'deck_capacity' ] = math.ceil( gun[ 'deck_capacity' ] / 2 )
		else
			if ( gun[ 'deck_capacity' ] <= 30 ) then
				gun[ 'deck_capacity' ] = math.ceil( gun[ 'deck_capacity' ] / 4 )
			else
				gun[ 'deck_capacity' ] = 2
			end
		end

		gun[ 'mana_max' ] = gun[ 'mana_max' ] * 1.2
		gun[ 'mana_charge_speed' ] = gun[ 'mana_charge_speed' ] * 1.2
	end

	if ( gun[ 'reload_time' ] >= 60 ) then

		function random_add_actions_per_round( )
			gun[ 'actions_per_round' ] = gun[ 'actions_per_round' ] + 1
			if ( Random( 0, 100 ) < 70 ) then
				random_add_actions_per_round( )
			end
		end

		random_add_actions_per_round( )

		if ( Random( 0, 100 ) < 50 ) then
			-- gun[ 'actions_per_round' ] = Random( gun[ 'actions_per_round' ], gun[ 'deck_capacity' ] )
			local new_actions_per_round = gun[ 'deck_capacity' ]
			for i = 1,6 do
				local temp_actions_per_round = Random( gun[ 'actions_per_round' ], gun[ 'deck_capacity' ] )
				if ( temp_actions_per_round < new_actions_per_round ) then
					new_actions_per_round = temp_actions_per_round
				end
			end
			gun[ 'actions_per_round' ] = new_actions_per_round

		end

	end

	gun[ 'actions_per_round' ] = clamp( gun[ 'actions_per_round' ], 1, gun[ 'deck_capacity' ] )

	-- SetItemSprite( entity_id, ability_comp, 'data / items_gfx / gungen_guns / submachinegun_', Random( 0, 7 ) )
	ComponentSetValue2( ability_comp, 'ui_name', name )
	ComponentObjectSetValue2( ability_comp, 'gun_config', 'actions_per_round', gun[ 'actions_per_round' ] )
	ComponentObjectSetValue2( ability_comp, 'gun_config', 'reload_time', gun[ 'reload_time' ] )
	ComponentObjectSetValue2( ability_comp, 'gun_config', 'deck_capacity', gun[ 'deck_capacity' ] )
	ComponentObjectSetValue2( ability_comp, 'gun_config', 'shuffle_deck_when_empty', gun[ 'shuffle_deck_when_empty' ] )
	ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'fire_rate_wait', gun[ 'fire_rate_wait' ] )
	ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'spread_degrees', gun[ 'spread_degrees' ] )
	ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'speed_multiplier', gun[ 'speed_multiplier' ] )
	ComponentSetValue2( ability_comp, 'mana_charge_speed', gun[ 'mana_charge_speed' ] )
	ComponentSetValue2( ability_comp, 'mana_max', gun[ 'mana_max' ] )
	ComponentSetValue2( ability_comp, 'mana', gun[ 'mana_max' ] )
	ComponentSetValue2( ability_comp, 'gun_level', level )

	ComponentSetValue2( ability_comp, 'item_recoil_recovery_speed', 15.0 ) -- TODO: implement logic for setting this

	-- stuff in the gun
	local good_cards = 5
	if ( Random( 0,100 ) < 7 ) then
		good_cards = Random( 20,50 )
	end

	if ( is_rare == 1 ) then
		good_cards = good_cards * 2
	end

	local orig_level = level
	level = level - 1
	local deck_capacity = gun[ 'deck_capacity' ]
	local actions_per_round = gun[ 'actions_per_round' ]
	local card_count = Random( 1, 3 )
	local bullet_card = GetRandomActionWithType( x, y, level, ACTION_TYPE_PROJECTILE, 0 )
	local card = ''
	local random_bullets = 0
	local good_card_count = 0

	if ( Random( 0,10 ) < 5 and card_count < 3 ) then
		card_count = card_count + 1
	end

	if ( Random( 0,10 ) < 1 or is_rare == 1 ) then
		card_count = card_count + Random( 1, 2 )
	end

	-- modified by blackhole catgirl

	good_cards = Random( 5, 45 )
	card_count = Random( 0.51 * deck_capacity, deck_capacity )
	if ( deck_capacity > 1 ) then
		card_count = clamp( card_count, 1, deck_capacity - 1 )
	else
		card_count = 1
	end

	local rnd = nil

	if ( ( tonumber( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) ) or 0 ) > 0
		and ( tonumber( GlobalsGetValue( 'EMPTY_DISCOUNT_EXTRA_OFF', '0' ) ) or 0 ) < 1
		and Random( 1, 2 ) < 2 ) then

		AddGunActionPermanent( entity_id, 'REGENERATION_FIELD' )
	end

	if ( ( tonumber( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) ) or 0 ) > 0 ) then
		rnd = Random( 1, 4 )

		if ( rnd < 2 ) then
			AddGunActionPermanent( entity_id, 'BLOODLUST' )
		elseif ( rnd < 4 ) then
			AddGunActionPermanent( entity_id, 'ZERO_DAMAGE' )
		end
	end

	-- always cast
	for _ = 1, 10, 1 do
		SetRandomSeed( x + _ * _ - a + c, y - _ * _ - b + c )
		if ( Random( 1, 100 ) < 4 ) then
			rnd = Random( 0, 12 )

			if ( rnd < 3 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_PROJECTILE, 666 ) -- 3
			elseif ( rnd < 5 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_STATIC_PROJECTILE, 666 ) -- 2
			elseif ( rnd < 8 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_MODIFIER, 666 ) -- 3
			elseif ( rnd < 9 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_MATERIAL, 666 ) -- 1
			elseif ( rnd < 11 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_UTILITY, 666 ) -- 2
			else
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 2, ACTION_TYPE_OTHER, 666 ) -- 2
			end

			AddGunActionPermanent( entity_id, card )
		else
			break
		end
	end

	-- cards
	for _ = 1, card_count, 1 do
		SetRandomSeed( x - _ * _ + a - c, y + _ * _ + b - c )
		rnd = Random( 0, 83 )

		if ( rnd < 25 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_PROJECTILE, 666 ) -- 25
		elseif ( rnd < 34 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_STATIC_PROJECTILE, 666 ) -- 9
		elseif ( rnd < 38 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_DRAW_MANY, 666 ) -- 4
		elseif ( rnd < 54 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_MODIFIER, 666 ) -- 16
		elseif ( rnd < 58 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_MATERIAL, 666 ) -- 4
		elseif ( rnd < 74 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_UTILITY, 666 ) -- 16
		elseif ( rnd < 83 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_OTHER, 666 ) -- 9
		else
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 3, ACTION_TYPE_PASSIVE, 666 ) -- 1
		end

		AddGunAction( entity_id, card )
	end

	local wand = GetWand( gun ) or { }
	SetWandSprite( entity_id, ability_comp, wand.file, wand.grip_x, wand.grip_y, ( wand.tip_x - wand.grip_x ), ( wand.tip_y - wand.grip_y ) )
end

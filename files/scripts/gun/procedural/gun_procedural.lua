dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local old_make_wand_from_gun_data = make_wand_from_gun_data
function make_wand_from_gun_data( gun, entity_id, level )
	if ( gun[ 'shuffle_deck_when_empty' ] == 1 and Random( 1, 100 ) < 4 ) then
		gun[ 'shuffle_deck_when_empty' ] = 0
	end

	if ( GlobalsGetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '0' ) == '1' ) then
		gun[ 'shuffle_deck_when_empty' ] = 1

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

	if ( GlobalsGetValue( 'EMPTY_CURSE_SHORT_WAND', '0' ) == '1' ) then
		if ( gun[ 'deck_capacity' ] <= 15 ) then
			gun[ 'deck_capacity' ] = math.ceil( gun[ 'deck_capacity' ] / 2 )
		else
			if ( gun[ 'deck_capacity' ] <= 30 ) then
				gun[ 'deck_capacity' ] = math.ceil( gun[ 'deck_capacity' ] / 4 )
			else
				gun[ 'deck_capacity' ] = 1
			end
		end

		gun[ 'mana_max' ] = gun[ 'mana_max' ] * 1.2
		gun[ 'mana_charge_speed' ] = gun[ 'mana_charge_speed' ] * 1.2
	end

	old_make_wand_from_gun_data( gun, entity_id, level )
end

function wand_add_random_cards( gun, entity_id, level )

	local is_rare = gun[ 'is_rare' ]
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )

	-- stuff in the gun
	local good_cards = 5
	if ( Random( 0, 100 ) < 7 ) then
		good_cards = Random( 20, 50 )
	end

	if ( is_rare == 1 ) then
		good_cards = good_cards * 2
	end

	if ( level ) then level = 1 end
	level = tonumber( level )

	local orig_level = level
	level = level - 1
	local deck_capacity = gun[ 'deck_capacity' ]
	local actions_per_round = gun[ 'actions_per_round' ]
	local card_count = Random( 1, 3 )
	local bullet_card = GetRandomActionWithType( x, y, level, ACTION_TYPE_PROJECTILE, 0 )
	local card = ''
	local random_bullets = 0
	local good_card_count = 0

	if ( Random( 0, 100 ) < 50 and card_count < 3 ) then card_count = card_count + 1 end

	if ( Random( 0, 100 ) < 10 or is_rare == 1 ) then
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
	for _ = 1, 5, 1 do
		SetRandomSeed( x + _ * _ - a + c, y - _ * _ - b + c )
		if ( Random( 1, 100 ) < 4 ) then
			rnd = Random( 0, 10 )

			if ( rnd < 3 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 1, ACTION_TYPE_PROJECTILE, 666 ) -- 3
			elseif ( rnd < 5 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 1, ACTION_TYPE_STATIC_PROJECTILE, 666 ) -- 2
			elseif ( rnd < 8 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 1, ACTION_TYPE_MODIFIER, 666 ) -- 3
			elseif ( rnd < 9 ) then
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 1, ACTION_TYPE_MATERIAL, 666 ) -- 1
			else
				card = GetRandomActionWithType( x + _ * _, y - _ * _, level + 1, ACTION_TYPE_UTILITY, 666 ) -- 2
			end

			AddGunActionPermanent( entity_id, card )
		else
			break
		end
	end

	-- cards
	for _ = 1, card_count, 1 do
		SetRandomSeed( x - _ * _ + a - c, y + _ * _ + b - c )
		rnd = Random( 0, 125 )

		if ( rnd < 49 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_PROJECTILE, 666 ) -- 49
		elseif ( rnd < 58 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_STATIC_PROJECTILE, 666 ) -- 9
		elseif ( rnd < 74 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_DRAW_MANY, 666 ) -- 16
		elseif ( rnd < 99 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_MODIFIER, 666 ) -- 25
		elseif ( rnd < 108 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_MATERIAL, 666 ) -- 9
		elseif ( rnd < 124 ) then
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_UTILITY, 666 ) -- 16
		else
			card = GetRandomActionWithType( x - _ * _, y + _ * _, level + 1, ACTION_TYPE_PASSIVE, 666 ) -- 2
		end

		AddGunAction( entity_id, card )
	end
end

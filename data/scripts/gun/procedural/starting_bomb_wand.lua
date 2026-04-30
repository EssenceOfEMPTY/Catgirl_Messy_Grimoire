dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local e_id = GetUpdatedEntityID( )
local x, y = EntityGetTransform( e_id )
local a, b, c = time_for_vec3( )
SetRandomSeed( x + a - c, y + b - c )

local ability_comp = EntityGetFirstComponent( e_id, 'AbilityComponent' ) or { }

local gun = {
	name = 'Bomb wand',
	deck_capacity = { 2, 3 },
	actions_per_round = 1,
	shuffle_deck_when_empty = false,
	fire_rate_wait = { 2, 10 },
	reload_time = { 0, 12 },
	spread_degrees = 0,
	speed_multiplier = 1,
	mana_max = { 60, 120 },
}

gun.actions = {
	{ 'BOMB', 25 }, { 'EMPTY_STICKY_BOMB', 30 }, { 'EMPTY_BOUNCY_BOMB', 30 },
	{ 'DYNAMITE', 50 }, { 'EMPTY_STICKY_DYNAMITE', 60 }, { 'EMPTY_BOUNCY_DYNAMITE', 60 },
	{ 'MINE', 20 }, { 'MINE_DEATH_TRIGGER', 20 },
	{ 'ROCKET', 70 }, { 'ROCKET_TIER_2', 90 }, { 'ROCKET_TIER_3', 120 },
	{ 'GRENADE_TIER_2', 90 }, { 'GRENADE_TIER_3', 90 },
	{ 'BLACK_HOLE', 180 }, { 'WHITE_HOLE', 180 },
}

local deck_cap = get_random_between_range( gun.deck_capacity )

ComponentSetValue2( ability_comp, 'ui_name', gun.name )
ComponentSetValue2( ability_comp, 'item_name', '$item_wand_starting_wand_red' )

ComponentObjectSetValue2( ability_comp, 'gun_config', 'reload_time', get_random_between_range( gun.reload_time ) )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'fire_rate_wait', get_random_between_range( gun.fire_rate_wait ) )

ComponentObjectSetValue2( ability_comp, 'gun_config', 'actions_per_round', gun.actions_per_round )
ComponentObjectSetValue2( ability_comp, 'gun_config', 'deck_capacity', deck_cap )
ComponentObjectSetValue2( ability_comp, 'gun_config', 'shuffle_deck_when_empty', gun.shuffle_deck_when_empty )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'spread_degrees', gun.spread_degrees )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'speed_multiplier', gun.speed_multiplier )

local need_max_mana = 0
for _ = 1, deck_cap do
	local card = get_random_from( gun.actions )
	AddGunAction( e_id, card[ 1 ] )

	if ( need_max_mana < card[ 2 ] ) then
		need_max_mana = card[ 2 ]
	end
end

if ( gun.mana_max[ 1 ] < need_max_mana ) then
	gun.mana_max[ 1 ] = need_max_mana
	gun.mana_max[ 2 ] = math.ceil( gun.mana_max[ 1 ] * 1.2 )
end

local mana_max = get_random_between_range( gun.mana_max )
local mana_charge = math.ceil( mana_max / 6 )

ComponentSetValue2( ability_comp, 'mana_max', mana_max )
ComponentSetValue2( ability_comp, 'mana', mana_max )
ComponentSetValue2( ability_comp, 'mana_charge_speed', mana_charge )

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local e_id = GetUpdatedEntityID( )
local x, y = EntityGetTransform( e_id )
local a, b, c = time_for_vec3( )
SetRandomSeed( x + a - c, y + b - c )

function get_multiple_random_from( target, amount_ )
	local amount = amount_ or 1

	local result = { }

	for i = 1, amount do
		local rnd = Random( 1, #target )

		table.insert( result, tostring( target[ rnd ] ) )
	end

	return result
end

local ability_comp = EntityGetFirstComponent( e_id, 'AbilityComponent' ) or { }

local gun = {
	name = 'Bolt staff',
	deck_capacity = { 2, 5 },
	actions_per_round = 1,
	shuffle_deck_when_empty = false,
	fire_rate_wait = { 6, 20 },
	reload_time = { 16, 32 },
	spread_degrees = 0,
	speed_multiplier = 1,
	-- mana_charge_speed = { 20, 50 },
	mana_max = { 120, 240 },
}

gun.actions = {
	{ 'AIR_BULLET', 5 }, { 'ARROW', 15 }, { 'BOUNCY_ORB', 20 }, { 'BUBBLESHOT', 5 }, { 'BUCKSHOT', 25 }, { 'DISC_BULLET', 20 }, { 'SPITTER', 5 },
	{ 'LIGHT_BULLET', 5 }, { 'LIGHT_BULLET_TRIGGER', 10 }, { 'LIGHT_BULLET_TIMER', 10 }, { 'EMPTY_LIGHT_BULLET_DEATH_TRIGGER', 10 },
	{ 'RUBBER_BALL', 5 }, { 'EMPTY_RUBBER_BALL_TRIGGER', 10 }, { 'EMPTY_RUBBER_BALL_TIMER', 10 }, { 'EMPTY_RUBBER_BALL_DEATH_TRIGGER', 10 },
}

local deck_capacity = get_random_between_range( gun.deck_capacity )

ComponentSetValue2( ability_comp, 'ui_name', gun.name )
ComponentSetValue2( ability_comp, 'item_name', '$item_wand_starting_wand_blue' )

ComponentObjectSetValue2( ability_comp, 'gun_config', 'reload_time', get_random_between_range( gun.reload_time ) )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'fire_rate_wait', get_random_between_range( gun.fire_rate_wait ) )

ComponentObjectSetValue2( ability_comp, 'gun_config', 'actions_per_round', gun.actions_per_round )
ComponentObjectSetValue2( ability_comp, 'gun_config', 'deck_capacity', deck_capacity )
ComponentObjectSetValue2( ability_comp, 'gun_config', 'shuffle_deck_when_empty', gun.shuffle_deck_when_empty )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'spread_degrees', gun.spread_degrees )
ComponentObjectSetValue2( ability_comp, 'gunaction_config', 'speed_multiplier', gun.speed_multiplier )


local total_mana = 0
for i = 1, deck_capacity do
	local c = get_random_from( gun.actions )
	AddGunAction( e_id, c[ 1 ] )

	total_mana = total_mana + c[ 2 ] * 2
end

if ( gun.mana_max[ 1 ] < total_mana ) then
	gun.mana_max[ 1 ] = total_mana
	gun.mana_max[ 2 ] = total_mana * 2
end

local mana_max = get_random_between_range( gun.mana_max )
local mana_charge = math.ceil( mana_max / 4 )

ComponentSetValue2( ability_comp, 'mana_max', mana_max )
ComponentSetValue2( ability_comp, 'mana', mana_max )
ComponentSetValue2( ability_comp, 'mana_charge_speed', mana_charge )

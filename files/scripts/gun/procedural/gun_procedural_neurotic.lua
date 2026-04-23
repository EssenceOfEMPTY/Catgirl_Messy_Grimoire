dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local type_all = {
	'1_capacity',
	'0_act',
	'0_mana_max',
	'0_mana_charge',
	'high_wait',
	'high_reload',
	'high_wait_reload',
	'high_spread',
	'always_summoner',
	'always_greek_letter',
	'always_divide',
	'always_2x',
	'always_random',
}

---生成 “神杖”
---@param gun_type nil|string
---@param level nil|number
function generate_neurotic_gun( gun_type, level )
	local a, b, c = time_for_vec3( )

	SetRandomSeed( a + c, b + c )

	if ( gun_type ) then
		if ( type( level ) ~= 'number' ) then
			level = 0
		elseif ( level > 10 ) then
			level = 10
		elseif ( level < 0 ) then
			level = 0
		elseif ( level % 1 ~= 0 ) then
			level = math.floor( level )
		end

		local e_id = EntityGetRootEntity( GetUpdatedEntityID( ) )
		local x, y = EntityGetTransform( e_id )
		local a_comp = EntityGetFirstComponent( e_id, 'AbilityComponent' ) or 0

		local gun = {
			deck_capacity = 0,
			shuffle_deck_when_empty = false,
			actions_per_round = 0,
			fire_rate_wait = 0,
			reload_time = 0,
			spread_degrees = 0,
			speed_multiplier = 1,
			mana_max = 0,
			mana_charge_speed = 0,
		}

		local name = '$empty_neurotic_' .. gun_type

		if ( gun_type == '1_capacity' ) then
			gun.deck_capacity = 1
			gun.shuffle_deck_when_empty = level * Random( ) > 0.9
			gun.actions_per_round = 3 * level
			gun.fire_rate_wait = 15 - 3 * level
			gun.reload_time = 30 - 6 * level
			gun.spread_degrees = 0
			gun.speed_multiplier = 1
			gun.mana_max = math.max( 200, 300 * level )
			gun.mana_charge_speed = math.max( 100, 200 * level )
		elseif ( gun_type == '0_act' ) then
			gun.deck_capacity = 20 + level
			gun.shuffle_deck_when_empty = level * Random( ) > 0.9
			gun.actions_per_round = 0
			gun.fire_rate_wait = 15 - 3 * level
			gun.reload_time = 30 - 6 * level
			gun.spread_degrees = 0
			gun.speed_multiplier = 1
			gun.mana_max = math.max( 200, 300 * level )
			gun.mana_charge_speed = math.max( 100, 200 * level )
		end

		ComponentSetValue2( a_comp, "ui_name", name )
		ComponentObjectSetValue2( a_comp, "gun_config", "actions_per_round", gun["actions_per_round"] )
		ComponentObjectSetValue2( a_comp, "gun_config", "reload_time", gun["reload_time"] )
		ComponentObjectSetValue2( a_comp, "gun_config", "deck_capacity", gun["deck_capacity"] )
		ComponentObjectSetValue2( a_comp, "gun_config", "shuffle_deck_when_empty", gun["shuffle_deck_when_empty"] )
		ComponentObjectSetValue2( a_comp, "gunaction_config", "fire_rate_wait", gun["fire_rate_wait"] )
		ComponentObjectSetValue2( a_comp, "gunaction_config", "spread_degrees", gun["spread_degrees"] )
		ComponentObjectSetValue2( a_comp, "gunaction_config", "speed_multiplier", gun["speed_multiplier"] )
		ComponentSetValue2( a_comp, "mana_charge_speed", gun["mana_charge_speed"])
		ComponentSetValue2( a_comp, "mana_max", gun["mana_max"])
		ComponentSetValue2( a_comp, "mana", gun["mana_max"])
		ComponentSetValue2( a_comp, "gun_level", level )

		local wand = GetWand( gun ) or { }

		SetWandSprite( e_id, a_comp, wand.file, wand.grip_x, wand.grip_y, ( wand.tip_x - wand.grip_x ), ( wand.tip_y - wand.grip_y ) )
	else

		gun_type = type_all[ Random( 1, #type_all ) ]

		generate_neurotic_gun( gun_type, level )
	end
end
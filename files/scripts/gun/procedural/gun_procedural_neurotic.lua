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
---@param type string
---@param level number
function generate_neurotic_gun( type, level )
	local a, b, c = time_for_vec3( )

	if ( type ) then
		local e_id = GetUpdatedEntityID( )
		local x, y = EntityGetTransform( e_id )

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

		if ( type == '0_act' ) then
			--
		end
	else
		SetRandomSeed( a + c, b + c )
		local t = type_all[ Random( 1, #type_all ) ]

		if ( level ) then
			generate_neurotic_gun( t, level )
		else
			generate_neurotic_gun( t, 10 )
		end
	end
end
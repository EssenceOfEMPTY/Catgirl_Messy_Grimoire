dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

---<<<<<<<<<<<<<<<<<<<<<<<< 测试用代码 >>>>>>>>>>>>>>>>>>>>>>>>---

--

---<<<<<<<<<<<<<<<<<<<<<<<< 常规翻译 >>>>>>>>>>>>>>>>>>>>>>>>---

local translation = ModTextFileGetContent( 'data/translations/common.csv' )
local add_str = ''

if ( translation: sub( -1 ) == '\n' ) then
	add_str = ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
else
	add_str = '\n' .. ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 追加翻译: 伊芙琳娜 >>>>>>>>>>>>>>>>>>>>>>>>---

if ( ModSettingGet( 'empty_the_blackhole_catgirl.SVAROG_TRANSLATION' ) ) then
	add_str = add_str .. '\n' .. ModTextFileGetContent( empty_path .. 'translations/svarog_translation.csv' )
end

if ( add_str ~= '' ) then
	translation = translation .. add_str
end

ModTextFileSetContent( 'data/translations/common.csv', translation )

---<<<<<<<<<<<<<<<<<<<<<<<< 通用魔数设置 >>>>>>>>>>>>>>>>>>>>>>>>---

local magics = {
	--世界设置
	'CHAOS_CONNECTED_WORLD',

	--敌怪设置
	'NO_KUMMITUS',

	--视觉设置
	'REMOVE_LOW_HP_FLASH',
	'VISION_IMPROVE',

	--漏洞 & 轮椅设置
	'BUGFIX_HAND_OF_MASTER',
}

for _, magic in ipairs( magics ) do
	if ( ModSettingGet( 'empty_the_blackhole_catgirl.' .. magic ) ) then
		ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/' .. string.lower( magic ) .. '.xml' )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用文本文件覆写 >>>>>>>>>>>>>>>>>>>>>>>>---

local overwrite = {
	--
}

--世界设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.EASY_NG+' )
	or ModSettingGet( 'empty_the_blackhole_catgirl.CHAOS_CONNECTED_WORLD' ) ) then
	table.insert( overwrite, 'scripts/newgame_plus.lua' )
end

--视觉设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.VISION_IMPROVE' ) ) then
	local post_final = {
		'shaders/post_final.frag',
		'shaders/post_final.vert',
	}

	add_table( overwrite, post_final )
end

--漏洞 & 轮椅设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_SPELL_TO_POWER' ) ) then
	table.insert( overwrite, 'scripts/projectiles/spells_to_power.lua' )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_DUPE_MAX_HP_FROM_HEARTY' ) ) then
	local hearty = {
		'scripts/status_effects/hearty_start.lua',
		'scripts/status_effects/hearty_end.lua',
	}

	add_table( overwrite, hearty )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE' ) ) then
	local vulnerable = {
		'scripts/status_effects/wither_start.lua',
		'scripts/status_effects/wither_end.lua',
	}

	add_table( overwrite, vulnerable )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_CONNOISSEUR_OF_WANDS' ) ) then
	table.insert( overwrite, 'entities/animals/boss_pit/boss_pit_logic.lua' )
end

for _, each in ipairs( overwrite ) do
	ModTextFileSetContent( 'data/' .. each, ModTextFileGetContent( empty_path .. each ) )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用群系追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local biomes_append = {
	'alchemist_secret',
	'boss_arena', 'boss_arena_top', 'boss_limbs_arena',
	'clouds',
	'coalmine', 'coalmine_alt',
	'crypt', 'desert',
	'endgame', 'endgame_end',
	'excavationsite',
	'fungicave', 'fungiforest', 'liquidcave',
	'meat',
	'pyramid', 'pyramid_hallway',
	'rainforest', 'rainforest_dark',
	'robobase', 'robot_egg',
	'sandcave', 'sandroom',
	'secret_altar', 'secret_entrance',
	'smokecave_left', 'smokecave_middle', 'smokecave_right',
	'snowcastle', 'snowcastle_hourglass_chamber',
	'the_end', 'tower',
	'vault', 'vault_frozen',
	'wandcave', 'watercave',
	'winter', 'wizardcave',
}

for _, each in ipairs( biomes_append ) do
	ModLuaFileAppend( 'data/scripts/biomes/' .. each .. '.lua', empty_path .. 'scripts/biomes/biome_append.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用 lua 追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local lua_append = {
	'scripts/biomes/mountain/mountain_hall',
	'scripts/biomes/mountain_tree',
	'scripts/biomes/the_end',
	'scripts/perks/perk_list',
	'scripts/gun/gun',
	'scripts/gun/gun_actions',
	'scripts/gun/procedural/gun_procedural',
	'scripts/gun/procedural/gun_procedural_better',
}

for _, each in ipairs( lua_append ) do
	ModLuaFileAppend( 'data/' .. each .. '.lua', empty_path .. each .. '.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 开局更改 >>>>>>>>>>>>>>>>>>>>>>>>---

dofile_once( 'data/scripts/perks/perk.lua' )
dofile_once( 'data/scripts/perks/perk_utilities.lua' )
--[[
function OnMagicNumbersAndWorldSeedInitialized( )
	local perks_info = ''

	for i, _ in ipairs( perk_list ) do
		perks_info = perks_info .. ( [[["%s"] = "%s",%s]]-- ) : format( _.ui_name, _.id, '\n' )
		--[[
	end

	perks_info = 'return {\n' .. perks_info .. '}'
	info_print( perks_info, 'perks_info' )

	ModTextFileSetContent( empty_path .. '_virtual/perks_info.lua', perks_info )
end
]]--
function OnPlayerSpawned( player )
	if ( GlobalsGetValue( 'EMPTY_STARTING_CHANGE', '0' ) == '0' ) then
		GlobalsSetValue( 'EMPTY_STARTING_CHANGE', '1' )

		set_comp_value( player, 'CharacterPlatformingComponent', nil, {
			run_velocity = 57,

			velocity_min_x = -int_huge,
			velocity_max_x = int_huge,
			velocity_min_y = -int_huge,
			velocity_max_y = int_huge,
		}, nil, nil )

		for _, curse in ipairs( all_curses ) do
			if ( ModSettingGet( 'empty_the_blackhole_catgirl.' .. curse ) ) then
				perk_pickup( nil, player, 'EMPTY_' .. curse, false, false, true )
			end
		end
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 世界更新前 >>>>>>>>>>>>>>>>>>>>>>>>---

function OnWorldPreUpdate( )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( a + c, b + c )

	if ( GlobalsGetValue( 'EMPTY_PERK_REMOVE_COUNT', '0' ) ~= '0' ) then
		dofile( empty_path .. '' )
	end
end

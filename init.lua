dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
--dofile_once( empty_path .. 'scripts/magic/for_some_command.lua' )
--
--local receiver = nil
--function OnPlayerSpawned( player )
--	local updator = EntityCreateNew( 'empty.updator' )
--	EntityAddComponent2( updator, 'LuaComponent', { script_electricity_receiver_electrified = empty_path .. 'scripts/magic/for_some_command.lua' } )
--	receiver = EntityAddComponent2( updator, 'ElectricityReceiverComponent', { electrified_msg_interval_frames = 1 } )
--end
--
--function OnWorldPreUpdate( )
--	if ( receiver ) then
--		ComponentSetValue2( receiver, "mLastFrameElectrified", GameGetFrameNum( ) + 1 )
--	end
--end

---<<<<<<<<<<<<<<<<<<<<<<<< 翻译 >>>>>>>>>>>>>>>>>>>>>>>>---

local translation = ModTextFileGetContent( 'data/translations/common.csv' )
local add_str = ''

if ( translation: sub( -1 ) == '\n' ) then
	add_str = ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
else
	add_str = '\n' .. ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.SVAROG_TRANSLATION' ) ) then
	add_str = add_str .. '\n' .. ModTextFileGetContent( empty_path .. 'translations/yifulinna_translation.csv' )
end

translation = translation .. add_str

ModTextFileSetContent( 'data/translations/common.csv', translation )

---<<<<<<<<<<<<<<<<<<<<<<<< 魔数 >>>>>>>>>>>>>>>>>>>>>>>>---

ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/default.xml' )

if ( ModSettingGet( 'empty_the_blackhole_catgirl.NO_KUMMITUS' ) ) then
	ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/no_kummitus.xml' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 设置: 视野提升 >>>>>>>>>>>>>>>>>>>>>>>>---

if ( ModSettingGet( 'empty_the_blackhole_catgirl.VISION_IMPROVE' ) ) then
	ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/zoom.xml' )

	local post_final = {
		'shaders/post_final.frag',
		'shaders/post_final.vert',
	}

	for _, each in ipairs( post_final ) do
		ModTextFileSetContent( 'data/' .. each, ModTextFileGetContent( empty_path .. each ) )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 生物群系追加 >>>>>>>>>>>>>>>>>>>>>>>>---

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
	'scripts/perks/perk',
	'scripts/perks/perk_list',
	'scripts/gun/gun',
	'scripts/gun/gun_actions',
	'scripts/gun/procedural/gun_procedural',
	'scripts/gun/procedural/gun_procedural_better',
}

for _, each in ipairs( lua_append ) do
	ModLuaFileAppend( 'data/' .. each .. '.lua', empty_path .. each .. '.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 开局诅咒 >>>>>>>>>>>>>>>>>>>>>>>>---

dofile_once( 'data/scripts/perks/perk_utilities.lua' )
dofile_once( 'data/scripts/perks/perk.lua' )

function OnPlayerSpawned( player )
	if ( GlobalsGetValue( 'EMPTY_STARTING_CURSE', '0' ) == '0' ) then
		GlobalsSetValue( 'EMPTY_STARTING_CURSE', '1' )

		local all_curses = {
			'CURSE_MONK',
			'CURSE_ALWAYS_SHUFFLE',
			'CURSE_SHORT_WAND',
			'CURSE_MALICE_WASHES_OVER',
			'CURSE_REALITY_SHIFT',
			'CURSE_GUARANTEED_LOSE',
			'CURSE_GRAVITY_FREE',
		}

		for _, curse in ipairs( all_curses ) do
			if ( ModSettingGet( 'empty_the_blackhole_catgirl.' .. curse ) ) then
				perk_pickup( nil, player, 'EMPTY_' .. curse, false, false, true )
			end
		end
	end
end

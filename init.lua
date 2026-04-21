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

local translation = ModTextFileGetContent( 'data/translations/common.csv' )
	.. ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
ModTextFileSetContent( 'data/translations/common.csv', translation )

ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/default.xml' )

if ( ModSettingGet( 'empty_the_blackhole_catgirl.NO_KUMMITUS' ) ) then
	ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/no_kummitus.xml' )
end

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

ModLuaFileAppend( 'data/scripts/biomes/the_end.lua', empty_path .. 'scripts/biomes/imitated_biomes.lua' )

local lua_append = {
	'scripts/biomes/mountain/mountain_hall',
	'scripts/biomes/mountain_tree',
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

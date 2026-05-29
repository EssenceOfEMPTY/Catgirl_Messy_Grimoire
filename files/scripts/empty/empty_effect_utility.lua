dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

---全部效果
local all_effs = {

	---<<<<<<<<<<<<<<<<<<<<<<<< 法杖编辑 >>>>>>>>>>>>>>>>>>>>>>>>---

	'EDIT_WANDS_EVERYWHERE',--随时编辑法杖
	'NO_WAND_EDITING',--法杖无法编辑

	---<<<<<<<<<<<<<<<<<<<<<<<< 免疫 / 对应效果 >>>>>>>>>>>>>>>>>>>>>>>>---

	'PROTECTION_ALL',--神佑

	'PROTECTION_MELEE',--近战免疫
	'MELEE_COUNTER',--近战反击

	'PROTECTION_PROJECTILE',--投射物免疫

	'PROTECTION_EXPLOSION',--爆炸免疫

	'PROTECTION_FIRE',--火焰免疫
	'ON_FIRE',--着火
	'INTERNAL_FIRE',--内火上升

	'PROTECTION_ELECTRICITY',--雷电免疫
	'STUN_PROTECTION_ELECTRICITY',--雷电击晕免疫
	'ELECTROCUTION',--雷电击晕

	'PROTECTION_FREEZE',--寒冰免疫
	'STUN_PROTECTION_FREEZE',--冻结免疫
	'FROZEN_SPEED_UP',--冰冻时提高速度
	'INTERNAL_ICE',--寒冷
	'FROZEN',--冻结

	'PROTECTION_RADIOACTIVITY',--绿毒免疫
	'RADIOACTIVE',--绿毒
	'ALLERGY_RADIOACTIVE',--席西自带效果: 绿毒可击杀此实体

	'POISON',--紫毒

	'NO_SLIME_SLOWDOWN',--粘液不降低移动速度

	'PROTECTION_POLYMORPH',--变形免疫
	'POLYMORPH',--变羊
	'POLYMORPH_UNSTABLE',--不稳定变形 ( 随机席西 )
	'POLYMORPH_RANDOM',--不稳定变形 ( 完全随机 )
	'POLYMORPH_CESSATION',--不复存在

	'PROTECTION_DURING_TELEPORT',--传送免疫?
	'TELEPORTATION',-- 传送
	'TELEPORTITIS',-- 受伤传送
	'UNSTABLE_TELEPORTATION',-- 不稳传送

	'KNOCKBACK_IMMUNITY',--击退免疫
	'KNOCKBACK',--击退

	'IRON_STOMACH',--铁胃
	'PROTECTION_FOOD_POISONING',--吸血术效果2: 食物中毒免疫
	'FOOD_POISONING',--食物中毒

	--'PROTECTION_EDGES',--不知道啥玩意

	---<<<<<<<<<<<<<<<<<<<<<<<< 沾染相关 >>>>>>>>>>>>>>>>>>>>>>>>---

	'STAINS_DROP_FASTER',--驱散斗篷
	'INVISIBILITY',--隐形魔药效果
	'WET',--清水沾染效果
	'BLOODY',--鲜血沾染效果
	'SLIMY',--粘液沾染效果
	'CHARM',--魅惑魔药效果
	'OILED',--油液沾染效果
	'DRUNK',--醉酒沾染效果
	'JARATE',--尿液沾染效果
	'CONFUSION',--混乱魔药效果

	---<<<<<<<<<<<<<<<<<<<<<<<< 生命 / 承伤倍率 >>>>>>>>>>>>>>>>>>>>>>>>---

	'RESPAWN',--额外 1 命
	'SAVING_GRACE',--死里逃生
	'STAINLESS_ARMOUR',--光洁铠甲
	'REGENERATION',--生命恢复
	'HEALING_BLOOD',--吸血术效果1: 饮血回血
	'WEAKNESS',--虚弱
	'NO_HEAL',--禁疗

	---<<<<<<<<<<<<<<<<<<<<<<<< 视野 >>>>>>>>>>>>>>>>>>>>>>>>---

	'REMOVE_FOG_OF_WAR',--全视之眼
	'TELEPATHY',--蠕虫血液全视
	'BLINDNESS',--致盲

	---<<<<<<<<<<<<<<<<<<<<<<<< 伤害 / 法力 >>>>>>>>>>>>>>>>>>>>>>>>---

	'BERSERK',--狂暴
	'LOW_HP_DAMAGE_BOOST',--刀尖舔血
	'CRITICAL_HIT_BOOST',--暴击率+
	'MANA_REGENERATION',--法力回复增加

	---<<<<<<<<<<<<<<<<<<<<<<<< 移动 >>>>>>>>>>>>>>>>>>>>>>>>---

	'HOVER_BOOST',--强漂浮力
	'FASTER_LEVITATION',--更快漂浮天赋
	'LEVITATION',--漂浮魔药效果
	'MOVEMENT_FASTER_2X',--加速魔药效果
	'MOVEMENT_FASTER',--更快移动天赋
	'MOVEMENT_SLOWER',--饱食减速
	'MOVEMENT_SLOWER_2X',--法师领主效果: 更慢移动

	---<<<<<<<<<<<<<<<<<<<<<<<< 黄金 >>>>>>>>>>>>>>>>>>>>>>>>---

	'EXTRA_MONEY',--贪婪诅咒黄金 ×3
	'EXTRA_MONEY_TRICK_KILL',--技巧贪婪

	---<<<<<<<<<<<<<<<<<<<<<<<< 化敌为友 >>>>>>>>>>>>>>>>>>>>>>>>---

	'FRIEND_FIREMAGE',--炉石携带效果: 火男变得友好
	'FRIEND_THUNDERMAGE',--雷石携带效果: 电男变得友好

	---<<<<<<<<<<<<<<<<<<<<<<<< 无实际效果 >>>>>>>>>>>>>>>>>>>>>>>>---

	'RAINBOW_FARTS',--彩虹屁
	'FARTS',--放屁

	---<<<<<<<<<<<<<<<<<<<<<<<< 杂项 >>>>>>>>>>>>>>>>>>>>>>>>---

	'BREATH_UNDERWATER',--屏息静气
	'EXPLODING_CORPSE_SHOTS',--爆尸?
	'EXPLODING_CORPSE',--爆尸?
	'PROJECTILE_HOMING',--追踪天赋
	'WORM_ATTRACTOR',--蠕虫吸引者天赋 / 蠕虫信息素魔药效果
	'WORM_DETRACTOR',--移除虫洞: 排斥蠕虫效果
	'GLOBAL_GORE',--更多血液
	'ABILITY_ACTIONS_MATERIALIZED',--炸弹物质化
	'NO_DAMAGE_FLASH',--低生命值时不再闪屏
}

---正面效果
local pos_effs = {
}

---中性效果 / 意味不明效果
local neu_effs = {
}

---负面效果
local neg_effs = {
}

---沾染效果
local sta_effs = {
	'REGENERATION',
	'INVISIBILITY',
	'WET',
	'BLOODY',
	'LEVITATION',
	'MOVEMENT_FASTER_2X',
	'SLIMY',
	'CHARM',
	'WORM_ATTRACTOR',
	'OILED',
	'DRUNK',
	'JARATE',
	'ON_FIRE',
	'RADIOACTIVE',
	'POISON',
	'CONFUSION',
}

---为每个 entity 实体增加持续时间为 duration 帧的 eff 效果
---@param entity number|number[]
---@param eff string
---@param duration number|nil?
---@param path string|nil?
---@return number[] eff_entities
function add_effect_new( entity, eff, duration, path )
	local eff_entites = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	if ( is_not_nil_str( path ) ) then
		if ( ModDoesFileExist( path .. string.lower( eff ) .. '.xml' ) ) then
			for _, e in ipairs( entity or { } ) do
				local eff_entity = LoadGameEffectEntityTo( e, path .. string.lower( eff ) .. '.xml' )

				table.insert( eff_entites, eff_entity )
			end
		end
	else
		if ( ModDoesFileExist( 'data/entities/misc/effect_' .. string.lower( eff ) .. '.xml' ) ) then
			for _, e in ipairs( entity or { } ) do
				local eff_comp = LoadGameEffectEntityTo( e, 'data/entities/misc/effect_' .. string.lower( eff ) .. '.xml' )

				table.insert( eff_entites, eff_comp )
			end
		end
	end

	if ( duration ) then
		for _, eff_e in ipairs( eff_entites ) do
			if ( eff_e and eff_e ~= NULL_ENTITY ) then
				local eff_comps = EntityGetComponent( eff_e, 'GameEffectComponent' )

				for i, eff_comp in ipairs( eff_comps or { } ) do
					ComponentSetValue2( eff_comp, 'frames', duration )
				end
			end
		end
	end

	return eff_entites
end


---为每个 entity 实体延长持续时间为 prolong 帧的 eff 效果
---没有这个效果的场合, 改为增加 duration 帧的 eff 效果
---@param entity number|number[]
---@param eff string
---@param prolong number
---@param duration number|nil?
---@param path string|nil?
---@return number[] eff_entities
function prolong_effect( entity, eff, prolong, duration, path )
	local eff_entites = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local eff_comps, has_no_eff_e = { }, { }

	for _, e in ipairs( entity ) do
		local eff_comp = GameGetGameEffect( e, eff )

		if ( eff_comp > 0 ) then
			table.insert( eff_comps, eff_comp )
		else
			table.insert( has_no_eff_e, e )
		end
	end

	for _, eff_comp in ipairs( eff_comps ) do
		local frames = ComponentGetValue2( eff_comp, 'frames' )

		if ( frames ~= -1 ) then
			ComponentSetValue2( eff_comp, 'frames', frames + prolong )

			table.insert( eff_entites, ComponentGetEntity( eff_comp ) )
		end
	end

	if ( #has_no_eff_e > 0 ) then
		local eff_ex_entites = add_effect_new( has_no_eff_e, eff, duration, path )

		add_table( eff_entites, eff_ex_entites )
	end

	return eff_entites
end

---在状态栏展示效果
---@param eff string
---@param eff_entities number[]
---@param path string|nil
function show_effect( eff, eff_entities, path )
	local eff_low, icon_path = string.lower( eff ), 'data/ui_gfx/status_indicators/'

	if ( is_not_nil_str( path ) ) then
		icon_path = path .. eff_low .. '.png'
	else
		icon_path = icon_path .. eff_low .. '.png'
	end

	if ( not ModImageDoesExist( icon_path ) ) then
		icon_path = empty_path .. 'ui_gfx/status_indicators/icon_placeholder.png'
	end

	for _, eff_entity in ipairs( eff_entities ) do
		add_comp_remove_dupli( eff_entity, 'UIIconComponent', nil, {
			icon_sprite_file = icon_path,
			name = '$status_' .. eff_low,
			description = '$statusdesc_' .. eff_low,
			display_above_head = false,
			display_in_hud = true,
			is_perk = false,
		} )
	end
end

---为 entity 实体延长持续时间为 prolong 帧的 eff 效果
---没有这个效果的场合, 改为增加 duration 帧的 eff 效果
---@param entity number
---@param eff string
---@param prolong number
---@param duration number
---@param title string?
---@param path string|nil?
function add_effect( entity, eff, prolong, duration, title, path )
	prolong, duration = math.floor( prolong ), math.floor( duration )

	local eff_entities, eff_low = prolong_effect( entity, eff, prolong, duration, path ), string.lower( eff )

	if ( is_player( entity ) ) then
		show_effect( eff, eff_entities )

		if ( is_not_nil_str( title ) ) then
			imp_print( title, GameTextGet( '$empty_title_effect_display_random', GameTextGet( '$status_' .. eff_low ) ) )
		end
	end
end

---为 entity 实体延长持续时间为 prolong 帧的随机效果
---没有这个效果的场合, 改为增加 duration 帧的随机效果
---@param entity number
---@param prolong number
---@param duration number
---@param title string?
---@param path string|nil?
function add_effect_random( entity, prolong, duration, title, path )
	set_r_seed( entity )

	local eff = all_effs[ Random( 1, #all_effs ) ]

	add_effect( entity, eff, prolong, duration, title, path )
end

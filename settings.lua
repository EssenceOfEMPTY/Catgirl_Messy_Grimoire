dofile_once( 'data/scripts/lib/mod_settings.lua' )

local mod_id = 'empty_the_blackhole_catgirl'
local language = GameTextGet( '$current_language' )
mod_settings_version = 1

local b1 = '        '
local b2 = b1 .. b1
local b3 = b2 .. b1

mod_settings = {
--[[
	{
		id = '',
		ui_name = '',
		ui_description = '',
		value_default = nil,
		scope = MOD_SETTING_SCOPE_NEW_GAME | MOD_SETTING_SCOPE_RUNTIME | MOD_SETTING_SCOPE_RUNTIME_RESTART,
	},
]]--
}

if ( language:find( '中文' ) or language:find( '汉化' ) ) then
	mod_settings = {
		{
			category_id = 'INTRODUCTION',
			ui_name = '一些信息',
			foldable = true,
			_folded = true,
			settings = {
				{
					category_id = 'Q_GROUP',
					ui_name = '黑洞猫娘的 Q 群: 猫娘巢穴',
					foldable = true,
					_folded = true,
					settings = {
						{
							ui_name = '群号: 829721848',
							not_setting = true,
						},
					},
					not_setting = true,
				},
				{
					category_id = 'SP_THANKS',
					ui_name = '特别感谢 ( 排名不分先后 )',
					foldable = true,
					_folded = true,
					settings = {
						{
							category_id = 'WHITELEAF',
							ui_name = 'WhiteLeaf',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '重绘部分法术图标',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SHUG',
							ui_name = 'shug',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SLPAUS',
							ui_name = 'SlpAus',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'IMMORTALDAMNED',
							ui_name = 'ImmortalDamned',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'TANKSY',
							ui_name = 'Tanksy',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Sellhole 模组的开发者, 同意法术化地搬运他的模组',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'PICKLEDSOSIG',
							ui_name = 'PickledSosig',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Mega Perk Pack 模组的开发者, 最高等级地同意带有修改地搬运他的模组',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							ui_name = '黑洞猫娘非常推荐也去创意工坊游玩以上开发者的模组!',
							not_setting = true,
						},
					},
					not_setting = true,
				},
			},
			not_setting = true,
		},
		{
			category_id = 'SETTINGS_WORLDS',
			ui_name = '世界设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'STARTING_EDIT',
					ui_name = '开局编辑',
					ui_description = '在出生点右侧的山地大厅生成一片法杖编辑区域',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'TELEPORT_TO_PYRAMID',
					ui_name = '金字塔传送门',
					ui_description = '在出生点上方生成一个通往金字塔顶的传送门',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHAOS_CONNECTED_WORLD',
					ui_name = '四通八达',
					ui_description =
						'令各生物群系之间增加数量繁多的通路\n'
						.. '代价是区域混乱不堪',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EASY_NG+',
					ui_name = '更简单的 NG+',
					ui_description = '降低 NG+ 的难度......各方面',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_PERKS',
			ui_name = '天赋设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'TRUE_POWER_OF_UNLIMITED_SPELLS',
					ui_name = '[ 无限法术 ] 力量解放',
					ui_description =
						'令 [ 无限法术 ] 天赋对此模组、位于此模组加载前加载的模组\n'
						.. '以及原版 Noita 中包含的所有法术均生效',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_SPELLS',
			ui_name = '法术设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'UNLOCK_ALL_SPELL',
					ui_name = '法术无需解锁',
					ui_description = '所有法术无需解锁即可生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'SPELL_ALL_EQUAL',
					ui_name = '法术等可能生成',
					ui_description = '所有已解锁法术以相同概率在每个法术等级生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BOMB',
					ui_name = '效果更改: 炸弹',
					ui_description =
						'增加 [ 炸弹 ] 法术的最大使用次数'
						.. '对 [ 粘性炸弹 ] 与 [ 弹性炸弹 ] 法术也生效',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_BLACKHOLE_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发黑洞',
					ui_description =
						'将 [ 带有失效触发的黑洞 ] 法术图标的角标\n'
						.. b1 .. '从 [ 定时 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT',
					ui_name = '效果更改: 泡泡火花',
					ui_description = '[ 泡泡火花 ] 法术的效果现在符合其法术图标',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT_TRIGGER',
					ui_name = '效果更改: 触发泡泡火花',
					ui_description = '[ 带有触发的泡泡火花 ] 法术的效果现在符合其法术图标',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_MINE_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发不稳晶体',
					ui_description =
						'将 [ 带有失效触发的不稳晶体 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_PIPE_BOMB_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发休眠晶体',
					ui_description =
						'将 [ 带有失效触发的休眠晶体 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_SUMMON_EGG_DEATH_TRIGGER',
					ui_name = '图标更改: 召唤失效触发蛋',
					ui_description =
						'将 [ 召唤带有失效触发的蛋 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_ENEMIES',
			ui_name = '敌怪设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'SPAWN_MANY_ENEMIES',
					ui_name = '刷怪+',
					ui_description = '刷怪率大幅提升',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'NO_KUMMITUS',
					ui_name = '再无幻影',
					ui_description = '历史幻象不再生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_CURSES',
			ui_name = '诅咒设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					ui_name =
						'如果你正在寻找某种挑战......\n'
						.. b1 .. '那么这就是了',
					not_setting = true,
				},
				{
					id = 'CURSE_MONK',
					ui_name = '和尚',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 和尚 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_ALWAYS_SHUFFLE',
					ui_name = '始终乱序',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 始终乱序 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_SHORT_WAND',
					ui_name = '短杖',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 短杖 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_MALICE_WASHES_OVER',
					ui_name = '邪念冲刷而过',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 邪念冲刷而过 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_REALITY_SHIFT',
					ui_name = '现实变换',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 现实变换 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GUARANTEED_LOSE',
					ui_name = '“保送”',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: “保送” ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GRAVITY_FREE',
					ui_name = '力场解放',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 力场解放 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_DEATH_TRAIL',
					ui_name = '死亡轨迹',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 死亡轨迹 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},--[[
				{
					id = 'CURSE_FURIOUS_COCKTAIL',
					ui_name = '狂乱的鸡尾酒',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 狂乱的鸡尾酒 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},]]--
			},
		},
		{
			category_id = 'SETTINGS_VISIONS',
			ui_name = '视觉设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'VISION_IMPROVE',
					ui_name = '视野提升',
					ui_description = '150% 视野宽高',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'REMOVE_LOW_HP_FLASH',
					ui_name = '移除闪屏',
					ui_description = '低生命值时不再闪烁屏幕警告',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_BUGS_AND_CHEESE',
			ui_name = '漏洞 & 轮椅设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'BUGFIX_SPELL_TO_POWER',
					ui_name = '漏洞修复: 法转力',
					ui_description = '修复 [ 法术变力量 ] 法术在特定状况下导致游戏崩溃的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_WORMRAIN',
					ui_name = '漏洞修复: 蠕虫雨刷血',
					ui_description = '修复通过 [ 蠕虫雨 ] 法术无限刷取追加生命上限的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_HEARTY',
					ui_name = '漏洞修复: 心绞痛刷血',
					ui_description = '修复通过 [ 心绞痛 ] 状态永久增加生命上限的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE',
					ui_name = '漏洞修复: 易伤刷抗性',
					ui_description = '修复通过 [ 易伤 ] 状态永久降低承伤系数的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_CONNOISSEUR_OF_WANDS',
					ui_name = '漏洞修复: 魔杖鉴赏家',
					ui_description = '修复通过 [ 狂暴魔药 ] 等方式极其简单地击败魔杖鉴赏家的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_HAND_OF_MASTER',
					ui_name = '漏洞修复: 法师之手',
					ui_description = '修复隔空控制物品移动的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHEESE_CHANGE_CHAINSAW',
					ui_name = '轮椅更改: 链锯',
					ui_description = '作为施法延迟变成 0 的代替, 链锯现在 -30 帧施法延迟',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = '命令反馈',
			ui_description = '命令法术将会在左下角反馈执行状态',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'SVAROG_TRANSLATION',
			ui_name = '翻译: 伊芙琳娜',
			ui_description = '将部分生物的名称替换为与 伊芙琳娜 相关的文本',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
	}
else
	mod_settings = {
		{
			category_id = 'EMPTY_MOD_SETTINGS_INTRODUCTION',
			ui_name = 'Some Messages',
			foldable = true,
			_folded = true,
			settings = {
				{
					category_id = 'SP_THANKS',
					ui_name = 'Special thanks ( rankings are not in particular order )',
					foldable = true,
					_folded = false,
					settings = {
						{
							category_id = 'WHITELEAF',
							ui_name = 'WhiteLeaf',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Redraw some spell icons',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SHUG',
							ui_name = 'shug',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SLPAUS',
							ui_name = 'SlpAus',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'IMMORTALDAMNED',
							ui_name = 'ImmortalDamned',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'TANKSY',
							ui_name = 'Tanksy',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Developer of Sellhole, grant permission to adapt his mod into spell form',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'PICKLEDSOSIG',
							ui_name = 'PickledSosig',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name =
										'Developer of Mega Perk Pack, grant highest level of permission to adapt\n'
										..	b1 .. 'his mod with modifications',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							ui_name =
								'Blackhole catgirl heavily recommend also trying aforementioned\n'
								..	b1 .. "developers' mods on Workshop!",
							not_setting = true,
						},
					},
					not_setting = true,
				},
			},
			not_setting = true,
		},
		{
			category_id = 'SETTINGS_WORLDS',
			ui_name = 'Settings about Worlds',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'STARTING_EDIT',
					ui_name = 'Starting Edit',
					ui_description = 'Generates a wand editing area in Mountain Hall to right of spawn point',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'TELEPORT_TO_PYRAMID',
					ui_name = 'Pyramid Teleport',
					ui_description = 'Generates a portal to top of Pyramid above spawn point',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHAOS_CONNECTED_WORLD',
					ui_name = 'Thoroughfare',
					ui_description =
						'Adds numerous passages between biomes\n'
						.. 'but making area chaotic',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EASY_NG+',
					ui_name = 'Easier NG+',
					ui_description = 'Lower NG+ difficulty... in every way',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_PERKS',
			ui_name = 'Settings about Perks',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'TRUE_POWER_OF_UNLIMITED_SPELLS',
					ui_name = 'True Power of [ Unlimited Spells ]',
					ui_description =
						'Make [ Unlimited Spells ] perk effective for all spells in this mod,\n'
						.. 'mods loaded before this mod, and vanilla Noita',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_SPELLS',
			ui_name = 'Settings about Spells',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'UNLOCK_ALL_SPELL',
					ui_name = 'No Need Unlock Spells',
					ui_description = 'All spells can spawn without needing to be unlocked',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'SPELL_ALL_EQUAL',
					ui_name = 'Spells Spawn with Equal Chance',
					ui_description = 'All unlocked spells have equal chance to spawn at every spell level',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BOMB',
					ui_name = 'Effect Change: Bomb',
					ui_description =
						'increase max uses of [ Bomb ] spell'
						.. 'also affect [ Sticky bomb ] and [ Bouncy bomb ] spell',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_BLACKHOLE_DEATH_TRIGGER',
					ui_name = 'Icon Change: Blackhole with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Blackhole with death trigger ]\n'
						.. b1 .. 'from [ Timer ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT',
					ui_name = 'Effect Change: Bubble Spark',
					ui_description = 'Effect of [ Bubble spark ] spell now matches its icon',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT_TRIGGER',
					ui_name = 'Effect Change: Bubble Spark with Trigger',
					ui_description = 'Effect of [ Bubble spark with trigger ] spell now matches its icon',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_MINE_DEATH_TRIGGER',
					ui_name = 'Icon Change: Unstable Crystal with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Unstable Crystal with Death Trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_PIPE_BOMB_DEATH_TRIGGER',
					ui_name = 'Icon Change: Dormant Crystal with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Dormant Crystal with Death Trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_SUMMON_EGG_DEATH_TRIGGER',
					ui_name = 'Icon Change: Summon Egg with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Summon egg with death trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_ENEMIES',
			ui_name = 'Settings about Enemies',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'SPAWN_MANY_ENEMIES',
					ui_name = 'Enemy Spawn Rate+',
					ui_description = 'Enemy spawn rate is greatly increased',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'NO_KUMMITUS',
					ui_name = 'No More Illusions',
					ui_description = "Kummitus don't spawn any more",
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_CURSES',
			ui_name = 'Settings about CURSEs',
			foldable = true,
			_folded = true,
			settings = {
				{
					ui_name =
						'If you are looking for some challenges......\n'
						.. b1 .. 'then this is it',
					not_setting = true,
				},
				{
					id = 'CURSE_MONK',
					ui_name = 'Monk',
					ui_description = 'At beginning of new round of game, you get [ Curse: Monk ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_ALWAYS_SHUFFLE',
					ui_name = 'Always Shuffle',
					ui_description = 'At beginning of new round of game, you get [ Curse: Always Shuffle ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_SHORT_WAND',
					ui_name = 'Short Wand',
					ui_description = 'At beginning of new round of game, you get [ Curse: Short Wand ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_MALICE_WASHES_OVER',
					ui_name = 'Malice Washes Over',
					ui_description = 'At beginning of new round of game, you get [ Curse: Malice Washes Over ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_REALITY_SHIFT',
					ui_name = 'Reality Shift',
					ui_description = 'At beginning of new round of game, you get [ Curse: Reality Shift ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GUARANTEED_LOSE',
					ui_name = '“Guaranteed Win”',
					ui_description = 'At beginning of new round of game, you get [ Curse: “Guaranteed Win” ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GRAVITY_FREE',
					ui_name = 'Force Field Liberation',
					ui_description = 'At beginning of new round of game, you get [ Curse: Force Field Liberation ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_DEATH_TRAIL',
					ui_name = 'Death Trail',
					ui_description = 'At beginning of new round of game, you get [ Curse: Death Trail ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},--[[
				{
					id = 'CURSE_FURIOUS_COCKTAIL',
					ui_name = 'Furious Cocktail',
					ui_description = 'At beginning of new round of game, you get [ Curse: Furious Cocktail ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},]]--
			},
		},
		{
			category_id = 'SETTINGS_VISIONS',
			ui_name = 'Settings about Visions',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'VISION_IMPROVE',
					ui_name = 'Vision Improve',
					ui_description = '150% vision width and height',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'REMOVE_LOW_HP_FLASH',
					ui_name = 'Remove Screen Flash',
					ui_description = 'No longer flash screen warning when at low health',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_BUGS_AND_CHEESE',
			ui_name = 'Settings about Bugs & Cheeses',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'BUGFIX_SPELL_TO_POWER',
					ui_name = 'Bugfix: Spells to Power',
					ui_description = 'Fix crash caused by [ Spells to Power ] under certain conditions',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_WORMRAIN',
					ui_name = 'Bugfix: Worm Rain HP Dupe',
					ui_description = 'Fix infinite max health dupe through [ Worm Rain ] spell',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_HEARTY',
					ui_name = 'Bugfix: Heartache HP Dupe',
					ui_description = 'Fix permanent max health increase dupe through [ Heartache ] status',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE',
					ui_name = 'Bugfix: Vulnerable Resistance Dupe',
					ui_description = 'Fix permanent damage multiplier reduction dupe through [ Vulnerable ] status',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_CONNOISSEUR_OF_WANDS',
					ui_name = 'Bugfix: Connoisseur of Wands',
					ui_description = 'Fix exploit of defeating Connoisseur of Wands extremely easily via [ Berserkium ] etc.',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_HAND_OF_MASTER',
					ui_name = 'Bugfix: Hand of Master',
					ui_description = 'Fix exploit of moving items from distance',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHEESE_CHANGE_CHAINSAW',
					ui_name = 'Cheese Change: Chainsaw',
					ui_description = 'Instead of setting fire rate wait to 0, Chainsaw now -30 frames fire rate wait',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = 'Command Feedback',
			ui_description = 'Command spells will display execution feedback at bottom-left',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'SVAROG_TRANSLATION',
			ui_name = 'Translation: Svarog',
			ui_description =
				'Replace some of creatures names with text related to Svarog\n\n'
				.. 'this setting is useless for you, reason:\n'
				.. b1 .. 'Svarog is a chinese Noita streamer\n'
				.. b1 .. 'this setting only replace some chinese translations of his jokes',
			value_default = false,
			scope = MOD_SETTING_SCOPE_ONLY_SET_DEFAULT,
		},
	}
end

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount( )
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end

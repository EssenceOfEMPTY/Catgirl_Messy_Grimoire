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
					ui_name = '特别感谢',
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
									ui_name = '为一些神奇实现提供代码支持',
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
			id = 'VISION_IMPROVE',
			ui_name = '视野提升',
			ui_description = '150% 视野宽高',
			value_default = true,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
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
			id = 'UNLIMITED_SPELLS',
			ui_name = '[ 无限法术 ] 力量解放',
			ui_description = '令 [ 无限法术 ] 天赋对此模组、位于此模组加载前加载的模组以及原版 Noita 中包含的所有法术均生效',
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = '命令反馈',
			ui_description = '命令法术将会在左下角反馈执行状态',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'NO_KUMMITUS',
			ui_name = '再无幻影',
			ui_description = '历史幻象不再生成',
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'SPAWN_MANY_ENEMIES',
			ui_name = '刷怪+',
			ui_description = '刷怪率大幅提升',
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'YIFULINNA_TRANSLATION',
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
					ui_name = 'Special thanks:',
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
									ui_name = 'Provide code support for some magical implementations',
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
								'Blackhole catgirl heavely recommend also trying aforementioned\n'
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
			id = 'VISION_IMPROVE',
			ui_name = 'Vision Improve',
			ui_description = '150% vision width and height',
			value_default = true,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
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
			id = 'UNLIMITED_SPELLS',
			ui_name = 'True Power of [ Unlimited Spells ]',
			ui_description = 'Make [ Unlimited Spells ] perk effective for all spells in this mod, mods loaded before this mod, and vanilla Noita',
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = 'Command Feedback',
			ui_description = 'Command spells will display execution feedback at bottom-left',
			value_default = false,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'NO_KUMMITUS',
			ui_name = 'No More Illusions',
			ui_description = "Kummitus don't spawn any more",
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'SPAWN_MANY_ENEMIES',
			ui_name = 'Enemy Spawn Rate+',
			ui_description = 'Enemy spawn rate is greatly increased',
			value_default = false,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
		{
			id = 'YIFULINNA_TRANSLATION',
			ui_name = 'No',
			ui_description = 'This setting is useless for you',
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

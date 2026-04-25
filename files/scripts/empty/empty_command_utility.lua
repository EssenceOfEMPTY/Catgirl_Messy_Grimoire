dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local chunk_length = 512

local DELY_EXPR_PREFIX = '::__DELAY_EXP__::'
local FUNC_CALL_PREFIX = '__FUNC_CALL__::'
local ARGS_SEPA_PREFIX = '::__ARGS_SEPA__::'

e_cmd_funcs = {
	random_get = {
		max_paras = 1,
		transform_tilde_into = {
			para_1 = {
				'table',
			},
		},
		---从 < NUMBER[ ] > 中随机选择 1 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param extract string|number[]
		---@return string|number value
		action_1_paras = function ( c, reflect, shooter, extract )
			local command = 'random_get'

			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( type( extract ) ~= 'table' ) then
					extract = { }
				end

				if ( #extract > 0 ) then
					local value = random_gets( extract, 1 )[ 1 ]

					command_print( command .. '(', '$empty_command_random_get_success', tostring( value ) )
					return value
				else
					command_print( command .. '(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end,
	},
	get_first = {
		max_paras = 2,
		transform_tilde_into = {
			para_1 = {
				'table',
			},
			para_2 = {
				'table',
				'1',
			},
		},
		---从 < NUMBER[ ] > 中选择顺数第 1 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param extract string|number[]
		---@return string|number value
		action_1_paras = function ( c, reflect, shooter, extract )
			return e_cmd_funcs[ 'get_first' ].action_2_paras( { }, reflect, shooter, extract, 1 )
		end,
		---从 < NUMBER[ ] > 中选择顺数第 No 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param extract string|number[]
		---@param No string|number
		---@return string|number value
		action_2_paras = function ( c, reflect, shooter, extract, No )
			local command = 'get_first'

			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end
			if ( type( No ) ~= 'number' and type( No ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( No ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( #extract > 0 ) then
					if ( No > #extract ) then
						command_print( command .. '(', '$empty_command_error_index_out_of_range', tostring( No ), tostring( #extract ) )
					else
						local value = extract[ No ]

						command_print( command .. '(', '$empty_command_get_first_success', tostring( No ), tostring( value ) )
						return value
					end
				else
					command_print( command .. '(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end,
	},
	get_last = {
		max_paras = 2,
		transform_tilde_into = {
			para_1 = {
				'table',
			},
			para_2 = {
				'table',
				'1',
			},
		},
		---从 < NUMBER[ ] > 中选择倒数第 1 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param extract string|number[]
		---@return string|number value
		action_1_paras = function ( c, reflect, shooter, extract )
			return e_cmd_funcs[ 'get_last' ].action_2_paras( { }, reflect, shooter, extract, 1 )
		end,
		---从 < NUMBER[ ] > 中选择倒数第 No 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param extract string|number[]
		---@param No string|number
		---@return string|number value
		action_2_paras = function ( c, reflect, shooter, extract, No )
			local command = 'get_last'

			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end
			if ( type( No ) ~= 'number' and type( No ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( No ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( #extract > 0 ) then
					if ( No > #extract ) then
						command_print( command .. '(', '$empty_command_error_index_out_of_range', tostring( No ), tostring( #extract ) )
					else
						local value = extract[ #extract - No + 1 ]

						command_print( command .. '(', '$empty_command_get_last_success', tostring( No ), tostring( value ) )
						return value
					end
				else
					command_print( command .. '(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end,
	},
	variable_get = {
		max_paras = 1,
		transform_tilde_into = {
			para_1 = {
				'0',
			},
		},
		---获取变量编号为 variable_number 的值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param v_No string|number
		---@return string|number variable_value
		action_1_paras = function ( c, reflect, shooter, v_No )
			local command = 'variable_get'

			if ( type( v_No ) ~= 'number' and type( v_No ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_No ) )
				return 0
			end

			local v_value = 0

			if ( reflect or type( v_No ) == 'number' ) then
				v_value = tonumber( GlobalsGetValue( 'EMPTY_COMMAND_VARIABLE_' .. tostring( v_No ), '0' ) ) or 0

				command_print( command .. '(', '$empty_command_variable_get_success', tostring( v_No ), tostring( v_value ) )
			end

			return v_value
		end,
	},
	variable_set = {
		max_paras = 2,
		transform_tilde_into = {
			para_2 = {
				'0',
				'0',
			},
		},
		---设置变量编号为 variable_number 的值为 variable_value
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param v_No string|number
		---@param v_value string|number
		---@return string|number set_value
		action_2_paras = function ( c, reflect, shooter, v_No, v_value )
			local command = 'variable_set'

			if ( type( v_No ) ~= 'number' and type( v_No ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_No ) )
				return 0
			end
			if ( type( v_value ) ~= 'number' and type( v_value ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_value ) )
				return 0
			end

			if ( reflect or ( type( v_No ) == 'number' and type( v_value ) == 'number' ) ) then
				GlobalsSetValue( 'EMPTY_COMMAND_VARIABLE_' .. tostring( v_No ), tostring( v_value ) )

				command_print( command .. '(', '$empty_command_variable_set_success', tostring( v_No ), tostring( v_value ) )
			end

			return v_value
		end,
	},
	min = {
		max_paras = 2,
		transform_tilde_into = {
			para_1 = {
				'table',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---返回 num_table 中的最小值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param num_table string|number[]
		---@return string|number
		action_1_paras = function ( c, reflect, shooter, num_table )
			local command = 'min'

			if ( type( num_table ) ~= 'table' and type( num_table ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( num_table ) )
				return 0
			end

			local min = 0

			if ( reflect or type( num_table ) == 'table' ) then
				if ( type( num_table ) ~= 'table' ) then
					num_table = { }
				end

				if ( #num_table == 0 ) then
					command_print( command .. '(', '$empty_command_error_empty_table' )
				elseif ( #num_table == 1 ) then
					min = num_table[ 1 ]
				else
					min = math.huge

					for _, each in ipairs( num_table ) do
						if ( each < min ) then
							min = each
						end
					end
				end
			end

			return min
		end,
		---返回 num1 与 num2 之中的较小值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param num1 string|number
		---@param num2 string|number
		---@return string|number
		action_2_paras = function ( c, reflect, shooter, num1, num2 )
			local command = 'min'

			if ( type( num1 ) ~= 'number' and type( num1 ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num1 ) )
				return 0
			end
			if ( type( num2 ) ~= 'number' and type( num2 ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num2 ) )
				return 0
			end

			if ( reflect or ( type( num1 ) == 'number' and type( num2 ) == 'number' ) ) then
				if ( type( num1 ) ~= 'number' ) then
					num1 = math.huge
				end
				if ( type( num2 ) ~= 'number' ) then
					num2 = math.huge
				end

				return math.min( num1, num2 )
			else
				return 0
			end
		end,
	},
	max = {
		max_paras = 2,
		transform_tilde_into = {
			para_1 = {
				'table',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---返回 num_table 中的最大值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param num_table string|number[]
		---@return string|number
		action_1_paras = function ( c, reflect, shooter, num_table )
			local command = 'max'

			if ( type( num_table ) ~= 'table' and type( num_table ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( num_table ) )
				return 0
			end

			local max = 0

			if ( reflect or type( num_table ) == 'table' ) then
				if ( type( num_table ) ~= 'table' ) then
					num_table = { }
				end

				if ( #num_table == 0 ) then
					command_print( command .. '(', '$empty_command_error_empty_table' )
				elseif ( #num_table == 1 ) then
					max = num_table[ 1 ]
				else
					max = -math.huge

					for _, each in ipairs( num_table ) do
						if ( each > max ) then
							max = each
						end
					end
				end
			end

			return max
		end,
		---返回 num1 与 num2 之中的较大值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param num1 string|number
		---@param num2 string|number
		---@return string|number
		action_2_paras = function ( c, reflect, shooter, num1, num2 )
			local command = 'max'

			if ( type( num1 ) ~= 'number' and type( num1 ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num1 ) )
				return 0
			end
			if ( type( num2 ) ~= 'number' and type( num2 ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num2 ) )
				return 0
			end

			if ( reflect or ( type( num1 ) == 'number' and type( num2 ) == 'number' ) ) then
				if ( type( num1 ) ~= 'number' ) then
					num1 = -math.huge
				end
				if ( type( num2 ) ~= 'number' ) then
					num2 = -math.huge
				end

				return math.max( num1, num2 )
			else
				return 0
			end
		end,
	},
	lifetime_set = {
		max_paras = 1,
		para_names = {
			all = {
				'lifetime',
			},
			para_1 = {
				'lifetime',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
		},
		---将投射物中 lifetime 组件的 lifetime 属性设为参数值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param lifetime string|number
		---@return string|number lifetime
		action_1_paras = function ( c, reflect, shooter, lifetime )
			local command = 'lifetime_set'

			if ( type( lifetime ) ~= 'number' and type( lifetime ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( lifetime ) )
				return 0
			end

			if ( reflect ) then
				if ( type( lifetime ) ~= 'number' ) then
					lifetime = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'LifetimeComponent', nil, {
					lifetime = lifetime,
				}, nil )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					lifetime = lifetime,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return lifetime
		end,
	},
	projectile_lifetime_set = {
		max_paras = 1,
		para_names = {
			all = {
				'lifetime',
			},
			para_1 = {
				'lifetime',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
		},
		---将投射物中 投射物 组件的 lifetime 属性设为参数值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param lifetime string|number
		---@return string|number lifetime
		action_1_paras = function ( c, reflect, shooter, lifetime )
			local command = 'projectile_lifetime_set'

			if ( type( lifetime ) ~= 'number' and type( lifetime ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( lifetime ) )
				return 0
			end

			if ( reflect ) then
				if ( type( lifetime ) ~= 'number' ) then
					lifetime = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'ProjectileComponent', nil, {
					lifetime = lifetime,
				}, nil )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					lifetime = lifetime,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$')
			end

			return lifetime
		end,
	},
	projectile_speed_set = {
		max_paras = 2,
		para_names = {
			all = {
				'speed',
				'vel_x',
				'vel_y',
			},
			para_1 = {
				'speed',
			},
			para_2 = {
				'vel_x',
				'vel_y',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---投射物已发射的场合: 在保持方向的状态下将 速度 组件中的 vel_x, vel_y 的模更改为 speed; 
		---投射物未发射的场合: 将投射物中 投射物 组件的 speed_min 与 speed_max 设为 speed; 
		---负值将会反转速度方向
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param speed string|number
		---@return string|number speed
		action_1_paras = function ( c, reflect, shooter, speed )
			local command = 'projectile_speed_set'
			local command_shot_speed = command .. '_shot_speed'

			if ( type( speed ) ~= 'number' and type( speed ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( speed ) )
				return 0
			end

			if ( reflect ) then
				if ( type( speed ) ~= 'number' ) then
					speed = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				remove_speed_limit( entity )

				local count = set_comp_value( entity, 'VelocityComponent', nil, {
					speed_min = speed,
					speed_max = speed,
				}, nil )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_shot_speed, {
					_tags = command_shot_speed,
					value_float = speed,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_shot_speed, {
					_tags = command_shot_speed,
					script_shot = empty_path .. 'scripts/projectiles/command/' .. command_shot_speed .. '.lua',
					remove_after_executed = true,
				} )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = false,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					speed = speed,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return speed
		end,
		---将投射物中 速度 组件中的 vel_x, vel_y 属性分别更改为 vel_x, vel_y
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param vel_x string|number
		---@param vel_y string|number
		---@return table vel_xy
		action_2_paras = function ( c, reflect, shooter, vel_x, vel_y )
			local command = 'projectile_speed_set'
			local command_shot_velxy = command .. '_shot_velxy'

			if ( type( vel_x ) ~= 'number' and type( vel_x ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( vel_x ) )
				return { 0, 0 }
			end
			if ( type( vel_y ) ~= 'number' and type( vel_y ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( vel_y ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( vel_x ) ~= 'number' ) then
					vel_x = 0
				end
				if ( type( vel_y ) ~= 'number' ) then
					vel_y = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local speed = math.sqrt( vel_x ^ 2, vel_y ^ 2 )

				remove_speed_limit( entity )

				local count = set_comp_value( entity, 'VelocityComponent', nil, {
					speed_min = speed,
					speed_max = speed,
				}, nil )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_shot_velxy, {
					_tags = command_shot_velxy,
					value_float = speed,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_shot_velxy, {
					_tags = command_shot_velxy,
					script_shot = empty_path .. 'scripts/projectiles/command/' .. command_shot_velxy .. '.lua',
					remove_after_executed = true,
				} )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = false,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					vel_x = vel_x,
					vel_y = vel_y,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { vel_x, vel_y }
		end,
	},
	projectile_gravity_set = {
		max_paras = 2,
		para_names = {
			all = {
				'gravity_y',
				'gravity_x',
			},
			para_1 = {
				'gravity_y',
			},
			para_2 = {
				'gravity_y',
				'gravity_x',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---将投射物中 速度 组件的 gravity_y 属性设为 gravity_y
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param gravity_y string|number
		---@return string|number gravity
		action_1_paras = function ( c, reflect, shooter, gravity_y )
			local command = 'projectile_gravity_set'

			if ( type( gravity_y ) ~= 'number' and type( gravity_y ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_y ) )
				return 0
			end

			if ( reflect ) then
				if ( type( gravity_y ) ~= 'number' ) then
					gravity_y = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'VelocityComponent', nil, {
					gravity_y = gravity_y,
				}, nil )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					gravity_y = gravity_y,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return gravity_y
		end,
		---将投射物中 速度 组件的 gravity_y 属性设为 gravity_y, gravity_x 属性设为 gravity_x
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param gravity_y string|number
		---@param gravity_x string|number
		---@return table gravity_yx
		action_2_paras = function ( c, reflect, shooter, gravity_y, gravity_x )
			local command = 'projectile_gravity_set'

			if ( type( gravity_y ) ~= 'number' and type( gravity_y ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_y ) )
				return { 0, 0 }
			end
			if ( type( gravity_x ) ~= 'number' and type( gravity_x ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_x ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( gravity_y ) ~= 'number' ) then
					gravity_y = 0
				end
				if ( type( gravity_x ) ~= 'number' ) then
					gravity_x = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'VelocityComponent', nil, {
					gravity_y = gravity_y,
					gravity_x = gravity_x,
				} )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					gravity_y = gravity_y,
					gravity_x = gravity_x,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { gravity_y, gravity_x }
		end,
	},
	projectile_air_friction_set = {
		max_paras = 1,
		para_names = {
			all = {
				'air_friction',
			},
			para_1 = {
				'air_friction',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
		},
		---将投射物中 速度 组件的 air_friction 属性设为参数值
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param air_friction string|number
		---@return string|number air_friction
		action_1_paras = function ( c, reflect, shooter, air_friction )
			local command = 'projectile_air_friction_set'

			if ( type( air_friction ) ~= 'number' and type( air_friction ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( air_friction ) )
				return 0
			end

			if ( reflect ) then
				if ( type( air_friction ) ~= 'number' ) then
					air_friction = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'VelocityComponent', nil, {
					air_friction = air_friction,
				} )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					air_friction = air_friction,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return air_friction
		end,
	},
	projectile_shoot_angle_add = {
		max_paras = 2,
		para_names = {
			all = {
				'angle',
				'angle_delay',
				'delay',
			},
			para_1 = {
				'angle',
			},
			para_2 = {
				'angle_delay',
				'delay',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			local command = 'projectile_shoot_angle_add'
			local command_shot = command .. '_shot'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_shot, {
					_tags = command_shot,
					value_float = angle,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_shot, {
					_tags = command_shot,
					script_shot = empty_path .. 'scripts/projectiles/command/' .. command_shot .. '.lua',
					remove_after_executed = true,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return angle
		end,
		---经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param delay string|number
		---@return table angle_delay
		action_2_paras = function ( c, reflect, shooter, angle_delay, delay )
			local command = 'projectile_shoot_angle_add'
			local command_delay = command .. '_delay'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_float = angle_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_delay, {
					_tags = command_delay,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_delay .. '.lua',
					execute_every_n_frame = delay,
					remove_after_executed = true,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					delay = delay,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, delay }
		end,
	},
	projectile_shoot_angle_set = {
		max_paras = 2,
		para_names = {
			all = {
				'angle',
				'angle_delay',
				'delay',
			},
			para_1 = {
				'angle',
			},
			para_2 = {
				'angle_delay',
				'delay',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
		},
		---在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			local command = 'projectile_shoot_angle_set'
			local command_shot = command .. '_shot'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_shot, {
					_tags = command_shot,
					value_float = angle,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_shot, {
					_tags = command_shot,
					script_shot = empty_path .. 'scripts/projectiles/command/' .. command_shot .. '.lua',
					remove_after_executed = true,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return angle
		end,
		---在经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param delay string|number
		---@return table angle_delay
		action_2_paras = function ( c, reflect, shooter, angle_delay, delay )
			local command = 'projectile_shoot_angle_set'
			local command_delay = command .. '_delay'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_float = angle_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_delay, {
					_tags = command_delay,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_delay .. '.lua',
					execute_every_n_frame = delay,
					remove_after_executed = true,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					delay = delay,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, delay }
		end,
	},
	projectile_spread_set = {
		max_paras = 1,
		para_names = {
			all = {
				'angle',
			},
			para_1 = {
				'angle',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
		},
		---将投射物的出射散射设为 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			local command = 'projectile_arc_add'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local count = set_comp_value( entity, 'ProjectileComponent', nil, {
					direction_random_rad = deg_to_rad( angle ),
				}, nil )

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( command .. '(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return angle
		end,
	},
	projectile_arc_add = {
		max_paras = 4,
		para_names = {
			all = {
				'angle',
				'inc',
				'angle_delay',
				'inc_delay',
				'delay',
				'duration',
			},
			para_1 = {
				'angle',
			},
			para_2 = {
				'angle',
				'inc',
			},
			para_3 = {
				'angle_delay',
				'inc_delay',
				'delay',
			},
			para_4 = {
				'angle_delay',
				'inc_delay',
				'delay',
				'duration',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
			para_3 = {
				'0',
				'0',
				'0',
			},
			para_4 = {
				'0',
				'0',
				'0',
				'0',
			},
		},
		---在不更改速度大小的状态下将速度方向在原基础上每帧逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			local command = 'projectile_arc_add'
			local command_reflect = command .. '_reflect'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_reflect, {
					_tags = command_reflect,
					value_int = 0,
					value_string = tostring( angle ),
					value_float = 0,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_reflect, {
					_tags = command_reflect,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_reflect .. '.lua',
					execute_every_n_frame = 0,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return angle
		end,
		---在不更改速度大小的状态下将速度方向在原基础上每帧逆时针旋转 ( angle + 生效帧数 * inc )°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return table angle
		action_2_paras = function ( c, reflect, shooter, angle, inc )
			local command = 'projectile_arc_add'
			local command_reflect = command .. '_reflect'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return { 0, 0 }
			end
			if ( type( inc ) ~= 'number' and type( inc ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end
				if ( type( inc ) ~= 'number' ) then
					inc = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_reflect, {
					_tags = command_reflect,
					value_int = 0,
					value_string = tostring( angle ),
					value_float = inc,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_reflect, {
					_tags = command_reflect,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_reflect .. '.lua',
					execute_every_n_frame = 0,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
					inc = inc,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle, inc }
		end,
		---经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 ( angle_delay + 生效帧数 * inc_delay )°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param inc_delay string|number
		---@param delay string|number
		---@return table angle_inc_delay
		action_3_paras = function ( c, reflect, shooter, angle_delay, inc_delay, delay )
			local command = 'projectile_arc_add'
			local command_delay = command .. '_delay'
			local command_trigger = command_delay .. '_trigger'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0, 0 }
			end
			if ( type( inc_delay ) ~= 'number' and type( inc_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc_delay ) )
				return { 0, 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( inc_delay ) ~= 'number' ) then
					inc_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_int = 0,
					value_string = tostring( angle_delay ),
					value_float = inc_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_delay, {
					_tags = command_trigger,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_trigger .. '.lua',
					execute_every_n_frame = delay,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					inc_delay = inc_delay,
					delay = delay,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, inc_delay, delay }
		end,
		---经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 ( angle_delay + 生效帧数 * inc_delay )°; 
		---此效果持续 duration 帧
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param inc_delay string|number
		---@param delay string|number
		---@param duration string|number
		---@return table angle_inc_delay_duration
		action_4_paras = function ( c, reflect, shooter, angle_delay, inc_delay, delay, duration )
			local command = 'projectile_arc_add'
			local command_delay = command .. '_delay'
			local command_trigger = command_delay .. '_trigger'
			local command_death = command_delay .. '_death'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( inc_delay ) ~= 'number' and type( inc_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc_delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( duration ) ~= 'number' and type( duration ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( duration ) )
				return { 0, 0, 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( inc_delay ) ~= 'number' ) then
					inc_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end
				if ( type( duration ) ~= 'number' ) then
					duration = 0
				elseif ( duration % 1 ~= 0 ) then
					duration = math.floor( duration )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_int = 0,
					value_string = tostring( angle_delay ),
					value_float = inc_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_trigger, {
					_tags = command_trigger,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_trigger .. '.lua',
					execute_every_n_frame = delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_death, {
					_tags = command_death,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_death .. '.lua',
					execute_every_n_frame = delay + duration,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					inc_delay = inc_delay,
					delay = delay,
					duration = duration,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, inc_delay, delay, duration }
		end,
	},
	projectile_arc_set = {
		max_paras = 4,
		para_names = {
			all = {
				'angle',
				'inc',
				'angle_delay',
				'inc_delay',
				'delay',
				'duration',
			},
			para_1 = {
				'angle',
			},
			para_2 = {
				'angle',
				'inc',
			},
			para_3 = {
				'angle_delay',
				'inc_delay',
				'delay',
			},
			para_4 = {
				'angle_delay',
				'inc_delay',
				'delay',
				'duration',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0',
			},
			para_2 = {
				'0',
				'0',
			},
			para_3 = {
				'0',
				'0',
				'0',
			},
			para_4 = {
				'0',
				'0',
				'0',
				'0',
			},
		},
		---在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			local command = 'projectile_arc_set'
			local command_reflect = command .. '_reflect'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_reflect, {
					_tags = command_reflect,
					value_int = 0,
					value_string = tostring( angle ),
					value_float = 0,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_reflect, {
					_tags = command_reflect,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_reflect .. '.lua',
					execute_every_n_frame = 0,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return angle
		end,
		---在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 ( angle + 生效帧数 * inc )°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@param inc string|number
		---@return table angle
		action_2_paras = function ( c, reflect, shooter, angle, inc )
			local command = 'projectile_arc_set'
			local command_reflect = command .. '_reflect'

			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return { 0, 0 }
			end
			if ( type( inc ) ~= 'number' and type( inc ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end
				if ( type( inc ) ~= 'number' ) then
					inc = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_reflect, {
					_tags = command_reflect,
					value_int = 0,
					value_string = tostring( angle ),
					value_float = inc,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_reflect, {
					_tags = command_reflect,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_reflect .. '.lua',
					execute_every_n_frame = 0,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle = angle,
					inc = inc,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle, inc }
		end,
		---经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 ( angle_delay + 生效帧数 * inc_delay )°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param inc_delay string|number
		---@param delay string|number
		---@return table angle_inc_delay
		action_3_paras = function ( c, reflect, shooter, angle_delay, inc_delay, delay )
			local command = 'projectile_arc_set'
			local command_delay = command .. '_delay'
			local command_trigger = command_delay .. '_trigger'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0, 0 }
			end
			if ( type( inc_delay ) ~= 'number' and type( inc_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc_delay ) )
				return { 0, 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( inc_delay ) ~= 'number' ) then
					inc_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_int = 0,
					value_string = tostring( angle_delay ),
					value_float = inc_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_trigger, {
					_tags = command_trigger,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_trigger .. '.lua',
					execute_every_n_frame = delay,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					inc_delay = inc_delay,
					delay = delay,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, inc_delay, delay }
		end,
		---经过 delay 帧的延迟后, 在不更改速度大小的状态下将速度方向在正右方基础上每帧逆时针旋转 ( angle_delay + 生效帧数 * inc_delay )°; 
		---此效果持续 duration 帧
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle_delay string|number
		---@param inc_delay string|number
		---@param delay string|number
		---@param duration string|number
		---@return table angle_inc_delay_duration
		action_4_paras = function ( c, reflect, shooter, angle_delay, inc_delay, delay, duration )
			local command = 'projectile_arc_set'
			local command_delay = command .. '_delay'
			local command_trigger = command_delay .. '_trigger'
			local command_death = command_delay .. '_death'

			if ( type( angle_delay ) ~= 'number' and type( angle_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle_delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( inc_delay ) ~= 'number' and type( inc_delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc_delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( delay ) ~= 'number' and type( delay ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( delay ) )
				return { 0, 0, 0, 0 }
			end
			if ( type( duration ) ~= 'number' and type( duration ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( duration ) )
				return { 0, 0, 0, 0 }
			end

			if ( reflect ) then
				if ( type( angle_delay ) ~= 'number' ) then
					angle_delay = 0
				end
				if ( type( inc_delay ) ~= 'number' ) then
					inc_delay = 0
				end
				if ( type( delay ) ~= 'number' ) then
					delay = 0
				elseif ( delay % 1 ~= 0 ) then
					delay = math.floor( delay )
				end
				if ( type( duration ) ~= 'number' ) then
					duration = 0
				elseif ( duration % 1 ~= 0 ) then
					duration = math.floor( duration )
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				add_comp_remove_dupli( entity, 'VariableStorageComponent', command_delay, {
					_tags = command_delay,
					value_int = 0,
					value_string = tostring( angle_delay ),
					value_float = inc_delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_trigger, {
					_tags = command_trigger,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_trigger .. '.lua',
					execute_every_n_frame = delay,
				} )

				add_comp_remove_dupli( entity, 'LuaComponent', command_death, {
					_tags = command_death,
					script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_death .. '.lua',
					execute_every_n_frame = delay + duration,
				} )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					angle_delay = angle_delay,
					inc_delay = inc_delay,
					delay = delay,
					duration = duration,
				}, empty_path .. 'entities/misc/command/' .. command .. '.xml,', '$' )
			end

			return { angle_delay, inc_delay, delay, duration }
		end,
	},
	explode = {
		max_paras = 3,
		para_names = {
			all = {
				'radius',
				'tar',
				'x',
				'y',
			},
			para_2 = {
				'radius',
				'tar',
			},
			para_3 = {
				'radius',
				'x',
				'y',
			},
		},
		transform_tilde_into = {
			para_2 = {
				'100',
				'self',
			},
			para_3 = {
				'100',
				'x',
				'y',
			},
		},
		---生成爆炸 - tar版本
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param radius string|number
		---@param tar string|number|number[]
		---@return string|number radius
		action_2_paras = function ( c, reflect, shooter, radius, tar )
			local command = 'explode'

			if ( type( radius ) ~= 'number' and type( radius ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( radius ) )
				return 0
			end

			if ( reflect ) then
				if ( type( radius ) ~= 'number' ) then
					radius = 0
				end
				if ( type( tar ) == 'number' ) then
					tar = { tar }
				elseif ( type( tar ) ~= 'table' ) then
					tar = { }
				end

				if ( #tar == 0 ) then
					command_print( command .. '(', '$empty_command_error_empty_table' )
					return radius
				end

				local attributes = construct_explode( radius )

				for i, _ in ipairs( tar ) do
					if ( _ ~= NULL_ENTITY and EntityGetIsAlive( _ ) ) then
						local x, y = EntityGetTransform( _ )

						local explode = EntityLoad( empty_path .. 'entities/projectiles/command/' .. command .. '.xml', x, y )

						if ( explode ) then
							local projectile_comp = EntityGetFirstComponent( explode, 'ProjectileComponent' )

							if ( projectile_comp ) then
								for k, v in pairs( attributes ) do
									ComponentObjectSetValue2( projectile_comp, 'config_explosion', k, v )
								end
							end
						end
					end
				end

				command_print( command .. '(', '$empty_command_explode_tar_success', tostring( #tar ), tostring( radius ) )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					radius = radius,
					tar = tar,
				}, nil, '$' )
			end

			return radius
		end,
		---生成爆炸 - xy 版本
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param radius string|number
		---@param x string|number
		---@param y string|number
		---@return string|number radius
		action_3_paras = function ( c, reflect, shooter, radius, x, y )
			local command = 'explode'

			if ( type( radius ) ~= 'number' and type( radius ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( radius ) )
				return 0
			end
			if ( type( x ) ~= 'number' and type( x ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( x ) )
				return 0
			end
			if ( type( y ) ~= 'number' and type( y ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( y ) )
				return 0
			end

			if ( reflect ) then
				if ( type( radius ) ~= 'number' ) then
					radius = 0
				end
				if ( type( x ) ~= 'number' ) then
					x = 0
				end
				if ( type( y ) ~= 'number' ) then
					y = x
				end

				local explode = EntityLoad( empty_path .. 'entities/projectiles/command/' .. command .. '.xml', x, y )

				if ( explode ) then
					local projectile_comp = EntityGetFirstComponent( explode, 'ProjectileComponent' )

					if ( projectile_comp ) then
						local attributes = construct_explode( radius )

						for k, v in pairs( attributes ) do
							ComponentObjectSetValue2( projectile_comp, 'config_explosion', k, v )
						end
					end
				end

				command_print( command .. '(', '$empty_command_explode_xy_success', tostring( x ), tostring( y ), tostring( radius ) )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					radius = radius,
					x = x,
					y = y,
				}, nil, '$' )
			end

			return radius
		end,
	},
	tp = {
		max_paras = 3,
		para_names = {
			all = {
				'tp_entities',
				'tar',
				'x',
				'y',
			},
			para_2 = {
				'tp_entities',
				'tar',
			},
			para_3 = {
				'tp_entities',
				'x',
				'y',
			},
		},
		transform_tilde_into = {
			para_2 = {
				'self',
				'self',
			},
			para_3 = {
				'self',
				'x',
				'y',
			},
		},
		---传送实体 - tar 版本
		---@param c table
		---@param reflect boolean
		---@param tp_entities string|number|number[]
		---@param tar string|number
		---@return string|number tp_count
		action_2_paras = function ( c, reflect, shooter, tp_entities, tar )
			local command = 'tp'

			if ( type( tar ) ~= 'number' and type( tar ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( tar ) )
				return 0
			end

			local count = nil

			if ( reflect ) then
				if ( type( tp_entities ) == 'number' ) then
					tp_entities = { tp_entities }
				elseif ( type( tp_entities ) ~= 'table' ) then
					tp_entities = { }
				end
				if ( type( tar ) ~= 'number' ) then
					tar = 0
				end

				count = 0

				if ( tar ~= NULL_ENTITY and EntityGetIsAlive( tar ) ) then
					local x, y = EntityGetTransform( tar )

					for _, each in ipairs( tp_entities ) do
						if ( EntityGetIsAlive( each ) and not EntityHasTag( each, 'teleportable_NOT' ) ) then
							EntityApplyTransform( each, x, y )

							count = count + 1
						end
					end
				else
					command_print( command .. '(', 'empty_command_tp_error_target_not_found', tostring( tar ) )
				end

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_tp_success', tostring( count ), tostring( x ), tostring( y ) )
				else
					command_print( command .. '(', '$empty_command_tp_error_no_entity_can_tp' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					tp_entities = tp_entities,
					tar = tar,
				}, nil, '$' )

				if ( type( tp_entities ) == 'table' ) then
					count = #tp_entities
				else
					count = tp_entities
				end
			end

			return count
		end,
		---传送实体 - xy 版本
		---@param c table
		---@param reflect boolean
		---@param tp_entities string|number|number[]
		---@param x string|number
		---@param y string|number
		---@return string|number
		action_3_paras = function ( c, reflect, shooter, tp_entities, x, y )
			local command = 'tp'

			if ( type( x ) ~= 'number' and type( x ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', string.upper( type( x ) ) )
				return 0
			end
			if ( type( y ) ~= 'number' and type( y ) ~= 'string' ) then
				command_print( command .. '(', '$empty_command_error_wrong_para_type', 'NUMBER', string.upper( type( y ) ) )
				return 0
			end

			local count = nil

			if ( reflect ) then
				if ( type( tp_entities ) == 'number' ) then
					tp_entities = { tp_entities }
				elseif ( type( tp_entities ) ~= 'table' ) then
					tp_entities = { }
				end
				if ( type( x ) ~= 'number' ) then
					x = 0
				end
				if ( type( y ) ~= 'number' ) then
					y = x
				end

				count = 0

				if ( type( tp_entities ) == 'table' and #tp_entities > 0 ) then
					for _, each in ipairs( tp_entities ) do
						if ( EntityGetIsAlive( each ) and not EntityHasTag( each, 'teleportable_NOT' ) ) then
							EntityApplyTransform( each, x, y )

							count = count + 1
						end
					end
				end

				if ( count > 0 ) then
					command_print( command .. '(', '$empty_command_tp_success', tostring( count ), tostring( x ), tostring( y ) )
				else
					command_print( command .. '(', '$empty_command_tp_error_no_entity_can_tp' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = command,
					shooter = shooter,
					tp_entities = tp_entities,
					x = x,
					y = y,
				}, nil, '$' )

				if ( type( tp_entities ) == "table" ) then
					count = #tp_entities
				else
					count = tp_entities
				end
			end

			return count
		end,
	},
}

---构造爆炸数据
---@param radius number
---@return table explode_attribute
function construct_explode( radius )
	return {
		explosion_radius = radius,
		damage = radius / get_scale( ),
		camera_shake = radius / 10.0,
		create_cell_probability = math.min( 100, 50 + radius / 5 ),
		[ 'physics_explosion_power.min' ] = radius / 5,
		[ 'physics_explosion_power.max' ] = radius / 4,
	}
end

--- '@' 处理器, 仅供解析 @ 使用
---@param token string
---@param token_type string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return number|number[]|nil numbers
local function command_at_handler( token, token_type, shooter, tar_x, tar_y )
	local group, x, y = nil, nil, nil
	if ( token == '@bosses' ) then
		group = EntityGetWithTag( 'boss' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@closest' ) then
		return EntityGetClosest( tar_x, tar_y )
	elseif ( token == '@enemies' ) then
		group = EntityGetWithTag( 'enemy' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@entities' ) then
		group = EntityGetInRadius( 0, 0, math.huge )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@items' ) then
		group = EntityGetWithTag( 'item' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@players' ) then
		group = EntityGetWithTag( 'player_unit' ) or { }
		add_table( group, EntityGetWithTag( 'polymorphed_player' ) or { } )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@potions' ) then
		group = EntityGetWithTag( 'potion' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@projectiles' ) then
		group = EntityGetWithTag( 'projectile' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@random' ) then
		group = command_at_handler( '@entities', token_type, shooter, tar_x, tar_y ) or { }

		if ( type( group ) == 'table' ) then
			group = random_gets( group, 1 )[ 1 ]
		end
	elseif ( token == '@self' ) then
		return shooter
	elseif ( token == '@wands' ) then
		group = EntityGetWithTag( 'wand' )

		if ( #group == 0 ) then
			command_print( token, '$empty_command_at_error_no_such_entity' )
		end
	elseif ( token == '@chunk_len' ) then
		group = chunk_length
	elseif ( token == '@world_len' ) then
		local w, h = BiomeMapGetSize( )
		group = w * chunk_length
	elseif ( token == '~' ) then
		if ( token_type == 'table' ) then
			group = { 0 }
		elseif ( token_type == 'self' ) then
			group = command_at_handler( '@self', token_type, shooter, tar_x, tar_y )
		elseif ( token_type == 'x' ) then
			x, y = EntityGetTransform( shooter )
			group = x
		elseif ( token_type == 'y' ) then
			x, y = EntityGetTransform( shooter )
			group = y
		else
			if ( is_num( token_type ) ) then
				group = number_handler( token_type )
			end
		end
	end

	return group
end

---二元运算处理器
---@param num1 number|number[]|nil
---@param num2 number|number[]|nil
---@param operation string|nil
---@return number|number[]|nil result
---@return string|nil operation
---@return boolean is_correct
local function binary_operation_handler( num1, num2, operation )
	local result, num_to_operate, is_reverse, is_nesting = nil, nil, false, true
	if ( num1 ) then
		if ( num2 ) then
			if ( ( type( num1 ) == 'table' and type( num2 ) == 'table' ) or ( not operation ) ) then
				goto wrong
			else
				if ( type( num1 ) == 'table' ) then
					result, num_to_operate, is_reverse, is_nesting = num1, num2, false, false
				elseif ( type( num2 ) == 'table' ) then
					result, num_to_operate, is_reverse, is_nesting = num2, num1, true, false
				else
					result, num_to_operate, is_reverse, is_nesting = { num1 }, num2, false, true
				end

				if ( operation == '+' ) then
					for _, each in ipairs( result ) do
						if ( each == -num_to_operate ) then
							result[ _ ] = 0
						else
							result[ _ ] = each + num_to_operate
						end
					end
				elseif ( operation == '-' ) then
					if ( is_reverse ) then
						for _, each in ipairs( result ) do
							if ( each == num_to_operate ) then
								result[ _ ] = 0
							else
								result[ _ ] = num_to_operate - each
							end
						end
					else
						for _, each in ipairs( result ) do
							if ( each == num_to_operate ) then
								result[ _ ] = 0
							else
								result[ _ ] = each - num_to_operate
							end
						end
					end
				elseif ( operation == '*' ) then
					for _, each in ipairs( result ) do
						result[ _ ] = result[ _ ] * num_to_operate
					end
				elseif ( operation == '/' ) then
					if ( is_reverse ) then
						for _, each in ipairs( result ) do
							if ( result[ _ ] == 0 ) then
								if ( num_to_operate > 0 ) then
									result[ _ ] = math.huge
								elseif ( num_to_operate < 0 ) then
									result[ _ ] = -math.huge
								else
									result[ _ ] = 0
								end
							else
								result[ _ ] = num_to_operate / result[ _ ]
							end
						end
					else
						for _, each in ipairs( result ) do
							if ( num_to_operate == 0 ) then
								if ( result[ _ ] > 0 ) then
									result[ _ ] = math.huge
								elseif ( result[ _ ] < 0 ) then
									result[ _ ] = -math.huge
								else
									result[ _ ] = 0
								end
							else
								result[ _ ] = result[ _ ] / num_to_operate
							end
						end
					end
				end

				if ( is_nesting ) then
					result = result[ 1 ]
				end

				return result, nil, true
			end
		else
			return num1, operation, true
		end
	else
		if ( num2 ) then
			if ( operation == '+' or operation == '-' ) then
				result = num2
				if ( type( result ) == 'table' ) then
					if ( operation == '-' ) then
						for _, each in ipairs( result ) do
							result[ _ ] = -each
						end
					end
				else
					if ( operation == '-' ) then
						result = -result
					end
				end

				return result, nil, true
			else
				goto wrong
			end
		else
			return nil, operation, true
		end
	end

	:: wrong ::
	return nil, nil, false
end

---计算参数表达式的值
---@param command_name string
---@param para_expr table[]
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return number|table|nil value
---@return boolean is_correct
local function evaluate_parameter( command_name, para_expr, para_need_type, shooter, tar_x, tar_y )
	if ( #para_expr == 0 ) then
		return nil, false
	end

	if ( #para_expr == 1 ) then
		local token = para_expr[ 1 ]
		if ( token.type == 'NUMBER' ) then
			return number_handler( token.value ), true
		elseif ( token.type == 'SELECTOR' ) then
			return command_at_handler( token.value, para_need_type, shooter, tar_x, tar_y ), true
		elseif ( token.type == 'FUNCTION_DELAYED' ) then
			return token.value, true
		end
	end

	local result, num_to_operate, current_operator, is_correct = nil, nil, nil, true

	for i, token in ipairs( para_expr ) do
		if ( token.type == 'NUMBER' ) then
			local num_value = number_handler( token.value )

			if ( result or current_operator ) then
				num_to_operate = num_value
			else
				result = num_value
			end
		elseif ( token.type == 'SELECTOR' ) then
			local selector_value = command_at_handler( token.value, para_need_type, shooter, tar_x, tar_y )

			if ( result or current_operator ) then
				num_to_operate = selector_value
			else
				result = selector_value
			end
		elseif ( token.type == 'OPERATOR' ) then
			if ( current_operator == nil ) then
				current_operator = token.value
			else
				command_print( 'evaluate_parameter', '$empty_command_error_continuous_operator' )
				return nil, false
			end
		end

		result, current_operator, is_correct = binary_operation_handler( result, num_to_operate, current_operator )
		num_to_operate = nil
		if ( not is_correct ) then
			return nil, false
		end
	end

	if ( type( result ) == 'table' and #result == 0 ) then
		command_print( command_name .. '(', '$empty_command_error_empty_result' )
		return nil, false
	end

	return result, true
end

---将 deck 处理为参数 table , 递归地处理其中包含的所有函数, 返回参数 table、参与的命令法术数量以及是否正确执行
---@param c table[]
---@param command_name string
---@param deck_table table
---@param pattern string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return table paras
---@return number command_spell_count
---@return boolean is_correct
function from_table_get_paras( c, command_name, deck_table, pattern, shooter, tar_x, tar_y )
	local paras, current_para, expecting_separator, para_count, max_para = { }, { }, false, 0, e_cmd_funcs[ command_name ].max_paras or 1

	local _ = 1
	local param_completed = false
	while ( _ <= #deck_table ) do
		local card = deck_table[ _ ]
		param_completed = false

		if ( card.command_type and card.command_value ) then
			---@type string
			local token_type = card.command_type
			---@type string
			local token_value = card.command_value

			if ( token_type == 'SEPARATOR' ) then
				if ( token_value == ',' ) then
					if ( #current_para > 0 ) then
						table.insert( paras, current_para )
						para_count = para_count + 1
						current_para = { }
						expecting_separator = false
					else
						command_print( command_name .. '(', '$empty_command_error_no_para_content', tostring( para_count + 1 ) )
						return { }, _, false
					end
				elseif ( token_value == ')' ) then
					if ( not param_completed and #current_para > 0 ) then
						table.insert( paras, current_para )
						para_count = para_count + 1
					end
					_ = _ + 1
					break
				end
			elseif ( token_type == 'OPERATOR' ) then
				if ( #current_para > 0 and current_para[ #current_para ].type == 'OPERATOR' ) then
					command_print( command_name .. '(', '$empty_command_error_continuous_operator' )
					return { }, _, false
				end

				table.insert( current_para, { type = token_type, value = token_value } )
				expecting_separator = false
			elseif ( token_type == 'NUMBER' ) then
				if ( #current_para > 0 and current_para[ #current_para ].type == 'NUMBER' ) then
					current_para[ #current_para ].value = current_para[ #current_para ].value .. token_value
				else
					table.insert( current_para, { type = 'NUMBER', value = token_value } )
				end

				expecting_separator = true
			elseif ( token_type == 'SELECTOR' ) then
				if ( expecting_separator and #current_para > 0 ) then
					command_print( command_name .. '(', '$empty_command_error_need_operator_here', current_para[ #current_para ].value, token_value )
					return { }, _, false
				end

				table.insert( current_para, { type = token_type, value = token_value } )
				expecting_separator = true
			elseif ( token_type == 'FUNCTION' ) then
				local function_value = string.sub( token_value, 1, #token_value - 1 )

				if ( expecting_separator and #current_para > 0 ) then
					command_print( command_name .. '(', '$empty_command_error_need_operator_here', current_para[ #current_para ].value, function_value )
					return { }, _, false
				end

				local remaining_deck = { }

				for i = _ + 1, #deck_table do
					table.insert( remaining_deck, deck_table[ i ] )
				end

				local func_paras, func_dis_count, func_is_correct = from_table_get_paras( c, function_value, remaining_deck, pattern, shooter, tar_x, tar_y )

				if ( func_is_correct and #func_paras > 0 ) then
					local has_delayed_expr = false
					for _, para in ipairs( func_paras ) do
						if ( type( para ) == 'string' ) then
							has_delayed_expr = true
							break
						end
					end

					if ( has_delayed_expr ) then
						local para_count_key = 'para_' .. #func_paras
						local para_names = nil
						if ( e_cmd_funcs[ function_value ].para_names and
						     e_cmd_funcs[ function_value ].para_names[ para_count_key ] ) then
							para_names = e_cmd_funcs[ function_value ].para_names[ para_count_key ]
						end

						if ( para_names and #para_names == #func_paras ) then
							local args_str = ''
							for i, para in ipairs( func_paras ) do
								if ( i > 1 ) then
									args_str = args_str .. ','
								end
								local para_value = type( para ) == 'string' and para or tostring( para )
								args_str = args_str .. para_names[ i ] .. '=' .. para_value
							end

							local func_expr = FUNC_CALL_PREFIX .. function_value .. ARGS_SEPA_PREFIX .. args_str
							table.insert( current_para, { type = 'FUNCTION_DELAYED', value = func_expr } )
						else
							local func_expr = function_value .. '('
							for i, para in ipairs( func_paras ) do
								if ( i > 1 ) then
									func_expr = func_expr .. ','
								end
								if ( type( para ) == 'string' ) then
									func_expr = func_expr .. para
								else
									func_expr = func_expr .. tostring( para )
								end
							end
							func_expr = func_expr .. ')'
							table.insert( current_para, { type = 'FUNCTION_DELAYED', value = func_expr } )
						end

						table.insert( paras, current_para )
						para_count = para_count + 1
						current_para = { }
						expecting_separator = false
						param_completed = true

						_ = _ + func_dis_count + 1

						if ( _ <= #deck_table ) then
							local next_card = deck_table[ _ ]
							if ( next_card.command_type == 'SEPARATOR' and next_card.command_value == ')' ) then
								_ = _ + 1
								break
							end
						end
					else
						local func_result = nil
						local func_name = function_value

						if ( func_name and e_cmd_funcs[ func_name ] ) then
							if ( #func_paras > e_cmd_funcs[ func_name ].max_paras ) then
								command_print( func_name .. '(', '$empty_command_error_paras_overflow', tostring( #func_paras ), tostring( max_para ) )
								return { }, _, false
							end

							if ( #func_paras == 1 and e_cmd_funcs[ func_name ].action_1_paras ) then
								func_result = e_cmd_funcs[ func_name ].action_1_paras( c, false, shooter, func_paras[ 1 ] )
							elseif ( #func_paras == 2 and e_cmd_funcs[ func_name ].action_2_paras ) then
								func_result = e_cmd_funcs[ func_name ].action_2_paras( c, false, shooter, func_paras[ 1 ], func_paras[ 2 ] )
							elseif ( #func_paras == 3 and e_cmd_funcs[ func_name ].action_3_paras ) then
								func_result = e_cmd_funcs[ func_name ].action_3_paras( c, false, shooter, func_paras[ 1 ], func_paras[ 2 ], func_paras[ 3 ] )
							elseif ( #func_paras == 4 and e_cmd_funcs[ func_name ].action_4_paras ) then
								func_result = e_cmd_funcs[ func_name ].action_4_paras( c, false, shooter, func_paras[ 1 ], func_paras[ 2 ], func_paras[ 3 ], func_paras[ 4 ] )
							end
						else
							command_print(  command_name .. '(', '$empty_command_error_unknown_function', tostring( func_name ) )
							return { }, _, false
						end

						if ( func_result ) then
							table.insert( current_para, { type = 'NUMBER', value = func_result } )
							expecting_separator = true

							table.insert( paras, current_para )
							para_count = para_count + 1
							current_para = { }
							param_completed = true

							_ = _ + func_dis_count + 1
						end
					end
				else
					return { }, _, false
				end
			end
		else
			break
		end

		_ = _ + 1
	end

	if ( #paras > max_para ) then
		command_print( 'from_table_get_paras', '$empty_command_error_paras_overflow', tostring( max_para ), tostring( #paras ) )
		return { }, 0, false
	end

	local result = { }
	local final_para_count = 'para_' .. tostring( #paras )

	local transform_table = nil
	if ( e_cmd_funcs[ command_name ] and
		e_cmd_funcs[ command_name ].transform_tilde_into and
		e_cmd_funcs[ command_name ].transform_tilde_into[ final_para_count ] ) then
		transform_table = e_cmd_funcs[ command_name ].transform_tilde_into[ final_para_count ]
	end

	if ( transform_table ) then
		for i, para in ipairs( paras ) do
			local para_need_type = 'none'
			if ( transform_table and #transform_table > 0 ) then
				if ( i <= #transform_table ) then
					para_need_type = transform_table[ i ]
				end
			end

			local has_selector_or_function = false
			for _, token in ipairs( para ) do
				if ( token.type == 'SELECTOR' or token.type == 'TILDE' or token.type == 'FUNCTION' or token.type == 'FUNCTION_DELAYED' ) then
					has_selector_or_function = true
					break
				end
			end

			local is_immediate_expression = true
			for _, token in ipairs( para ) do
				if ( token.type == 'SELECTOR' or token.type == 'TILDE' or token.type == 'FUNCTION' or token.type == 'FUNCTION_DELAYED' ) then
					is_immediate_expression = false
					break
				end
			end

			if ( is_immediate_expression ) then
				local value, is_correct = evaluate_parameter( command_name, para, para_need_type, shooter, tar_x, tar_y )
				if ( is_correct ) then
					table.insert( result, value )
				else
					goto wrong
				end
			else
				local expr_string, is_correct = build_delayed_expression( para, pattern, para_need_type, shooter, tar_x, tar_y )
				if ( is_correct ) then
					table.insert( result, expr_string )
				else
					goto wrong
				end
			end
		end

		return result, _ - 1, true
	end

	:: wrong ::
	return { }, _, false
end

---将表达式转换为延迟求值字符串格式, 仅在预载时调用，计算立即数，保留 @选择器、~选择器和运算符
---@param para_expr table[]
---@param shooter number
---@param tar_x number
---@param tar_y number
---@param para_need_type string
---@param pattern string
---@return string|nil expr_string
---@return boolean is_correct
function build_delayed_expression( para_expr, pattern, para_need_type, shooter, tar_x, tar_y )
	if ( #para_expr == 0 ) then
		return nil, false
	end

	local result_parts, expecting_operator = { }, false

	for i, token in ipairs( para_expr ) do
		if ( token.type == 'NUMBER' ) then
			local num_value = number_handler( token.value )
			table.insert( result_parts, tostring( num_value ) )
			expecting_operator = true
		elseif ( token.type == 'SELECTOR' ) then
			local fix = ''
			if ( token.value == '~' ) then
				fix = pattern .. para_need_type .. pattern
			end
			table.insert( result_parts, token.value .. fix )
			expecting_operator = true
		elseif ( token.type == 'OPERATOR' ) then
			if ( not expecting_operator ) then
				return nil, false
			end
			table.insert( result_parts, token.value )
			expecting_operator = false
		elseif ( token.type == 'TILDE' ) then
			table.insert( result_parts, '~' .. pattern .. para_need_type .. pattern )
			expecting_operator = true
		elseif ( token.type == 'FUNCTION_DELAYED' ) then
			table.insert( result_parts, token.value )
			expecting_operator = true
		else
			return nil, false
		end
	end

	if ( not expecting_operator ) then
		return nil, false
	end

	local result = table.concat( result_parts, '' )
	result = DELY_EXPR_PREFIX .. result

	return result, true
end

---计算参数 token 列表的值
---@param para_tokens table[]
---@param pattern string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return string|number|number[]|nil result
---@return boolean is_correct
function evaluate_param_tokens( para_tokens, pattern, shooter, tar_x, tar_y )
	local result, op_num, current_operator, is_correct = nil, nil, nil, true

	for _, token in ipairs( para_tokens ) do
		if ( token.type == 'NUMBER' ) then
			local num_value = tonumber( token.value )
			if ( num_value == nil ) then
				return nil, false
			end

			if ( result or current_operator ) then
				op_num = num_value
			else
				result = num_value
			end
		elseif ( token.type == 'SELECTOR' ) then
			if ( string.sub( token.value, 1, #DELY_EXPR_PREFIX ) == DELY_EXPR_PREFIX ) then
				local expr_str = string.sub( token.value, #DELY_EXPR_PREFIX + 1 )

				local selector_value, selector_correct = evaluate_delayed_expression( expr_str, pattern, shooter, tar_x, tar_y )
				if ( not selector_correct ) then
					return nil, false
				end
				if ( result or current_operator ) then
					op_num = selector_value
				else
					result = selector_value
				end
			else
				local selector_value = command_at_handler( token.value, 'none', shooter, tar_x, tar_y )

				if ( result or current_operator ) then
					op_num = selector_value
				else
					result = selector_value
				end
			end
		elseif ( token.type == 'TILDE' ) then
			local tilde_value = command_at_handler( '~', token.value, shooter, tar_x, tar_y )

			if ( result or current_operator ) then
				op_num = tilde_value
			else
				result = tilde_value
			end
		elseif ( token.type == 'FUNCTION' ) then
			local func_result, func_correct = parse_and_execute_function( token.value, token.paras, pattern, shooter, tar_x, tar_y )

			if ( not func_correct ) then
				return nil, false
			end

			if ( result or current_operator ) then
				op_num = func_result
			else
				result = func_result
			end
		elseif ( token.type == 'OPERATOR' ) then
			if ( current_operator == nil ) then
				current_operator = token.value
			else
				return nil, false
			end
		end

		result, current_operator, is_correct = binary_operation_handler( result, op_num, current_operator )
		op_num = nil

		if ( not is_correct ) then
			return nil, false
		end
	end

	return result, true
end

---解析并执行函数调用 - 支持嵌套函数
---@param func_name string
---@param params_str string
---@param pattern string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return string|number|number[]|nil result
---@return boolean is_correct
function parse_and_execute_function( func_name, params_str, pattern, shooter, tar_x, tar_y )
	if ( not e_cmd_funcs[ func_name ] ) then
		command_print( 'evaluate_delayed_expression', '$empty_command_error_unknown_function', tostring( func_name ) )
		return nil, false
	end

	local paras, current_param, paren_depth, i = { }, { }, 0, 1
	local len = #params_str

	while ( i <= len ) do
		local char = string.sub( params_str, i, i )

		if ( char == ',' and paren_depth == 0 ) then
			if ( #current_param > 0 ) then
				table.insert( paras, current_param )
				current_param = { }
			end
			i = i + 1
		elseif ( char == '(' ) then
			paren_depth = paren_depth + 1
			table.insert( current_param, { type = 'PAREN_OPEN', value = char } )
			i = i + 1
		elseif ( char == ')' ) then
			if ( paren_depth > 0 ) then
				paren_depth = paren_depth - 1
				table.insert( current_param, { type = 'PAREN_CLOSE', value = char } )
				i = i + 1
			else
				return nil, false
			end
		elseif ( char == '@' ) then
			local j = i + 1
			while ( j <= len and string.match( string.sub( params_str, j, j ), '[%a_]' ) ) do
				j = j + 1
			end
			local selector = string.sub( params_str, i, j - 1 )
			table.insert( current_param, { type = 'SELECTOR', value = selector } )
			i = j
		elseif ( char == '~' ) then
			if ( i + 1 <= len and string.sub( params_str, i + 1, i + 1 ) == pattern ) then
				local j = i + 2
				while ( j <= len and string.sub( params_str, j, j ) ~= pattern ) do
					j = j + 1
				end
				if ( j <= len ) then
					local tilde_type = string.sub( params_str, i + 2, j - 1 )
					table.insert( current_param, { type = 'TILDE', value = tilde_type } )
					i = j + 1
				else
					return nil, false
				end
			else
				return nil, false
			end
		elseif ( string.match( char, '[%+%-*/]' ) ) then
			table.insert( current_param, { type = 'OPERATOR', value = char } )
			i = i + 1
		elseif ( string.match( char, '[%d%.]' ) ) then
			local j = i
			while ( j <= len and string.match( string.sub( params_str, j, j ), '[%d%.]' ) ) do
				j = j + 1
			end
			local num_str = string.sub( params_str, i, j - 1 )
			table.insert( current_param, { type = 'NUMBER', value = num_str } )
			i = j
		elseif ( string.match( char, '%s' ) ) then
			i = i + 1
		elseif ( string.match( char, '[%a_]' ) ) then
			local j = i
			while ( j <= len and string.match( string.sub( params_str, j, j ), '[%a_0-9]' ) ) do
				j = j + 1
			end
			local potential_func_name = string.sub( params_str, i, j - 1 )
			if ( j <= len and string.sub( params_str, j, j ) == '(' ) then
				local func_paren_depth = 1
				local k = j + 1
				while ( k <= len and func_paren_depth > 0 ) do
					local next_char = string.sub( params_str, k, k )
					if ( next_char == '(' ) then
						func_paren_depth = func_paren_depth + 1
					elseif ( next_char == ')' ) then
						func_paren_depth = func_paren_depth - 1
					end
					k = k + 1
				end

				if ( func_paren_depth == 0 ) then
					local func_params_str = string.sub( params_str, j + 1, k - 2 )
					table.insert( current_param, { type = 'FUNCTION', value = potential_func_name, paras = func_params_str } )
					i = k
				else
					return nil, false
				end
			else
				return nil, false
			end
		elseif ( char == ':' ) then
			if ( string.sub( params_str, i, i + 1 ) == '::' and string.sub( params_str, i + 2, i + 16 ) == '__DELAY_EXP__::' ) then
				local prefix_len = 17
				local next_start = i + prefix_len
				local next_char = string.sub( params_str, next_start, next_start )
				if ( next_char == '@' ) then
					local j = next_start + 1
					while ( j <= len and string.match( string.sub( params_str, j, j ), '[%a_]' ) ) do
						j = j + 1
					end
					local selector = string.sub( params_str, next_start, j - 1 )
					table.insert( current_param, { type = 'SELECTOR', value = selector } )
					i = j
					break
				elseif ( next_char == '~' ) then
					if ( next_start + 1 <= len and string.sub( params_str, next_start + 1, next_start + 1 ) == pattern ) then
						local j = next_start + 2
						while ( j <= len and string.sub( params_str, j, j ) ~= pattern ) do
							j = j + 1
						end
						if ( j <= len ) then
							local tilde_type = string.sub( params_str, next_start + 2, j - 1 )
							table.insert( current_param, { type = 'TILDE', value = tilde_type } )
							i = j + 1
							break
						else
							return nil, false
						end
					else
						return nil, false
					end
				elseif ( string.match( next_char, '[%a_]' ) ) then
					local j = next_start
					while ( j <= len and string.match( string.sub( params_str, j, j ), '[%a_0-9]' ) ) do
						j = j + 1
					end
					local potential_func_name = string.sub( params_str, next_start, j - 1 )
					if ( j <= len and string.sub( params_str, j, j ) == '(' ) then
						local func_paren_depth = 1
						local k = j + 1
						while ( k <= len and func_paren_depth > 0 ) do
							local next_inner_char = string.sub( params_str, k, k )
							if ( next_inner_char == '(' ) then
								func_paren_depth = func_paren_depth + 1
							elseif ( next_inner_char == ')' ) then
								func_paren_depth = func_paren_depth - 1
							end
							k = k + 1
						end

						if ( func_paren_depth == 0 ) then
							local func_params_str = string.sub( params_str, j + 1, k - 2 )
							table.insert( current_param, { type = 'FUNCTION', value = potential_func_name, paras = func_params_str } )
							i = k
							break
						else
							return nil, false
						end
					else
						return nil, false
					end
				else
					return nil, false
				end
			else
				return nil, false
			end
		else
			return nil, false
		end
	end

	if ( #current_param > 0 ) then
		table.insert( paras, current_param )
	end

	local param_values = { }
	for _, param_tokens in ipairs( paras ) do
		local param_value, param_correct = evaluate_param_tokens( param_tokens, pattern, shooter, tar_x, tar_y )
		if ( not param_correct ) then
			if ( #param_tokens == 1 and param_tokens[ 1 ].type == 'SELECTOR' ) then
				local expr_str = param_tokens[ 1 ].value
				if ( string.sub( expr_str, 1, #DELY_EXPR_PREFIX ) == DELY_EXPR_PREFIX ) then
					expr_str = string.sub( expr_str, #DELY_EXPR_PREFIX + 1 )
				end
				param_value, param_correct = evaluate_delayed_expression( expr_str, pattern, shooter, tar_x, tar_y )
			end
		end
			if ( not param_correct ) then
			return nil, false
		end
		table.insert( param_values, param_value )
	end

	local func_result, max_paras = nil, e_cmd_funcs[ func_name ].max_paras

	if ( #param_values > max_paras ) then
		command_print( func_name .. '(', '$empty_command_error_paras_overflow', tostring( #param_values ), tostring( max_paras ) )
		return nil, false
	end

	if ( #param_values == 1 and e_cmd_funcs[ func_name ].action_1_paras ) then
		func_result = e_cmd_funcs[ func_name ].action_1_paras( { }, true, shooter, param_values[ 1 ] )
	elseif ( #param_values == 2 and e_cmd_funcs[ func_name ].action_2_paras ) then
		func_result = e_cmd_funcs[ func_name ].action_2_paras( { }, true, shooter, param_values[ 1 ], param_values[ 2 ] )
	elseif ( #param_values == 3 and e_cmd_funcs[ func_name ].action_3_paras ) then
		func_result = e_cmd_funcs[ func_name ].action_3_paras( { }, true, shooter, param_values[ 1 ], param_values[ 2 ], param_values[ 3 ] )
	elseif ( #param_values == 4 and e_cmd_funcs[ func_name ].action_4_paras ) then
		func_result = e_cmd_funcs[ func_name ].action_4_paras( { }, true, shooter, param_values[ 1 ], param_values[ 2 ], param_values[ 3 ], param_values[ 4 ] )
	end

	return func_result, true
end

---处理延迟表达式
---@param expr_string string
---@param pattern string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return string|number|number[]|nil result
---@return boolean is_correct
function evaluate_delayed_expression( expr_string, pattern, shooter, tar_x, tar_y )
	if ( not expr_string or expr_string == '' ) then
		return nil, false
	end

	local actual_expr = expr_string
	if ( string.sub( expr_string, 1, #DELY_EXPR_PREFIX ) == DELY_EXPR_PREFIX ) then
		actual_expr = string.sub( expr_string, #DELY_EXPR_PREFIX + 1 )
	end

	if ( string.sub( actual_expr, 1, #FUNC_CALL_PREFIX ) == FUNC_CALL_PREFIX ) then
		local first_sep_pos = string.find( actual_expr, ARGS_SEPA_PREFIX, #FUNC_CALL_PREFIX + 1, true )
			if ( first_sep_pos ) then
			local func_name = string.sub( actual_expr, #FUNC_CALL_PREFIX + 1, first_sep_pos - 1 )
			local args_str = string.sub( actual_expr, first_sep_pos + #ARGS_SEPA_PREFIX )
			local args_table = parse_kv_pairs( args_str, false )

			local param_values = { }
			for i, _ in pairs( args_table ) do
				if ( string.sub( _, 1, #DELY_EXPR_PREFIX ) == DELY_EXPR_PREFIX ) then
					local stripped_value = string.sub( _, #DELY_EXPR_PREFIX + 1 )
					local param_result, param_correct = evaluate_delayed_expression( stripped_value, pattern, shooter, tar_x, tar_y )
					if ( param_correct ) then
						param_values[ i ] = param_result
					else
						return nil, false
					end
				else
					param_values[ i ] = tonumber( _ ) or _
				end
			end

			local param_count = 0
			for _ in pairs( param_values ) do
				param_count = param_count + 1
			end

			local para_count_key = 'para_' .. param_count
			local para_names = nil
			if ( e_cmd_funcs[ func_name ].para_names and
			     e_cmd_funcs[ func_name ].para_names[ para_count_key ] ) then
				para_names = e_cmd_funcs[ func_name ].para_names[ para_count_key ]
			end
			if ( not para_names ) then
				return nil, false
			end

			local paras = { }
			for _, para_name in ipairs( para_names ) do
				if ( param_values[ para_name ] ) then
					table.insert( paras, param_values[ para_name ] )
				else
					return nil, false
				end
			end

			local func_result, max_paras = nil, e_cmd_funcs[ func_name ].max_paras

			if ( #paras > max_paras ) then
				command_print( func_name .. '(', '$empty_command_error_paras_overflow', tostring( #paras ), tostring( max_paras ) )
				return nil, false
			end

			if ( #paras == 1 and e_cmd_funcs[ func_name ].action_1_paras ) then
				func_result = e_cmd_funcs[ func_name ].action_1_paras( { }, true, shooter, paras[ 1 ] )
			elseif ( #paras == 2 and e_cmd_funcs[ func_name ].action_2_paras ) then
				func_result = e_cmd_funcs[ func_name ].action_2_paras( { }, true, shooter, paras[ 1 ], paras[ 2 ] )
			elseif ( #paras == 3 and e_cmd_funcs[ func_name ].action_3_paras ) then
				func_result = e_cmd_funcs[ func_name ].action_3_paras( { }, true, shooter, paras[ 1 ], paras[ 2 ], paras[ 3 ] )
			elseif ( #paras == 4 and e_cmd_funcs[ func_name ].action_4_paras ) then
				func_result = e_cmd_funcs[ func_name ].action_4_paras( { }, true, shooter, paras[ 1 ], paras[ 2 ], paras[ 3 ], paras[ 4 ] )
			else
				return nil, false
			end

			return func_result, true
		end
	end

	local paren_pos = string.find( actual_expr, '(', 1, true )
	if ( paren_pos and string.sub( actual_expr, #actual_expr, #actual_expr ) == ')' ) then
		local func_name = string.sub( actual_expr, 1, paren_pos - 1 )
		local params_str = string.sub( actual_expr, paren_pos + 1, #actual_expr - 1 )
		local func_result, func_correct = parse_and_execute_function( func_name, params_str, pattern, shooter, tar_x, tar_y )
		if ( func_correct ) then
			return func_result, true
		else
			return nil, false
		end
	end

	local tokens = { }
	local i = 1
	local len = #actual_expr

	while ( i <= len ) do
		local char = string.sub( actual_expr, i, i )

		if ( char == '@' ) then
			local j = i + 1
			while ( j <= len and string.match( string.sub( actual_expr, j, j ), '[%a_]' ) ) do
				j = j + 1
			end
			local selector = string.sub( actual_expr, i, j - 1 )
			table.insert( tokens, { type = 'SELECTOR', value = selector } )
			i = j
		elseif ( char == '~' ) then
			if ( i + 1 <= len and string.sub( actual_expr, i + 1, i + 1 ) == pattern ) then
				local j = i + 2
				while ( j <= len and string.sub( actual_expr, j, j ) ~= pattern ) do
					j = j + 1
				end
				if ( j <= len ) then
					local tilde_type = string.sub( actual_expr, i + 2, j - 1 )
					table.insert( tokens, { type = 'TILDE', value = tilde_type } )
					i = j + 1
				else
					return nil, false
				end
			else
				return nil, false
			end
		elseif ( string.match( char, '[%+%-*/]' ) ) then
			table.insert( tokens, { type = 'OPERATOR', value = char } )
			i = i + 1
		elseif ( string.match( char, '[%d%.]' ) ) then
			local j = i
			while ( j <= len and string.match( string.sub( actual_expr, j, j ), '[%d%.]' ) ) do
				j = j + 1
			end
			local num_str = string.sub( actual_expr, i, j - 1 )
			table.insert( tokens, { type = 'NUMBER', value = num_str } )
			i = j
		elseif ( string.match( char, '[%a_]' ) ) then
			local j = i
			while ( j <= len and string.match( string.sub( actual_expr, j, j ), '[%a_0-9]' ) ) do
				j = j + 1
			end
			local func_name = string.sub( actual_expr, i, j - 1 )
			if ( j <= len and string.sub( actual_expr, j, j ) == '(' ) then
				local paren_depth = 1
				local k = j + 1
				while ( k <= len and paren_depth > 0 ) do
					local next_char = string.sub( actual_expr, k, k )
					if ( next_char == '(' ) then
						paren_depth = paren_depth + 1
					elseif ( next_char == ')' ) then
						paren_depth = paren_depth - 1
					end
					k = k + 1
				end

				if ( paren_depth == 0 ) then
					local params_str = string.sub( actual_expr, j + 1, k - 2 )
					table.insert( tokens, { type = 'FUNCTION', value = func_name, paras = params_str } )
					i = k
				else
					return nil, false
				end
			else
				return nil, false
			end
		elseif ( string.match( char, '%s' ) ) then
			i = i + 1
		else
			return nil, false
		end
	end

	local result, num_to_operate, current_operator, is_correct = nil, nil, nil, true

	for _, token in ipairs( tokens ) do
		if ( token.type == 'NUMBER' ) then
			local num_value = tonumber( token.value )
			if ( num_value == nil ) then
				return nil, false
			end

			if ( result or current_operator ) then
				num_to_operate = num_value
			else
				result = num_value
			end
		elseif ( token.type == 'SELECTOR' ) then
			local selector_value = command_at_handler( token.value, 'none', shooter, tar_x, tar_y )

			if ( result or current_operator ) then
				num_to_operate = selector_value
			else
				result = selector_value
			end
		elseif ( token.type == 'TILDE' ) then
			local tilde_value = command_at_handler( '~', token.value, shooter, tar_x, tar_y )

			if ( result or current_operator ) then
				num_to_operate = tilde_value
			else
				result = tilde_value
			end
		elseif ( token.type == 'FUNCTION' ) then
			local func_result, func_correct = parse_and_execute_function( token.value, token.paras, pattern, shooter, tar_x, tar_y )
			if ( not func_correct ) then
				return nil, false
			end

			if ( result or current_operator ) then
				num_to_operate = func_result
			else
				result = func_result
			end
		elseif ( token.type == 'OPERATOR' ) then
			if ( current_operator == nil ) then
				current_operator = token.value
			else
				return nil, false
			end
		end

		result, current_operator, is_correct = binary_operation_handler( result, num_to_operate, current_operator )
		num_to_operate = nil
		if ( not is_correct ) then
			return nil, false
		end
	end

	return result, true
end

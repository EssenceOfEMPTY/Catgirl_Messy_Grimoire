dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local chunk_length = 512

local DELY_EXPR_PREFIX = '::__DELAY_EXP__::'
local FUNC_CALL_PREFIX = '__FUNC_CALL__::'
local ARGS_SEPA_PREFIX = '::__ARGS_SEPA__::'

empty_command_functions = {
	random_get = {
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
			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( 'random_get(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( type( extract ) ~= 'table' ) then
					extract = { }
				end

				if ( #extract > 0 ) then
					local value = random_gets( extract, 1 )[ 1 ]

					command_print( 'random_get(', '$empty_command_random_get_success', tostring( value ) )
					return value
				else
					command_print( 'random_get(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end
	},
	get_first = {
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
			return empty_command_functions[ 'get_first' ].action_2_paras( { }, reflect, shooter, extract, 1 )
		end,
		---从 < NUMBER[ ] > 中选择顺数第 No 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param extract string|number[]
		---@param No string|number
		---@return string|number value
		action_2_paras = function ( c, reflect, shooter, extract, No )
			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( 'get_first(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end
			if ( type( No ) ~= 'number' and type( No ) ~= 'string' ) then
				command_print( 'get_first(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( No ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( #extract > 0 ) then
					if ( No > #extract ) then
						command_print( 'get_first(', '$empty_command_error_index_out_of_range', tostring( No ), tostring( #extract ) )
					else
						local value = extract[ No ]

						command_print( 'get_first(', '$empty_command_get_first_success', tostring( No ), tostring( value ) )
						return value
					end
				else
					command_print( 'get_first(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end
	},
	get_last = {
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
			return empty_command_functions[ 'get_last' ].action_2_paras( { }, reflect, shooter, extract, 1 )
		end,
		---从 < NUMBER[ ] > 中选择倒数第 No 个 < NUMBER > 返回
		---@param c table
		---@param reflect boolean
		---@param extract string|number[]
		---@param No string|number
		---@return string|number value
		action_2_paras = function ( c, reflect, shooter, extract, No )
			if ( type( extract ) ~= 'table' and type( extract ) ~= 'string' ) then
				command_print( 'get_last(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( extract ) )
				return 0
			end
			if ( type( No ) ~= 'number' and type( No ) ~= 'string' ) then
				command_print( 'get_last(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( No ) )
				return 0
			end

			if ( reflect or type( extract ) == 'table' ) then
				if ( #extract > 0 ) then
					if ( No > #extract ) then
						command_print( 'get_last(', '$empty_command_error_index_out_of_range', tostring( No ), tostring( #extract ) )
					else
						local value = extract[ #extract - No + 1 ]

						command_print( 'get_last(', '$empty_command_get_last_success', tostring( No ), tostring( value ) )
						return value
					end
				else
					command_print( 'get_last(', '$empty_command_error_empty_table' )
				end
			end

			return 0
		end
	},
	variable_get = {
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
			if ( type( v_No ) ~= 'number' and type( v_No ) ~= 'string' ) then
				command_print( 'variable_get(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_No ) )
				return 0
			end

			local v_value = 0

			if ( reflect or type( v_No ) == 'number' ) then
				v_value = tonumber( GlobalsGetValue( 'EMPTY_COMMAND_VARIABLE_' .. tostring( v_No ), '0' ) ) or 0

				command_print( 'variable_get(', '$empty_command_variable_get_success', tostring( v_No ), tostring( v_value ) )
			end

			return v_value
		end
	},
	variable_set = {
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
			if ( type( v_No ) ~= 'number' and type( v_No ) ~= 'string' ) then
				command_print( 'variable_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_No ) )
				return 0
			end
			if ( type( v_value ) ~= 'number' and type( v_value ) ~= 'string' ) then
				command_print( 'variable_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( v_value ) )
				return 0
			end

			if ( reflect or ( type( v_No ) == 'number' and type( v_value ) == 'number' ) ) then
				GlobalsSetValue( 'EMPTY_COMMAND_VARIABLE_' .. tostring( v_No ), tostring( v_value ) )

				command_print( 'variable_set(', '$empty_command_variable_set_success', tostring( v_No ), tostring( v_value ) )
			end

			return v_value
		end
	},
	min = {
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
			if ( type( num_table ) ~= 'table' and type( num_table ) ~= 'string' ) then
				command_print( 'min(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( num_table ) )
				return 0
			end

			local min = 0

			if ( reflect or type( num_table ) == 'table' ) then
				if ( type( num_table ) ~= 'table' ) then
					num_table = { }
				end

				if ( #num_table == 0 ) then
					command_print( 'min(', '$empty_command_error_empty_table' )
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
			if ( type( num1 ) ~= 'number' and type( num1 ) ~= 'string' ) then
				command_print( 'min(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num1 ) )
				return 0
			end
			if ( type( num2 ) ~= 'number' and type( num2 ) ~= 'string' ) then
				command_print( 'min(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num2 ) )
				return 0
			end

			if ( reflect or ( type( num1 ) == 'number' and type( num2 ) == 'number' ) ) then
				if ( type( num1 ) ~= 'number' ) then
					num1 = -math.huge
				end
				if ( type( num2 ) ~= 'number' ) then
					num2 = -math.huge
				end

				return math.min( num1, num2 )
			else
				return 0
			end
		end
	},
	max = {
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
			if ( type( num_table ) ~= 'table' and type( num_table ) ~= 'string' ) then
				command_print( 'max(', '$empty_command_error_wrong_para_type', 'NUMBER[ ]', upper_type( num_table ) )
				return 0
			end

			local max = 0

			if ( reflect or type( num_table ) == 'table' ) then
				if ( type( num_table ) ~= 'table' ) then
					num_table = { }
				end

				if ( #num_table == 0 ) then
					command_print( 'max(', '$empty_command_error_empty_table' )
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
			if ( type( num1 ) ~= 'number' and type( num1 ) ~= 'string' ) then
				command_print( 'max(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num1 ) )
				return 0
			end
			if ( type( num2 ) ~= 'number' and type( num2 ) ~= 'string' ) then
				command_print( 'max(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( num2 ) )
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
		end
	},
	lifetime_set = {
		para_names = {
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
			if ( type( lifetime ) ~= 'number' and type( lifetime ) ~= 'string' ) then
				command_print( 'lifetime_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( lifetime ) )
				return 0
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local l_comps = EntityGetComponent( entity, 'LifetimeComponent' ) or { }
				local count = #l_comps

				for _, l_comp in ipairs( l_comps ) do
					if ( lifetime == -1 ) then
						EntityRemoveComponent( entity, l_comp )
					else
						ComponentSetValue2( l_comp, 'lifetime', lifetime )
					end
				end

				if ( count < 1 and lifetime ~= -1 ) then
					EntityAddComponent2( entity, 'LifetimeComponent', {
						lifetime = lifetime
					} )

					count = 1
				end

				if ( count > 0 ) then
					command_print( 'lifetime_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'lifetime_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_lifetime_set',
					shooter = shooter,
					lifetime = lifetime,
				}, empty_path .. 'entities/misc/command/lifetime_set.xml,', '$' )
			end

			return lifetime
		end
	},
	projectile_lifetime_set = {
		para_names = {
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
			if ( type( lifetime ) ~= 'number' and type( lifetime ) ~= 'string' ) then
				command_print( 'projectile_lifetime_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( lifetime ) )
				return 0
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local p_comps = EntityGetComponent( entity, 'ProjectileComponent' ) or { }
				local count = #p_comps

				for _, p_comp in ipairs( p_comps ) do
					ComponentSetValue2( p_comp, 'lifetime', lifetime )
				end

				if ( count > 0 ) then
					command_print( 'projectile_lifetime_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'projectile_lifetime_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_lifetime_set',
					shooter = shooter,
					lifetime = lifetime,
				}, empty_path .. 'entities/misc/command/projectile_lifetime_set.xml,', '$')
			end

			return lifetime
		end
	},
	projectile_speed_set = {
		para_names = {
			para_1 = {
				'speed',
			},
		},
		transform_tilde_into = {
			para_1 = {
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
			if ( type( speed ) ~= 'number' and type( speed ) ~= 'string' ) then
				command_print( 'projectile_speed_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( speed ) )
				return 0
			end

			if ( reflect ) then
				if ( type( speed ) ~= 'number' ) then
					speed = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }
				local count, just_start = #v_comps, true

				for _, v_comp in ipairs( v_comps ) do
					remove_speed_limit( v_comp )

					local vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )

					if ( vel_x ~= 0 and vel_y ~= 0 ) then
						vel_x, vel_y = change_vel( vel_x, vel_y, speed )

						ComponentSetValue2( v_comp, 'mVelocity', vel_x, vel_y )

						just_start = false
					end
				end

				if ( just_start ) then
					local p_comps = EntityGetComponent( entity, 'ProjectileComponent' ) or { }
					count = #p_comps

					for _, p_comp in ipairs( p_comps ) do
						ComponentSetValue2( p_comp, 'speed_min', speed )
						ComponentSetValue2( p_comp, 'speed_max', speed )
					end
				end

				if ( count > 0 ) then
					command_print( 'projectile_speed_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'projectile_speed_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_speed_set',
					shooter = shooter,
					speed = speed,
				}, empty_path .. 'entities/misc/command/projectile_speed_set.xml,', '$' )
			end

			return speed
		end
	},
	projectile_gravity_set = {
		para_names = {
			para_1 = {
				'gravity',
			},
		},
		transform_tilde_into = {
			para_1 = {
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
			if ( type( gravity_y ) ~= 'number' and type( gravity_y ) ~= 'string' ) then
				command_print( 'projectile_gravity_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_y ) )
				return 0
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }
				local count = #v_comps

				for _, v_comp in ipairs( v_comps ) do
					ComponentSetValue2( v_comp, 'gravity_y', gravity_y )
				end

				if ( count > 0 ) then
					command_print( 'projectile_gravity_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'projectile_gravity_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_gravity_set',
					shooter = shooter,
					gravity_y = gravity_y,
				}, empty_path .. 'entities/misc/command/projectile_gravity_set.xml,', '$' )
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
			if ( type( gravity_y ) ~= 'number' and type( gravity_y ) ~= 'string' ) then
				command_print( 'projectile_gravity_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_y ) )
				return { 0, 0 }
			end
			if ( type( gravity_x ) ~= 'number' and type( gravity_x ) ~= 'string' ) then
				command_print( 'projectile_gravity_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( gravity_y ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }
				local count = #v_comps

				for _, v_comp in ipairs( v_comps ) do
					ComponentSetValue2( v_comp, 'gravity_y', gravity_y )
					ComponentSetValue2( v_comp, 'gravity_x', gravity_x )
				end

				if ( count > 0 ) then
					command_print( 'projectile_gravity_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'projectile_gravity_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_gravity_set',
					shooter = shooter,
					gravity_y = gravity_y,
					gravity_x = gravity_x,
				}, empty_path .. 'entities/misc/command/projectile_gravity_set.xml,', '$' )
			end

			return { gravity_y, gravity_x }
		end
	},
	projectile_air_friction_set = {
		para_names = {
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
			if ( type( air_friction ) ~= 'number' and type( air_friction ) ~= 'string' ) then
				command_print( 'projectile_air_friction_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( air_friction ) )
				return 0
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }
				local count = #v_comps

				for _, v_comp in ipairs( v_comps ) do
					ComponentSetValue2( v_comp, 'air_friction', air_friction )
				end

				if ( count > 0 ) then
					command_print( 'projectile_air_friction_set(', '$empty_command_projectile_change_success', tostring( count ) )
				else
					command_print( 'projectile_air_friction_set(', '$empty_command_error_no_projectile_change' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_air_friction_set',
					shooter = shooter,
					air_friction = air_friction,
				}, empty_path .. 'entities/misc/command/projectile_air_friction_set.xml,', '$' )
			end

			return air_friction
		end
	},
	projectile_shoot_angle_add = {
		para_names = {
			para_1 = {
				'angle',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0'
			},
		},
		---在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( 'projectile_shoot_angle_add(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' )

				for _, v_comp in ipairs( v_comps or { } ) do
					local vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )

					vel_x, vel_y = rot_vel( vel_x, vel_y or 0, angle )

					ComponentSetValue2( v_comp, 'mVelocity', vel_x, vel_y )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = false,
					merge = true,
				}, {
					id = 'empty_projectile_shoot_angle_add',
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/projectile_shoot_angle_add.xml,', '$' )
			end

			return angle
		end
	},
	projectile_shoot_angle_set = {
		para_names = {
			para_1 = {
				'angle',
			},
		},
		transform_tilde_into = {
			para_1 = {
				'0'
			},
		},
		---在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( 'projectile_shoot_angle_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				if ( type( angle ) ~= 'number' ) then
					angle = 0
				end

				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
				local v_comps = EntityGetComponent( entity, 'VelocityComponent' )

				for _, v_comp in ipairs( v_comps or { } ) do
					local vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )

					vel_x, vel_y = abs_rot_vel( vel_x, vel_y or 0, angle )

					ComponentSetValue2( v_comp, 'mVelocity', vel_x, vel_y )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_shoot_angle_set',
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/projectile_shoot_angle_set.xml,', '$' )
			end

			return angle
		end
	},
	projectile_arc_set = {
		para_names = {
			para_1 = {
				'angle',
			},
			para_2 = {
				'angle',
				'inc',
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
		---在不更改速度大小的状态下将速度方向在原基础上每帧逆时针旋转 angle°
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return string|number angle
		action_1_paras = function ( c, reflect, shooter, angle )
			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( 'projectile_shoot_angle_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return 0
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local v_comps = EntityGetComponent( entity, 'VariableStorageComponent', 'projectile_arc_set' )
				if ( v_comps ) then
					for _, v_comp in ipairs( v_comps or { } ) do
						if ( _ == 1 ) then
							ComponentSetValue2( v_comp, 'value_int', 0 )
							ComponentSetValue2( v_comp, 'value_string', tostring( angle ) )
						else
							EntityRemoveComponent( entity, v_comp )
						end
					end
				else
					EntityAddComponent2( entity, 'VariableStorageComponent', {
						_tags = 'projectile_arc_set',
						value_int = 0,
						value_string = tostring( angle ),
						value_float = 0,
					} )
				end

				local l_comps = EntityGetComponent( entity, 'LuaComponent', 'projectile_arc_set' )
				if ( l_comps ) then
					for _, l_comp in ipairs( l_comps or { } ) do
						if ( _ == 1 ) then
							ComponentSetValue2( l_comp, 'execute_every_n_frame', 1 )
							ComponentSetValue2( l_comp, 'script_source_file', empty_path .. 'scripts/command/projectile_arc_set.lua' )
						else
							EntityRemoveComponent( entity, l_comp )
						end
					end
				else
					EntityAddComponent2( entity, 'LuaComponent', {
						_tags = 'projectile_arc_set',
						execute_every_n_frame = 1,
						script_source_file = empty_path .. 'scripts/command/projectile_arc_set_reflect.lua',
					} )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_arc_set',
					shooter = shooter,
					angle = angle,
				}, empty_path .. 'entities/misc/command/projectile_arc_set.xml,', '$' )
			end

			return angle
		end,
		---@param c table
		---@param reflect boolean
		---@param shooter number
		---@param angle string|number
		---@return table angle
		action_2_paras = function ( c, reflect, shooter, angle, inc )
			if ( type( angle ) ~= 'number' and type( angle ) ~= 'string' ) then
				command_print( 'projectile_shoot_angle_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( angle ) )
				return { 0, 0 }
			end
			if ( type( inc ) ~= 'number' and type( inc ) ~= 'string' ) then
				command_print( 'projectile_shoot_angle_set(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( inc ) )
				return { 0, 0 }
			end

			if ( reflect ) then
				local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

				local v_comps = EntityGetComponent( entity, 'VariableStorageComponent', 'projectile_arc_set' )
				if ( v_comps ) then
					for _, v_comp in ipairs( v_comps or { } ) do
						if ( _ == 1 ) then
							ComponentSetValue2( v_comp, 'value_int', 0 )
							ComponentSetValue2( v_comp, 'value_string', tostring( angle ) )
							ComponentSetValue2( v_comp, 'value_float', inc )
						else
							EntityRemoveComponent( entity, v_comp )
						end
					end
				else
					EntityAddComponent2( entity, 'VariableStorageComponent', {
						_tags = 'projectile_arc_set',
						value_int = 0,
						value_string = tostring( angle ),
						value_float = inc,
					} )
				end

				local l_comps = EntityGetComponent( entity, 'LuaComponent', 'projectile_arc_set' )
				if ( l_comps ) then
					for _, l_comp in ipairs( l_comps or { } ) do
						if ( _ == 1 ) then
							ComponentSetValue2( l_comp, 'execute_every_n_frame', 1 )
							ComponentSetValue2( l_comp, 'script_source_file', empty_path .. 'scripts/command/projectile_arc_set.lua' )
						else
							EntityRemoveComponent( entity, l_comp )
						end
					end
				else
					EntityAddComponent2( entity, 'LuaComponent', {
						_tags = 'projectile_arc_set',
						execute_every_n_frame = 1,
						script_source_file = empty_path .. 'scripts/command/projectile_arc_set_reflect.lua',
					} )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_projectile_arc_set',
					shooter = shooter,
					angle = angle,
					inc = inc,
				}, empty_path .. 'entities/misc/command/projectile_arc_set.xml,', '$' )
			end

			return { angle, inc }
		end
	},
	explode = {
		para_names = {
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
			if ( type( radius ) ~= 'number' and type( radius ) ~= 'string' ) then
				command_print( 'explode(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( radius ) )
				return 0
			end

			if ( reflect or ( type( radius ) == 'number' and ( type( tar ) == 'number' or type( tar ) == 'table' ) ) ) then
				if ( type( tar ) == 'number' ) then
					tar = { tar }
				elseif ( type( tar ) ~= 'table' ) then
					tar = { }
				end

				if ( #tar == 0 ) then
					command_print( 'explode(', '$empty_command_error_empty_table' )
					return radius
				end

				local attributes = {
					explosion_radius = radius,
					damage = radius / get_scale( ),
					camera_shake = radius / 10.0,
					create_cell_probability = math.min( 100, 50 + radius / 5 ),
					physics_explosion_power_min = radius / 5,
					physics_explosion_power_max = radius / 4,
				}

				for i, _ in ipairs( tar ) do
					if ( _ ~= NULL_ENTITY and EntityGetIsAlive( _ ) ) then
						local x, y = EntityGetTransform( _ )

						local explode = EntityLoad( empty_path .. 'entities/projectiles/command/explode_with_lua.xml', x, y )

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

				command_print( 'explode(', '$empty_command_explode_tar_success', tostring( #tar ), tostring( radius ) )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_explode',
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
			if ( type( radius ) ~= 'number' and type( radius ) ~= 'string' ) then
				command_print( 'explode(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( radius ) )
				return 0
			end
			if ( type( x ) ~= 'number' and type( x ) ~= 'string' ) then
				command_print( 'explode(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( x ) )
				return 0
			end
			if ( type( y ) ~= 'number' and type( y ) ~= 'string' ) then
				command_print( 'explode(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( y ) )
				return 0
			end

			if ( reflect or ( type( radius ) == 'number' and type( x ) == 'number' and type( y ) == 'table' ) ) then
				if ( type( x ) ~= 'number' ) then
					x = 0
				end
				if ( type( y ) ~= 'number' ) then
					y = x
				end

				local explode = EntityLoad( empty_path .. 'entities/projectiles/command/explode_with_lua.xml', x, y )

				if ( explode ) then
					local projectile_comp = EntityGetFirstComponent( explode, 'ProjectileComponent' )

					if ( projectile_comp ) then
						local attributes = {
							explosion_radius = radius,
							damage = radius / get_scale( ),
							camera_shake = radius / 10.0,
							create_cell_probability = math.min( 100, 50 + radius / 5 ),
							physics_explosion_power_min = radius / 5,
							physics_explosion_power_max = radius / 4,
						}

						for k, v in pairs( attributes ) do
							ComponentObjectSetValue2( projectile_comp, 'config_explosion', k, v )
						end
					end
				end

				command_print( 'explode(', '$empty_command_explode_xy_success', tostring( x ), tostring( y ), tostring( radius ) )
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_explode',
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
		para_names = {
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
			if ( type( tar ) ~= 'number' and type( tar ) ~= 'string' ) then
				command_print( 'tp(', '$empty_command_error_wrong_para_type', 'NUMBER', upper_type( tar ) )
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
					command_print( 'tp(', 'empty_command_tp_error_target_not_found', tostring( tar ) )
				end

				if ( count > 0 ) then
					command_print( 'tp(', '$empty_command_tp_success', tostring( count ), tostring( x ), tostring( y ) )
				else
					command_print( 'tp(', '$empty_command_tp_error_no_entity_can_tp' )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_tp',
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
			if ( type( x ) ~= 'number' and type( x ) ~= 'string' ) then
				GamePrint( 'tp( : ' .. GameTextGet( '$empty_command_error_wrong_para_type', 'NUMBER', string.upper( type( x ) ) ) )
				return 0
			end
			if ( type( y ) ~= 'number' and type( y ) ~= 'string' ) then
				GamePrint( 'tp( : ' .. GameTextGet( '$empty_command_error_wrong_para_type', 'NUMBER', string.upper( type( y ) ) ) )
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
					GamePrint( 'tp( : ' .. GameTextGet( '$empty_command_tp_success', tostring( count ), tostring( x ), tostring( y ) ) )
				else
					GamePrint( 'tp( : ' .. GameTextGet( '$empty_command_tp_error_no_entity_can_tp' ) )
				end
			else
				add_desc_by_info( c, {
					replace = true,
					update = true,
					merge = false,
				}, {
					id = 'empty_tp',
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
		end
	},
}

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
		group = command_at_handler( '@players', token_type, shooter, tar_x, tar_y ) or { }
		local entity = { }

		if ( type( group ) == 'number' ) then
			group = { group }
		end

		for _, each in ipairs( group ) do
			x, y = EntityGetTransform( each )
			add_table( entity, EntityGetInRadius( x, y, 3000 ), false, false )
		end

		group = remove_duplicates( entity )
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
				GamePrint( GameTextGet( '$empty_command_error_continuous_operator' ) )
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
		GamePrint( command_name .. '( : ' .. GameTextGet( '$empty_command_error_empty_result' ) )
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
	local paras = { }
	local current_para = { }
	local expecting_separator = false
	local para_count = 0
	local max_para = 0

	for not_use, options in pairs( empty_command_functions[ command_name ].transform_tilde_into or { } ) do
		max_para = math.max( max_para, #options )
	end

	local _ = 1
	local param_completed = false
	while ( _ <= #deck_table ) do
		local card = deck_table[ _ ]
		param_completed = false  -- 重置标志

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
						GamePrint( command_name .. '(: ' .. GameTextGet( '$empty_command_error_no_para_content', tostring( para_count + 1 ) ) )
						return { }, _, false
					end
				elseif ( token_value == ')' ) then
					-- 如果参数还没有被添加（比如从子函数返回后），则添加
					if ( not param_completed and #current_para > 0 ) then
						table.insert( paras, current_para )
						para_count = para_count + 1
					end
					_ = _ + 1
					break
				end
			elseif ( token_type == 'OPERATOR' ) then
				if ( #current_para > 0 and current_para[ #current_para ].type == 'OPERATOR' ) then
					GamePrint( command_name .. '(: ' .. GameTextGet( '$empty_command_error_continuous_operator' ) )
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
					GamePrint( command_name .. '(: ' .. GameTextGet( '$empty_command_error_need_operator_here', current_para[ #current_para ].value, token_value ) )
					return { }, _, false
				end

				table.insert( current_para, { type = token_type, value = token_value } )
				expecting_separator = true
			elseif ( token_type == 'FUNCTION' ) then
				local function_value = string.sub( token_value, 1, #token_value - 1 )
							if ( expecting_separator and #current_para > 0 ) then
					GamePrint( command_name .. '(: ' .. GameTextGet( '$empty_command_error_need_operator_here', current_para[ #current_para ].value, function_value ) )
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
						if ( empty_command_functions[ function_value ].para_names and
						     empty_command_functions[ function_value ].para_names[ para_count_key ] ) then
							para_names = empty_command_functions[ function_value ].para_names[ para_count_key ]
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

						if ( func_name and empty_command_functions[ func_name ] ) then
							if ( #func_paras == 1 and empty_command_functions[ func_name ].action_1_paras ) then
								func_result = empty_command_functions[ func_name ].action_1_paras( c, false, shooter, func_paras[ 1 ] )
							elseif ( #func_paras == 2 and empty_command_functions[ func_name ].action_2_paras ) then
								func_result = empty_command_functions[ func_name ].action_2_paras( c, false, shooter, func_paras[ 1 ], func_paras[ 2 ] )
							elseif ( #func_paras == 3 and empty_command_functions[ func_name ].action_3_paras ) then
								func_result = empty_command_functions[ func_name ].action_3_paras( c, false, shooter, func_paras[ 1 ], func_paras[ 2 ], func_paras[ 3 ] )
							else
								GamePrint( func_name .. '(: ' .. GameTextGet( '$empty_command_error_paras_overflow', tostring( #func_paras ), tostring( max_para ) ) )
								return { }, _, false
							end
						else
							GamePrint( command_name .. '(: ' .. GameTextGet( '$empty_command_error_unknown_function', tostring( func_name ) ) )
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
		GamePrint( GameTextGet( '$empty_command_error_paras_overflow', tostring( max_para ), tostring( #paras ) ) )
		return { }, 0, false
	end

			local result = { }
		local final_para_count = 'para_' .. tostring( #paras )

		local transform_table = nil
		if ( empty_command_functions[ command_name ] and
			 empty_command_functions[ command_name ].transform_tilde_into and
			 empty_command_functions[ command_name ].transform_tilde_into[ final_para_count ] ) then
			transform_table = empty_command_functions[ command_name ].transform_tilde_into[ final_para_count ]
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

	local result_parts = { }
	local expecting_operator = false

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
---@param param_tokens table[]
---@param pattern string
---@param shooter number
---@param tar_x number
---@param tar_y number
---@return string|number|number[]|nil result
---@return boolean is_correct
function evaluate_param_tokens( param_tokens, pattern, shooter, tar_x, tar_y )
	local result, op_num, current_operator, is_correct = nil, nil, nil, true

	for _, token in ipairs( param_tokens ) do
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
			local func_result, func_correct = parse_and_execute_function( token.value, token.params, pattern, shooter, tar_x, tar_y )

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
---@return number|number[]|nil result
---@return boolean is_correct
function parse_and_execute_function( func_name, params_str, pattern, shooter, tar_x, tar_y )
	if ( not empty_command_functions[ func_name ] ) then
		GamePrint( 'evaluate_delayed_expression: ' .. GameTextGet( '$empty_command_error_unknown_function', tostring( func_name ) ) )
		return nil, false
	end

	-- 解析参数字符串为参数列表
	local paras= { }
	local current_param = { }
	local paren_depth = 0
	local i = 1
	local len = #params_str

	while ( i <= len ) do
		local char = string.sub( params_str, i, i )

		if ( char == ',' and paren_depth == 0 ) then
			if ( #current_param > 0 ) then
				table.insert( params, current_param )
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
			-- 可能是函数名
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
					table.insert( current_param, { type = 'FUNCTION', value = potential_func_name, paras= func_params_str } )
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
							table.insert( current_param, { type = 'FUNCTION', value = potential_func_name, paras= func_params_str } )
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
		table.insert( params, current_param )
	end

	local param_values = { }
	for _, param_tokens in ipairs( paras) do
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

	local func_result = nil
	if ( #param_values == 1 and empty_command_functions[ func_name ].action_1_paras ) then
		func_result = empty_command_functions[ func_name ].action_1_paras( { }, true, shooter, param_values[ 1 ] )
	elseif ( #param_values == 2 and empty_command_functions[ func_name ].action_2_paras ) then
		func_result = empty_command_functions[ func_name ].action_2_paras( { }, true, shooter, param_values[ 1 ], param_values[ 2 ] )
	elseif ( #param_values == 3 and empty_command_functions[ func_name ].action_3_paras ) then
		func_result = empty_command_functions[ func_name ].action_3_paras( { }, true, shooter, param_values[ 1 ], param_values[ 2 ], param_values[ 3 ] )
	else
		GamePrint( func_name .. '( : ' .. GameTextGet( '$empty_command_error_paras_overflow', tostring( #param_values ), tostring( 3 ) ) )
		return nil, false
	end

	return func_result, true
end

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
			if ( empty_command_functions[ func_name ].para_names and
			     empty_command_functions[ func_name ].para_names[ para_count_key ] ) then
				para_names = empty_command_functions[ func_name ].para_names[ para_count_key ]
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

			local func_result = nil

			if ( #paras == 1 and empty_command_functions[ func_name ].action_1_paras ) then
				func_result = empty_command_functions[ func_name ].action_1_paras( { }, true, shooter, paras[ 1 ] )
			elseif ( #paras == 2 and empty_command_functions[ func_name ].action_2_paras ) then
				func_result = empty_command_functions[ func_name ].action_2_paras( { }, true, shooter, paras[ 1 ], paras[ 2 ] )
			elseif ( #paras == 3 and empty_command_functions[ func_name ].action_3_paras ) then
				func_result = empty_command_functions[ func_name ].action_3_paras( { }, true, shooter, paras[ 1 ], paras[ 2 ], paras[ 3 ] )
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
					table.insert( tokens, { type = 'FUNCTION', value = func_name, paras= params_str } )
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
			local func_result, func_correct = parse_and_execute_function( token.value, token.params, pattern, shooter, tar_x, tar_y )
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

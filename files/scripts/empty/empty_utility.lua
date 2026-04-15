
empty_path = 'mods/empty_the_blackhole_catgirl/files/'

---打印一切信息
---@param info any
---@param key string|nil
function info_print( info, key )
	if ( key == nil ) then
		key = ''
	end

	local typ = type( info )

	if ( typ == 'table' ) then
		print( '< ' .. typ .. ' > ' .. key .. ': {' )
		for i, _ in pairs( info or { } ) do
			info_print( _, i )
		end
		print( '}' )
	else
		print( '< ' .. typ .. ' > ' .. key .. ': ' .. tostring( info ) )
	end
end

---返回关于时间的3个数, 主要作为随机种子使用
---@return number year_day_minute
---@return number month_hour_second
---@return number game_frame_num
function time_for_vec3( )
	local year1, month1, day1, hour1, minute1, second1 = GameGetDateAndTimeLocal( )
	local year2, month2, day2, hour2, minute2, second2 = GameGetDateAndTimeUTC( )

	local year, month, day, hour, minute, second =
		( year1 or 0 ) + ( year2 or 0 ),
		( month1 or 0 ) + ( month2 or 0 ),
		( day1 or 0 ) + ( day2 or 0 ),
		( hour1 or 0 ) + ( hour2 or 0 ),
		( minute1 or 0 ) + ( minute2 or 0 ),
		( second1 or 0 ) + ( second2 or 0 )

	return ( year + day + minute ), ( month + hour + second ), GameGetFrameNum( )
end

---将角度 deg 转换为弧度 rad
---@param deg number
---@return number rad
function deg_to_rad( deg )
	return math.fmod( deg * math.pi / 180.0, 2 * math.pi )
end

---在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angel°
---@param vel_x number
---@param vel_y number
---@param angle number
---@return number vel_x
---@return number vel_y
function rot_vel( vel_x, vel_y, angle )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local rad = deg_to_rad( -angle )
		local sin, cos = math.sin( rad ), math.cos( rad )

		return cos * vel_x - sin * vel_y, sin * vel_x + cos * vel_y
	end
end

---在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angel°
---@param vel_x number
---@param vel_y number
---@param angle number
---@return number vel_x
---@return number vel_y
function abs_rot_vel( vel_x, vel_y, angle )
	local rad, speed = deg_to_rad( -angle ), math.sqrt( vel_x * vel_x + vel_y * vel_y )
	local sin, cos = math.sin( rad ), math.cos( rad )

	return cos * speed, sin * speed
end

---在不更改速度方向的状态下将速度大小变为 speed
---@param vel_x any
---@param vel_y any
---@param mod any
---@return unknown
---@return unknown
function change_vel( vel_x, vel_y, speed )
	return vel_x * speed, vel_y * speed
end

---获取 NG+ 数
---@return number NG_count
function get_ng_num( )
	return tonumber( SessionNumbersGetValue( 'NEW_GAME_PLUS_COUNT' ) ) or 0
end

---获取缩放比例
---@return number
function get_scale( )
	return tonumber( MagicNumbersGetValue( 'GUI_HP_MULTIPLIER' ) ) or 0
end

---获取金钱数
---@param entity number
---@return number money
function get_money( entity )
	local wallet_comp, money = EntityGetFirstComponent( entity, 'WalletComponent' ), 0

	if ( wallet_comp ) then
		money = ComponentGetValue2( wallet_comp, 'money' ) or 0
	end

	return money
end

---返回任意数据的全大写数据类型
---@param any any
---@return string upper_type
function upper_type( any )
	return string.upper( type( any ) )
end

---以包含 2 项的数组作为最值获取随机数
---@param target number[]
---@return number
function get_random_between_range( target )
	return Random( target[ 1 ], target[ 2 ] )
end

---获取 target 内的随机 1 项
---@param target table
---@return any
function get_random_from( target )
	return target[ Random( 1, #target ) ]
end

---向 main 内加入 merge 内的每项;
---可在加入前清空 main 或在加入后清空 merge
---@param main table
---@param merge table
---@param is_clean_main boolean|nil --默认为 false
---@param is_clean_merge boolean|nil --默认为 true
function add_table( main, merge, is_clean_main, is_clean_merge )
	if ( is_clean_main == nil ) then
		is_clean_main = false
	end
	if ( is_clean_merge == nil ) then
		is_clean_merge = true
	end

	if ( is_clean_main ) then
		for _ = 1, #main do
			main[ _ ] = nil
		end
	end

	if ( merge ) then
		local merge_len = #merge

		for _ = 1, merge_len do
			table.insert( main, merge[ _ ] )
		end

		if ( is_clean_merge ) then
			for _ = 1, merge_len do
				merge[ _ ] = nil
			end
		end
	end
end

---在 main 内通过 id 查找并替换 replace 内的每项;
---可在替换后清空 replace
---@param main table
---@param replace table
---@param is_clean_replace boolean|nil --默认为 true
function replace_table( main, replace, is_clean_replace )
	if ( is_clean_replace == nil ) then
		is_clean_replace = true
	end

	for i, new in ipairs( replace ) do
		for j, old in ipairs( main ) do
			if ( old.id == new.id ) then
				for _, value in pairs( new ) do
					main[ j ][ _ ] = value
				end

				break
			end
		end
	end

	if ( is_clean_replace ) then
		for _ = 1, #replace do
			replace[ _ ] = nil
		end
	end
end

---将 main 逆序并返回;
---可修改 main
---@param main table
---@param is_change_main boolean|nil --默认为 true
---@return table reversed_table
function reverse_table( main, is_change_main )
	if ( is_change_main == nil ) then
		is_change_main = true
	end

	local reversed, len = { }, #main

	for i = len, 1, -1 do
		table.insert( reversed, main[ i ] )
	end

	if ( is_change_main ) then
		for _, v in ipairs( reversed ) do
			main[ _ ] = v
		end
	end

	return reversed
end

---交换 2 个 table 的内容
---@param table1 table
---@param table2 table
function swap_table( table1, table2 )
	local tmp = { }

	add_table( tmp, table1, false, false )
	add_table( table1, table2, true, true )
	add_table( table2, tmp, false, false )
end

---将 from 中第 pos_from 项移动至 to 中 pos_to 位置
---@param from table
---@param to table
---@param pos_from integer|nil --默认为 1
---@param pos_to integer|nil --默认为 #to + 1
function add_table_1( from, to, pos_from, pos_to )
	if ( pos_from == nil ) then
		pos_from = 1
	end

	if ( pos_to == nil ) then
		pos_to = #to + 1
	end

	table.insert( to, pos_to, table.remove( from, pos_from ) )
end

---将 merge 中 顺数 / 倒数 前 count 项 保持 / 反转 顺序移动至 main 中 最前 / 最后 位置
---@param from table
---@param to table
---@param count integer
---@param from_front boolean|nil --默认为 true
---@param to_front boolean|nil --默认为 false
---@param is_reverse_order boolean|nil --默认为 false
function add_table_count( from, to, count, from_front, to_front, is_reverse_order )
	if ( count < 1 ) then
		return
	end
	if ( count > #from ) then
		count = #from
	end

	if ( from_front == nil ) then
		from_front = true
	end
	if ( to_front == nil ) then
		to_front = false
	end
	if ( is_reverse_order == nil ) then
		is_reverse_order = false
	end

	local tmp = { }

	for _ = 1, count, 1 do
		local pin1, pin2 = _, #from

		if ( is_reverse_order ) then
			pin1 = 1
		end

		if ( from_front ) then
			pin2 = 1
		end

		table.insert( tmp, pin1, table.remove( from, pin2 ) )
	end

	if ( to_front ) then
		for _ = 1, count, 1 do
			table.insert( to, _, table.remove( tmp, 1 ) )
		end
	else
		for _ = 1, count, 1 do
			table.insert( to, #to + 1, table.remove( tmp, 1 ) )
		end
	end
end

--- ( 未使用 ) 确保 check 内有 keys 属性路径
---@param check table
---@param keys string[]
---@return table ensure
function ensure_table( check, keys )
	for i, _ in ipairs( keys or { } ) do
		if ( type( check[ _ ] ) ~= 'table' ) then
			check[ _ ] = { }
		end

		check = check[ _ ]
	end

	return check
end

---从 random_table 中随机选取 count 项; count 或 random_table 的长度小于 1 时返回空表;
---count 大于 random_table 的长度时变作与 random_table 的长度相同
---@param random_table table
---@param count number
---@return table select_items
function random_gets( random_table, count )
	if ( #random_table < 1 or count < 1 ) then
		return { }
	end

	local original, select_items = { }, { }
	add_table( original, random_table, false, false )

	count = math.min( count, #original )

	local a, b, c = time_for_vec3( )
	SetRandomSeed( a - c, b - c )

	for _ = 1, count, 1 do
		table.insert( select_items, table.remove( original, Random( 1, #original ) ) )
	end

	return select_items
end

---为仅包含 number · string 类型的 table 去重, 返回去重后的 table
---@param str_table any
---@return table table_remove_duplica
function remove_duplicates( str_table )
	local seen, result = { }, { }

	for _, each in ipairs( str_table ) do
		local str_each = tostring( each )
		if ( not seen[ str_each ] ) then
			seen[ str_each ] = true
			table.insert( result, each )
		end
	end

	return result
end

---为 location 排序;
---仅可用于法术的 action( ) 中对 卡组 · 手卡 · 墓地 的操作
---@param location table[]
---@return table[] location_sort
function loc_sort( location )
	if ( #location < 2 ) then
		return location
	end

	table.sort( location, function( a, b )
		local a_index = a.deck_index or 0
		local b_index = b.deck_index or 0

		return a_index < b_index
	end)

	return location
end

---打乱 location 的顺序
---@param loc table
---@return table location_shuffle
function loc_shuffle( loc )
	if ( #loc < 2 ) then
		return loc
	end

	for _ = #loc, 2, -1 do
		local diff = Random( #loc, 1 )
		loc[ _ ], loc[ diff ] = loc[ diff ], loc[ _ ]
	end

	return loc
end

---检查 str 是否表示 16 进制数
---@param str string|number
---@return boolean is_hex
local function is_hex( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 2 and string.sub( str, 1, 2 ) == '0x' and ( not string.match( string.sub( str, 3 ), '[^0-9a-f]' ) )
end

---检查 str 是否表示 10 进制数
---@param str string|number
---@return boolean is_dec
local function is_dec( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 0 and ( ( str == '0' ) or ( string.sub( str, 1, 1 ) ~= '0' and not string.match( str, '[^0-9]' ) ) )
end

---检查 str 是否表示 8 进制数
---@param str string|number
---@return boolean is_oct
local function is_oct( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 1 and string.sub( str, 1, 1 ) == '0' and ( not string.match( str, '[^0-7]' ) )
end

---检测这是否是数
---@param str string|number
---@return boolean is_num
function is_num( str )
	if ( type( str ) == 'number' ) then
		return true
	end

	return is_hex( str ) or is_dec( str ) or is_oct( str )
end

---将 str 转换为对应的数值, 能自动检测是表示 16 · 10 · 8 进制数值的字符串;
---不是表示这三种进制数值的字符串则返回nil
---@param str string|number
---@return number|nil
function number_handler( str )
	if type( str ) == 'number' then
		return str
	end
	if type( str ) ~= 'string' then
		return nil
	end

	local is_negative = false
	local str_pure = str
	if ( string.sub( str_pure, 1, 1 ) == '-' ) then
		is_negative = true
		str_pure = string.sub( str_pure, 2, #str_pure )
	end

	local result = nil
	if ( is_num( str ) ) then
		if ( is_hex( str_pure ) ) then
			result = tonumber( str_pure, 16 )
		elseif ( is_dec( str_pure ) ) then
			result = tonumber( str_pure, 10 )
		elseif ( is_oct( str_pure ) ) then
			result = tonumber( str_pure, 8 )
		end
	else
		return nil
	end

	if ( result ) then
		if ( is_negative ) then
			return -result
		else
			return result
		end
	else
		return nil
	end
end

---获取最近的玩家
---@param tar_x number
---@param tar_y number
---@param tar_id number
---@return number|nil closest
function get_closest_player( tar_x, tar_y, tar_id )
	local x, y = nil, nil

	if ( tar_x ) and ( tar_y ) then
		x, y = tar_x, tar_y
	elseif ( tar_id ) then
		x, y = EntityGetTransform( tar_id )
	end

	local closest = nil

	if ( x ) and ( y ) then
		local players = EntityGetWithTag( 'player_unit' ) or { }

		add_table( players, EntityGetWithTag( 'polymorphed_player' ) or { }, false, true )

		if ( #players > 1 ) then
			local min_distance = math.huge

			for _, player_id in ipairs( players ) do
				local px, py = EntityGetTransform( player_id )
				if ( px and py ) then
					local distance_pow_2 = ( x - px ) ^ 2 + ( y - py ) ^ 2

					if ( distance_pow_2 < min_distance ) then
						min_distance = distance_pow_2
						closest = player_id
					end
				end
			end
		elseif ( #players == 1 ) then
			closest = players[ 1 ]
		end
	end

	return closest
end

---解析键值对字符串（智能处理值中的逗号、括号和引号）
---@param str string 解析字符串
---@param remove_quotes boolean|nil 是否去除引号包裹
---@return table result_table
function parse_kv_pairs( str, remove_quotes )
	local result = { }
	local current_key = ''
	local current_value = ''
	local in_value = false
	local paren_depth = 0
	local in_quote = false
	for i = 1, #str do
		local char = string.sub( str, i, i )
		if ( not in_value ) then
			if ( char == '=' ) then
				in_value = true
				current_value = ''
			elseif ( char == ',' ) then
				current_key = ''
			else
				current_key = current_key .. char
			end
		else
			if ( char == '\'' and not in_quote ) then
				in_quote = true
				current_value = current_value .. char
			elseif ( char == '\'' and in_quote ) then
				in_quote = false
				current_value = current_value .. char
			elseif ( in_quote ) then
				current_value = current_value .. char
			elseif ( char == '(' ) then
				paren_depth = paren_depth + 1
				current_value = current_value .. char
			elseif ( char == ')' ) then
				paren_depth = paren_depth - 1
				current_value = current_value .. char
			elseif ( char == ',' and paren_depth == 0 ) then
				if ( #current_key > 0 ) then
					local final_value = current_value
					if ( remove_quotes and string.sub( current_value, 1, 1 ) == '\'' and string.sub( current_value, -1 ) == '\'' ) then
						final_value = string.sub( current_value, 2, -2 )
					end
					result[ current_key ] = final_value
				end
				current_key = ''
				current_value = ''
				in_value = false
			else
				current_value = current_value .. char
			end
		end
	end
	if ( in_value and #current_key > 0 ) then
		local final_value = current_value
		if ( remove_quotes and string.sub( current_value, 1, 1 ) == '\'' and string.sub( current_value, -1 ) == '\'' ) then
			final_value = string.sub( current_value, 2, -2 )
		end
		result[ current_key ] = final_value
	end
	return result
end

---将 values 转换为被 pattern 严格闭合的格式化字符串
---@param values table
---@param pattern string
---@return string formatted_str
function trans_table_to_format( values, pattern )
	if type( values ) ~= 'table' or type( pattern ) ~= 'string' then
		return ''
	end

	local result_parts = { }

	for key, value in pairs( values ) do
		local value_str = tostring( value )
		if ( string.find( value_str, ',' ) or string.find( value_str, '=' ) ) then
			value_str = '\'' .. value_str .. '\''
		end
		table.insert( result_parts, key .. '=' .. value_str )
	end

	return pattern .. table.concat( result_parts, ',' ) .. pattern
end

---从 str 内搜索被 pattern 严格闭合的 id 键值为指定 id 的表，返回搜索到的第 1 个表
---@param str string
---@param id string
---@param pattern string
---@return table|nil result_table
function search_table_from_format( str, id, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( pattern ) ~= 'string' then
		return nil
	end

	local result = nil
	local pos = 1
	local len = #str
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( str, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( str, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( str, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) and ',' or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if valid_before and valid_after then
				result = { }
				local kv_start = 1

				while ( kv_start <= #content ) do
					local eq_pos = string.find( content, '=', kv_start, true )
					if ( not eq_pos ) then
						break
					end

					local key = string.sub( content, kv_start, eq_pos - 1 )
					local value_start = eq_pos + 1
					local value = ''

					if ( value_start <= #content ) then
						local first_char = string.sub( content, value_start, value_start )
						if ( first_char == '(' ) then
							local paren_depth = 1
							local pos = value_start + 1
							while ( pos <= #content and paren_depth > 0 ) do
								local char = string.sub( content, pos, pos )
								if ( char == '(' ) then
									paren_depth = paren_depth + 1
								elseif ( char == ')' ) then
									paren_depth = paren_depth - 1
								end
								pos = pos + 1
							end
							local comma_pos = string.find( content, ',', pos - 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, value_start, value_end - 1 )
							kv_start = value_end
						elseif ( first_char == '\'' ) then
							local quote_end = string.find( content, '\'', value_start + 1, true )
							if ( quote_end ) then
								local comma_pos = string.find( content, ',', quote_end + 1, true )
								local value_end = comma_pos or ( #content + 1 )
								value = string.sub( content, value_start + 1, quote_end - 1 )
								kv_start = value_end
							else
								value = string.sub( content, value_start + 1 )
								kv_start = #content + 1
							end
						else
							local comma_pos = string.find( content, ',', eq_pos + 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, eq_pos + 1, value_end - 1 )
							kv_start = value_end
						end
					end

					result[ key ] = value
					kv_start = kv_start + 1
				end

				if ( result.id == id ) then
					break
				else
					result = nil
				end
			end
		end

		pos = end_pos + pattern_len
	end

	return result
end

---@param str string 原始字符串
---@param id string 要合并的 id
---@param values table 需要合并的键值对
---@param pattern string 边界标记
---@return string str_merged 合并后的字符串
function merge_table_by_id( str, id, values, pattern )
	if ( type( str ) ~= 'string' or type( id ) ~= 'string' or type( values ) ~= 'table' or type( pattern ) ~= 'string' ) then
		return str
	end

	local result = str
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) and ',' or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if ( valid_before and valid_after ) then
				local original_table = { }
				local kv_start = 1

				while ( kv_start <= #content ) do
					local eq_pos = string.find( content, '=', kv_start, true )
					if ( not eq_pos ) then
						break
					end

					local key = string.sub( content, kv_start, eq_pos - 1 )
					local value_start = eq_pos + 1
					local value = ''

					if ( value_start <= #content ) then
						local first_char = string.sub( content, value_start, value_start )
						if ( first_char == '(' ) then
							local paren_depth = 1
							local p = value_start + 1
							while ( p <= #content and paren_depth > 0 ) do
								local char = string.sub( content, p, p )
								if ( char == '(' ) then
									paren_depth = paren_depth + 1
								elseif ( char == ')' ) then
									paren_depth = paren_depth - 1
								end
								p = p + 1
							end
							local comma_pos = string.find( content, ',', p - 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, value_start, value_end - 1 )
							kv_start = value_end
						elseif ( first_char == '\'' ) then
							local quote_end = string.find( content, '\'', value_start + 1, true )
							if ( quote_end ) then
								local comma_pos = string.find( content, ',', quote_end + 1, true )
								local value_end = comma_pos or ( #content + 1 )
								value = string.sub( content, value_start + 1, quote_end - 1 )
								kv_start = value_end
							else
								value = string.sub( content, value_start + 1 )
								kv_start = #content + 1
							end
						else
							local comma_pos = string.find( content, ',', eq_pos + 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, eq_pos + 1, value_end - 1 )
							kv_start = value_end
						end
					end

					original_table[ key ] = value
					kv_start = kv_start + 1
				end

				for key, new_value in pairs( values ) do
					if ( key ~= 'id' ) then
						local old_value = original_table[ key ]
						if ( old_value ) then
							local old_num = number_handler( old_value )
							local new_num = number_handler( new_value )
							if ( old_num and new_num ) then
								original_table[ key ] = tostring( old_num + new_num )
							else
								original_table[ key ] = tostring( new_value )
							end
						else
							original_table[ key ] = tostring( new_value )
						end
					end
				end

				local new_kv_parts = { }
				for key, value in pairs( original_table ) do
					local value_str = tostring( value )
					if ( string.find( value_str, ',' ) or string.find( value_str, '=' ) ) then
						value_str = '\'' .. value_str .. '\''
					end
					table.insert( new_kv_parts, key .. '=' .. value_str )
				end
				local new_content = table.concat( new_kv_parts, ',' )
				local new_block = pattern .. new_content .. pattern

				result = string.sub( result, 1, start_pos - 1 ) .. new_block .. string.sub( result, end_pos + pattern_len )

				len = #result
				pos = start_pos + #new_block
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---将 str 内被 pattern 严格闭合的 id 键值为指定 id 的表替换为 values 中的值，返回修改后的字符串
---@param str string
---@param id string
---@param values table
---@param pattern string
---@return string str_replaced
function replace_table_by_id( str, id, values, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( values ) ~= 'table' or type( pattern ) ~= 'string' then
		return str
	end

	local result = str
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if ( valid_before and valid_after ) then
				local new_kv_parts = { }
				for key, value in pairs( values ) do
					table.insert( new_kv_parts, key .. '=' .. tostring( value ) )
				end
				local new_content = table.concat( new_kv_parts, ',' )
				local new_block = pattern .. new_content .. pattern

				result = string.sub( result, 1, start_pos - 1 ) .. new_block .. string.sub( result, end_pos + pattern_len )

				len = #result
				pos = start_pos + #new_block
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---从 str 内删除被 pattern 严格闭合的 id 键值为指定 id 的前 count 个表，返回修改后的字符串
---@param str string
---@param id string
---@param count number
---@param pattern string
---@return string str_deleted
function delete_table_format( str, id, count, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( count ) ~= 'number' or type( pattern ) ~= 'string' then
		return str
	end

	local result = str
	local deleted_count = 0
	local delete_all = ( count == -1 )
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len and ( delete_all or deleted_count < count ) ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1) or ( before_char == ',' )
			local valid_after = ( after_char == ',') or ( after_id_end == #content )

			if valid_before and valid_after then
				result = string.sub( result, 1, start_pos - 1 ) .. string.sub( result, end_pos + pattern_len )
				deleted_count = deleted_count + 1

				len = #result
				pos = start_pos
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---为 c.action_description 新增 args;
---可替换或叠加
---@param c table
---@param can_replace boolean|nil
---@param can_merge boolean|nil
---@param args table|nil
---@param extra_entities string|nil
---@param pattern string
function add_desc_by_info( c, can_replace, can_merge, args, extra_entities, pattern )
	if ( not reflecting and args ) then
		local prefix = '::__DELAY_EXP__::'
		for i, _ in pairs( args ) do
			if ( type( _ ) == 'string' ) then
				local pos = string.find( _, prefix, 1, true )

				if ( pos == 1 ) then
					args[ i ] = string.sub( _, #prefix + 1 )
				end
			end
		end

		local desc = c.action_description or ''
		local values = search_table_from_format( desc, args.id, pattern )

		if ( values and can_replace ) then
			local str = nil

			if ( can_merge ) then
				str = merge_table_by_id( desc, args.id, args, pattern )
			else
				str = replace_table_by_id( desc, args.id, args, pattern )
			end

			c.action_description = str
		else
			c.action_description = desc .. trans_table_to_format( args, pattern )

			if ( extra_entities ) then
				c.extra_entities = ( c.extra_entities or '' ) .. extra_entities
			end
		end
	end
end

---解析 command 的参数并求值
---@param action_id string action_description 中的 id
---@param entity_id number 实体 ID
---@param param_names string[] 参数名数组，例如 { 'lifetime' } 或 { 'tp_entities', 'x', 'y' }
---@return table|nil result_table 返回包含 shooter 和参数的键值对表，失败返回 nil
function parse_and_evaluate_command_params( action_id, entity_id, param_names )
	local p_comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )
	if ( not p_comp ) then
		return nil
	end

	local desc = ComponentObjectGetValue2( p_comp, 'config', 'action_description' )
	local values = search_table_from_format( desc, action_id, '$' )
	if ( not values ) then
		return nil
	end

	local shooter = tonumber( values[ 'shooter' ] ) or 0
	local x, y = EntityGetTransform( entity_id )

	local result_table = {}
	result_table.shooter = shooter

	for _, param_name in ipairs( param_names ) do
		local raw_value = values[ param_name ]
		if ( raw_value ~= nil ) then
			if ( string.find( raw_value, '@', 1, true ) or string.find( raw_value, '~', 1, true ) or string.find( raw_value, '(', 1, true ) ) then
				local result, is_correct = evaluate_delayed_expression( raw_value, '#', shooter, x, y )
				if ( is_correct and result ~= nil ) then
					result_table[ param_name ] = result
				end
				-- 求值失败则不创建该键
			else
				local num = tonumber( raw_value )
				if ( num ~= nil ) then
					result_table[ param_name ] = num
				end
				-- 转换失败则不创建该键
			end
		end
		-- 键不存在则不创建
	end

	return result_table
end

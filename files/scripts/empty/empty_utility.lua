
empty_path = 'mods/empty_the_blackhole_catgirl/files/'

int_huge = 2147483647
math_2p = 2 * math.pi
math_e = math.exp( 1 )
epsilon = 0.0003

chunk_len = 512

all_curses = {
	'CURSE_MONK',
	'CURSE_ALWAYS_SHUFFLE',
	'CURSE_SHORT_WAND',
	'CURSE_MALICE_WASHES_OVER',
	'CURSE_REALITY_SHIFT',
	'CURSE_GUARANTEED_LOSE',
	'CURSE_GRAVITY_FREE',
	'CURSE_DEATH_TRAIL',
	--'CURSE_FURIOUS_COCKTAIL',
}

all_d_muls = {
	'melee',
	'projectile',
	'explosion',
	'electricity',
	'fire',
	'ice',
	'drill',
	'slice',
	'physics_hit',
	'radioactive',
	'poison',
	'curse',
	'holy',
	'healing',
}

all_d_muls_0 = {
	melee = 0,
	projectile = 0,
	explosion = 0,
	electricity = 0,
	fire = 0,
	ice = 0,
	drill = 0,
	slice = 0,
	physics_hit = 0,
	radioactive = 0,
	poison = 0,
	curse = 0,
	holy = 0,
	healing = 0,
}

all_proj_dmg = {
	'melee',
	'explosion',
	'electricity',
	'fire',
	'ice',
	'slice',
	'drill',
	'physics_hit',
	'radioactive',
	'poison',
	'curse',
	'holy',
	'healing',
}

all_proj_dmg_0 = {
	melee = 0,
	explosion = 0,
	electricity = 0,
	fire = 0,
	ice = 0,
	slice = 0,
	drill = 0,
	physics_hit = 0,
	radioactive = 0,
	poison = 0,
	curse = 0,
	holy = 0,
	healing = 0,
}

all_proj_dmg_0_dmg_by_type = {
	{ 'damage_by_type', 'melee', 0 },
	{ 'damage_by_type', 'explosion', 0 },
	{ 'damage_by_type', 'electricity', 0 },
	{ 'damage_by_type', 'fire', 0 },
	{ 'damage_by_type', 'ice', 0 },
	{ 'damage_by_type', 'slice', 0 },
	{ 'damage_by_type', 'drill', 0 },
	{ 'damage_by_type', 'physics_hit', 0 },
	{ 'damage_by_type', 'radioactive', 0 },
	{ 'damage_by_type', 'poison', 0 },
	{ 'damage_by_type', 'curse', 0 },
	{ 'damage_by_type', 'holy', 0 },
	{ 'damage_by_type', 'healing', 0 },
}

all_tag = {
	hit = 'hittable',
	player = 'player_unit',
	poly_player = 'polymorphed_player',
	enemy = 'enemy',
}

orbit_loc_fix = {
	{ x = 12, y = 12 },
	{ x = 12, y = -12 },
	{ x = -12, y = 12 },
	{ x = -12, y = -12 },
}

max_adjust = 180

---打印一切信息, 此函数仅用于调试; 
---正式版本中不应该看见任何地方调用这个函数
---@param info any
---@param key string|nil
---@param tab_count number|nil
function info_print( info, key, tab_count )
	if ( key == nil ) then
		key = ''
	end
	if ( tab_count == nil ) then
		tab_count = 0
	end

	local typ = type( info )

	if ( typ == 'table' ) then
		if ( tab_count == 0 ) then
			print( '< ' .. typ .. ' > ' .. key .. ': {' )
		else
			print( string.rep( '\t', tab_count ) .. '< ' .. typ .. ' > ' .. key .. ': {' )
		end

		for i, _ in pairs( info or { } ) do
			info_print( _, i, tab_count + 1 )
		end

		if ( tab_count == 0 ) then
			print( '}' )
		else
			print( string.rep( '\t', tab_count ) .. '}' )
		end
	else
		if ( tab_count == 0 ) then
			print( '< ' .. typ .. ' > ' .. key .. ': ' .. tostring( info ) )
		else
			print( string.rep( '\t', tab_count ) .. '< ' .. typ .. ' > ' .. key .. ': ' .. tostring( info ) )
		end
	end
end

---显示重要信息
---@param title string|nil
---@param desc string|nil
function imp_print( title, desc )
	if ( type( title ) == 'string' and type( desc ) == 'string' ) then
		GamePrintImportant( title, desc )
	elseif ( type( title ) == 'string' and type( desc ) ~= 'string' ) then
		GamePrintImportant( title, '' )
	end
end

---发送提示信息
---@param name string
---@param ... any
function command_print( name, ... )
	GamePrint( name .. ' : ' .. GameTextGet( ... ) )
end

if ( not ModSettingGet( 'empty_the_blackhole_catgirl.COMMAND_FEEDBACK' ) ) then
	command_print = function ( name, ... )
		--
	end
end

---返回关于时间的 3 个数, 主要作为随机种子使用
---@return number year_day_min
---@return number mon_hour_sec
---@return number frame_num
function time_for_vec3( )
	local year1, mon1, day1, hour1, min1, sec1 = GameGetDateAndTimeLocal( )
	local year2, mon2, day2, hour2, min2, sec2 = GameGetDateAndTimeUTC( )

	local year, mon, day, hour, min, sec =
		( year1 or 0 ) + ( year2 or 0 ),
		( mon1 or 0 ) + ( mon2 or 0 ),
		( day1 or 0 ) + ( day2 or 0 ),
		( hour1 or 0 ) + ( hour2 or 0 ),
		( min1 or 0 ) + ( min2 or 0 ),
		( sec1 or 0 ) + ( sec2 or 0 )

	return ( year + day + min ), ( mon + hour + sec ), GameGetFrameNum( )
end

---设置随机数种子, 返回 entity 的位置
---@param entity number|nil
---@return number|nil x
---@return number|nil y
function set_r_seed( entity )
	local a, b, c = time_for_vec3( )

	if ( entity and entity ~= NULL_ENTITY ) then
		local x, y = EntityGetTransform( entity )

		SetRandomSeed( x - a + c, y - b + c )

		return x, y
	else
		SetRandomSeed( a - c, b - c )

		return nil, nil
	end
end

---返回平行世界位置
---@param x number
---@param y number
---@return table<number, number, number, number> pw_info
function get_para_pos( x, y )
	local p_info = { }

	p_info.pw_lr, p_info.pw_ud = GetParallelWorldPosition( x, y )

	local m_width, m_high = BiomeMapGetSize( )

	local x_half, y_half = chunk_len * m_width / 2, chunk_len * m_high / 2

	p_info.p_x = ( ( x + x_half ) % m_width ) - x_half
	p_info.p_y = ( ( y + y_half ) % m_high ) - y_half

	return p_info
end

---返回任意数据的全大写数据类型
---@param any any
---@return string upper_type
function upper_type( any )
	return string.upper( type( any ) )
end

---根据 k_table 模板表创建键值全为 v 的表
---@param k_table table|nil
---@param v any
---@return table v_table
function create_all_table( k_table, v )
	local v_table = { }

	for i, _ in ipairs( k_table or { } ) do
		v_table[ _ ] = v
	end

	return v_table
end

---Lanczos 近似系数 ( g = 7, n = 9 )
local lanc_coeff = {
	0.99999999999980993,
	676.5203681218851,
	-1259.1392167224028,
	771.32342877765313,
	-176.61502916214059,
	12.507343278686905,
	-0.13857109526572012,
	9.9843695780195716e-6,
	1.5056327351493116e-7,
}

---math.log( Γ( z ) )
---@param z number
---@return number log_Γ_z
function ln_gamma( z )
	if ( z < 0.5 ) then
		return math.log( math.pi / math.sin( math.pi * z ) ) - ln_gamma( 1 - z )
	else
		z = z - 1

		local x = lanc_coeff[ 1 ]

		for i = 2, #lanc_coeff, 1 do
			x = x + lanc_coeff[ i ] / ( z + i - 1 )
		end

		local t = z + #lanc_coeff - 0.5

		return math.log( math.sqrt( math_2p ) ) + ( z + 0.5 ) * math.log( t ) - t + math.log( x )
	end
end

---Γ( z )
---@param z number
---@return number Γ_z
function gamma( z )
	return math.exp( ln_gamma( z ) )
end

---z 的阶乘, 支持解析延拓
---@param z number
---@return number fact_z
function fact( z )
	if ( z == 0 ) then
		return 1
	elseif ( z < 0 and z == math.floor( z ) ) then
		return 0
	else
		return gamma( z + 1 )
	end
end

---检测 num 是否是数值且不为 0
---@param num any
---@return boolean is_not_0_num
function is_not_0_num( num )
	return type( num ) == 'number' and num ~= 0 and num == num
end

---检测 str 是否是字符串且不为空字符串
---@param str any
---@return boolean is_not_nil_str
function is_not_nil_str( str )
	return type( str ) == 'string' and str ~= ''
end

---检测 v_table 是否是表且不为空表
---@param v_table any
---@return boolean is_not_nil_table
function is_not_nil_table( v_table )
	return type( v_table ) == 'table' and next( v_table ) ~= nil
end

---检测 num 是否为整数
---@param num any
---@return boolean is_int
function is_int( num )
	return type( num ) == 'number' and num == math.floor( num )
end

---判断实体是否存活
---@param entity number
---@return boolean is_alive
function is_alive( entity )
	return ( is_not_0_num( entity ) and EntityGetIsAlive( entity ) )
end

---判断实体是否为玩家, 含变形
---@param entity number
---@return boolean is_player
function is_player( entity )
	return ( is_not_0_num( entity )
		and ( EntityHasTag( entity, 'player_unit' ) or EntityHasTag( entity, 'polymorphed_player' ) ) )
end

---判断实体是否为敌怪
---@param entity number
---@return boolean is_enemy
function is_enemy( entity )
	return ( is_not_0_num( entity )
		and ( EntityHasTag( entity, 'enemy' ) ) )
end

---检查 search 内是否包含 value
---@param value any
---@param search table|nil
---@return boolean is_in
function is_in( value, search )
	if ( type( search ) ~= 'table' ) then
		return false
	end

	for _, v in ipairs( search ) do
		if ( v == value ) then
			return true
		end
	end

	return false
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
---@param is_clean_main boolean|nil? --默认为 false
---@param is_clean_merge boolean|nil? --默认为 true
function add_table( main, merge, is_clean_main, is_clean_merge )
	if ( is_clean_main == nil ) then
		is_clean_main = false
	end
	if ( is_clean_merge == nil ) then
		is_clean_merge = true
	end

	if ( is_clean_main ) then
		for _ = #main, 1, -1 do
			main[ _ ] = nil
		end
	end

	if ( merge ) then
		for _ = 1, #merge do
			table.insert( main, merge[ _ ] )
		end

		if ( is_clean_merge ) then
			for _ = #merge, 1, -1 do
				merge[ _ ] = nil
			end
		end
	end
end

---在 main 内通过 id 查找并替换 replace 内的每项; 
---设置 pre_id 的场合, 将对比 pre_id 并将 id 更改为新的 id; 
---可在替换后清空 replace
---@param main table
---@param replace table
---@param is_clean_replace boolean|nil? --默认为 true
function update_table_by_id( main, replace, is_clean_replace )
	if ( is_clean_replace == nil ) then
		is_clean_replace = true
	end

	for i, new in ipairs( replace ) do
		for j, old in ipairs( main ) do
			if ( type( new.pre_id ) == 'string' ) then
				if ( old.id == new.pre_id ) then
					new.pre_id = nil

					for k, _ in pairs( new ) do
						main[ j ][ k ] = _
					end

					break
				end
			else
				if ( old.id == new.id ) then
					for k, _ in pairs( new ) do
						main[ j ][ k ] = _
					end

					break
				end
			end
		end
	end

	if ( is_clean_replace ) then
		for _ = #replace, 1, -1 do
			replace[ _ ] = nil
		end
	end
end

---将 main 逆序并返回; 
---可修改 main
---@param main table
---@param is_change_main boolean|nil? --默认为 true
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
---@param pos_from integer|nil? --默认为 1
---@param pos_to integer|nil? --默认为 #to + 1
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
---@param from_front boolean|nil? --默认为 true
---@param to_front boolean|nil? --默认为 false
---@param is_reverse_order boolean|nil? --默认为 false
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

		if ( is_reverse_order and from_front ) or ( not is_reverse_order and not from_front ) then
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

---从 random_table 中随机选取 count 项; 
---count 或 random_table 的长度小于 1 时返回空表; 
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

---为仅包含 number / string 类型的 table 去重, 返回去重后的 table
---@param num_str_table any
---@return table remove_dupli
function remove_duplicates( num_str_table )
	local seen, res = { }, { }

	for _, each in ipairs( num_str_table ) do
		local str_each = tostring( each )
		if ( not seen[ str_each ] ) then
			seen[ str_each ] = true
			table.insert( res, each )
		end
	end

	return res
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

---打乱 loc 的顺序; 
---仅可用于法术的 action( ) 中对 卡组 · 手卡 · 墓地 的操作
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

---获取速度的模
---@param vel_x number
---@param vel_y number
---@return number length
function get_len( vel_x, vel_y )
	if ( vel_x == 0 ) then
		if ( vel_y == 0 ) then
			return 0
		else
			return vel_y
		end
	else
		if ( vel_y == 0 ) then
			return vel_x
		else
			return math.sqrt( vel_x ^ 2 + vel_y ^ 2 )
		end
	end
end

---标准化向量
---@param vel_x number
---@param vel_y number
---@return number vel_x
---@return number vel_y
function normalize( vel_x, vel_y )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local len = get_len( vel_x, vel_y )

		return vel_x / len, vel_y / len
	end
end

---在不更改速度方向的状态下将速度大小变为 speed
---@param vel_x number
---@param vel_y number
---@param speed number
---@return number vel_x
---@return number vel_y
function change_vel( vel_x, vel_y, speed )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		vel_x, vel_y = normalize( vel_x, vel_y )

		return vel_x * speed, vel_y * speed
	end
end

---将 count 个点以 gap 为间距排列在 x 轴上，整体中心位于 x = 0; 
---返回第 num 个点的 x 坐标
---@param count number
---@param gap number
---@param num number
---@return number result
function loc_center_fix( count, gap, num )
	return ( num - ( count - 1 ) / 2 - 1 ) * gap
end

---从 (x1, y1) 出发，向 (x2, y2) 方向移动 dis 距离, 返回终点坐标
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param dis number|nil?
---@return number
---@return number
function move_toward( x1, y1, x2, y2, dis )
	if ( not dis or dis == 0 ) then
		return x1, y1
	else
		local dx, dy = change_vel( x2 - x1, y2 - y1, dis )

		return x1 + dx, y1 + dy
	end
end

---计算两点之间的引力, 返回应当产生的动量
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param dist_full number
---@param coeff number|nil
---@return number vel_x
---@return number vel_y
function gravity_force_loc( x1, y1, x2, y2, dist_full, coeff )
	coeff = coeff or 196

	local dist = math.sqrt( ( x1 - x2 ) ^ 2 + ( y1 - y2 ) ^ 2 )
	local dirc = -math.atan2( ( y1 - y2 ), ( x1 - x2 ) )

	local per = ( dist_full - dist ) / dist_full

	return math.cos( dirc ) * per * coeff, -math.sin( dirc ) * per * coeff
end

---将角度 deg 转换为弧度 rad
---@param deg number
---@return number rad
function deg_to_rad( deg )
	local rad = math.fmod( deg * math.pi / 180.0, math_2p )

	if ( rad > math.pi ) then
		rad = rad - math_2p
	elseif ( rad < -math.pi ) then
		rad = rad + math_2p
	end

	return rad
end

---在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angle°
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

---在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angle°
---@param vel_x number
---@param vel_y number
---@param angle number
---@return number vel_x
---@return number vel_y
function abs_rot_vel( vel_x, vel_y, angle )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local rad, speed = deg_to_rad( -angle ), math.sqrt( vel_x * vel_x + vel_y * vel_y )
		local sin, cos = math.sin( rad ), math.cos( rad )

		return cos * speed, sin * speed
	end
end

---获取 NG+ 数
---@return number NG_count
function get_ng_count( )
	return tonumber( SessionNumbersGetValue( 'NEW_GAME_PLUS_COUNT' ) ) or 0
end

---获取生命显示比例
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

---将 num 的值调整至 min, max 之间
---@param min number
---@param num number
---@param max number
---@return number num
function cap( min, num, max )
	if ( min == max ) then
		return max
	end
	if ( min > max ) then
		min, max = max, min
	end

	return math.max( min, math.min( num, max ) )
end

---将 int rgba 打包为 uint32
---@param r number
---@param g number
---@param b number
---@param a number
---@return number rgba
function pack_rgba( r, g, b, a )
	return 0x1000000 * r + 0x10000 * g + 0x100 * b + a
end

---获取当前根实体
---@return number root_entity
function get_root_entity( )
	return EntityGetRootEntity( GetUpdatedEntityID( ) )
end

---获取实体;
---可选是否获取为 table
---@param is_group boolean|nil? -- 默认为 false
---@return number|number[]
function get_entity( is_group )
	local update = GetUpdatedEntityID( )

	if ( is_group ) then
		local root = EntityGetRootEntity( update )

		return {
			root = root,
			update = update,
		}
	else
		return update
	end
end

---获取 comp 组件所在的实体
---@param comp any
---@return number
function comp_get_entity( comp )
	return ComponentGetEntity( comp )
end

---获取所有玩家, 包括变形中的
---@return number[] players
function get_all_players( )
	local players = EntityGetWithTag( 'player_unit' ) or { }

	add_table( players, EntityGetWithTag( 'polymorphed_player' ) or { } )

	return players
end

---获取最近的玩家
---@param tar_id number
---@param tar_x number
---@param tar_y number
---@return number|nil closest
function get_closest_player( tar_id, tar_x, tar_y )
	local x, y = nil, nil

	if ( tar_id ) then
		x, y = EntityGetTransform( tar_id )
	elseif ( tar_x ) and ( tar_y ) then
		x, y = tar_x, tar_y
	end

	local closest = nil

	if ( x ) and ( y ) then
		local players = get_all_players( )

		if ( #players > 1 ) then
			local min_distance = math.huge

			for _, player in ipairs( players ) do
				local px, py = EntityGetTransform( player )

				if ( px and py ) then
					local distance_pow_2 = ( x - px ) ^ 2 + ( y - py ) ^ 2

					if ( distance_pow_2 < min_distance ) then
						min_distance = distance_pow_2
						closest = player
					end
				end
			end
		elseif ( #players == 1 ) then
			closest = players[ 1 ]
		end
	end

	return closest
end

---移除投射物速度组件的速度上限
---@param projectile number|number[]|nil
function remove_speed_limit( projectile )
	if ( type( projectile ) == 'number' ) then
		projectile = { projectile }
	end

	for _, proj in ipairs( projectile or { } ) do
		local v_comps = EntityGetComponent( proj, 'VelocityComponent' ) or { }

		for _, v_comp in ipairs( v_comps or { } ) do
			if ( v_comp ~= 0 ) then
				ComponentSetValue2( v_comp, 'terminal_velocity', math.huge )
				ComponentSetValue2( v_comp, 'apply_terminal_velocity', false )
				ComponentSetValue2( v_comp, 'limit_to_max_velocity', false )
			end
		end
	end
end

---检测法术是否是被复制的
---@param rec number|nil
---@param iter number|nil
---@param series string|nil
---@param specific string|nil
---@return boolean is_spell_copy
function is_spell_copy( rec, iter, series, specific )
	return rec ~= nil or iter ~= nil or series ~= nil or specific ~= nil
end

---获取每个 entity 实体中类型为 comp_type 的组件
---@param entity number|number[]
---@param comp_type string|nil?
---@param tag string|nil?
---@param name string|nil?
---@return number[] comps
function get_all_comp( entity, comp_type, tag, name )
	local comps = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	if ( is_not_nil_str( comp_type ) ) then
		if ( is_not_nil_str( tag ) ) then
			for i, _ in ipairs( entity ) do
				add_table( comps, EntityGetComponentIncludingDisabled( _, comp_type, tag ) or { } )
			end
		else
			for i, _ in ipairs( entity ) do
				add_table( comps, EntityGetComponentIncludingDisabled( _, comp_type ) or { } )
			end
		end
	else
		for i, _ in ipairs( entity ) do
			add_table( comps, EntityGetAllComponents( _ ) )
		end
	end

	if ( is_not_nil_str( name ) ) then
		for _ = #comps, 1, -1 do
			if ( ComponentGetValue2( comps[ _ ], 'name' ) ~= name ) then
				table.remove( comps, _ )
			end
		end
	end

	return comps
end

---返回 entity 实体中是否有类型为 comp_type 的组件
---@param entity number
---@param comp_type string
---@param tag string|nil?
---@param name string|nil?
---@return boolean is_has_comp
function is_has_comp( entity, comp_type, tag, name )
	local comps = get_all_comp( entity, comp_type, tag, name )

	return #comps > 0
end

---返回 entity 实体中首个类型为 comp_type 的组件内属性为 field_table 每个 "键" 的值; 
---没有的场合用 field_table 对应"键"的值代替
---@param entity number
---@param comp_type string
---@param tag string|nil
---@param field_table table<string, any>[]|nil
---@param name string|nil?
---@return any ...
function get_comp_info( entity, comp_type, tag, field_table, name )
	local values, comp = { }, nil

	if ( type( tag ) == 'string' ) then
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type, tag )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type, tag )
		end
	else
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type )
		end
	end

	if ( comp ) then
		for _, t in ipairs( field_table or { } ) do
			local v = ComponentGetValue2( comp, t[ 1 ] )

			if ( v == nil ) then
				v = t[ 2 ]
			end

			table.insert( values, v )
		end
	else
		for _, t in ipairs( field_table or { } ) do
			table.insert( values, t[ 2 ] )
		end
	end

	return unpack( values )
end

---返回 entity 实体中首个类型为 comp_type 的组件内子对象的属性为 field_table 每个 "键" 的值；
---没有的场合用 field_table 对应"键"的默认值代替
---@param entity number
---@param comp_type string
---@param tag string|nil
---@param field_table table<string, string, any>[]|nil
---@param name string|nil?
---@return any ...
function get_comp_obj_info( entity, comp_type, tag, field_table, name )
	local values, comp = { }, nil

	if ( type( tag ) == 'string' ) then
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type, tag )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type, tag )
		end
	else
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type )
		end
	end

	if ( comp ) then
		for _, t in ipairs( field_table or { } ) do
			local v = ComponentObjectGetValue2( comp, t[ 1 ], t[ 2 ] )

			if ( v == nil ) then
				v = t[ 3 ]
			end

			table.insert( values, v )
		end
	else
		for _, t in ipairs( field_table or { } ) do
			table.insert( values, t[ 3 ] )
		end
	end

	return unpack( values )
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件
---@param entity number|number[]
---@param comp_type string
---@param comp_table table
---@return number comps_count
---@return table affect_comps
function add_comp( entity, comp_type, comp_table )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = { }

	for _, e in ipairs( entity ) do
		local comp = EntityAddComponent2( e, comp_type, comp_table )

		table.insert( comps, comp )
	end

	return #comps, comps
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件; 
---当元素为字符串时，增量为 comp_table[ 元素 ] ; 
---当元素为 { key, inc } 表时，增量为 inc ; 
---会删除多余的组件, 返回影响组件的总数、操作方法以及受影响后仍存在的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param comp_table table
---@param prolong_table (string|{[1]:string,[2]:number})[]|nil?
---@param name string|nil
---@return number comps_count
---@return string method
---@return table affect_comps
function add_comp_prolong( entity, comp_type, tag, comp_table, prolong_table, name )
	local count, method = 0, ''

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	if ( #comps == 0 ) then
		method, comps = 'add', { }

		for _, e in ipairs( entity ) do
			local comp = EntityAddComponent2( e, comp_type, comp_table )

			table.insert( comps, comp )
		end

		count = #comps
	else
		method, count = 'prolong', #comps
		local op_comps, oped_entity = { }, { }

		add_table( op_comps, comps, false, true )

		for _, comp in ipairs( op_comps ) do
			local op_entity = comp_get_entity( comp )

			if ( is_in( op_entity, oped_entity ) ) then
				EntityRemoveComponent( op_entity, comp )
			else
				table.insert( oped_entity, op_entity )

				for i, k in ipairs( prolong_table or { } ) do
					if ( type( k ) == 'table' and type( k[ 1 ] ) == 'string' and type( k[ 2 ] ) == 'number' ) then
						local value = ComponentGetValue2( comp, k[ 1 ] )
						ComponentSetValue2( comp, k[ 1 ], value + k[ 2 ] )
					elseif ( type( k ) == 'string' and type( comp_table[ k ] ) == 'number' ) then
						local value = ComponentGetValue2( comp, k )
						ComponentSetValue2( comp, k, value + comp_table[ k ] )
					end
				end

				table.insert( comps, comp )
			end
		end
	end

	return count, method, comps
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件; 
---会删除多余的组件, 返回影响组件的总数、操作方法以及受影响后仍存在的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param comp_table table
---@param name string|nil?
---@return number comps_count
---@return string method
---@return table affect_comps
function add_comp_remove_dupli( entity, comp_type, tag, comp_table, name )
	local count, method = 0, ''

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	if ( #comps == 0 ) then
		method, comps = 'add', { }

		for _, e in ipairs( entity ) do
			local comp = EntityAddComponent2( e, comp_type, comp_table )

			table.insert( comps, comp )
		end

		count = #comps
	else
		method, count = 'change', #comps
		local op_comps, oped_entity = { }, { }

		add_table( op_comps, comps, false, true )

		for _, comp in ipairs( op_comps ) do
			local op_entity = comp_get_entity( comp )

			if ( is_in( op_entity, oped_entity ) ) then
				EntityRemoveComponent( op_entity, comp )
			else
				table.insert( oped_entity, op_entity )

				for k, v in pairs( comp_table ) do
					ComponentSetValue2( comp, k, v )
				end

				table.insert( comps, comp )
			end
		end
	end

	return count, method, comps
end

---将每个 entity 实体所有类型为 comp_type 的组件的值按照 v_table 设置; 
---在传入 func 时对每个类型为 comp_type 的组件执行一次 func ; 
---返回影响组件的总数以及受影响的组件表
---@param entity number|number[]
---@param comp_type string|nil
---@param tag string|nil
---@param v_table table|nil
---@param pre_func function|nil?
---@param aft_func function|nil?
---@return number comps_count
---@return table affect_comps
function set_comp_value( entity, comp_type, tag, v_table, pre_func, aft_func )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = get_all_comp( entity, comp_type, tag )

	if ( is_not_nil_table( v_table ) ) then
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end
				end
			end
		end
	else
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					aft_func( comp )
				end
			else
				comps = { }
			end
		end
	end

	return #comps, comps
end

---将每个 entity 实体所有类型为 comp_type 的组件内子对象属性按照 v_table 设置; 
---在传入 func 时对每个类型为 comp_type 的组件执行一次 func ; 
---返回影响组件的总数以及受影响的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param v_table table<string, string, any>[]|nil
---@param pre_func function|nil?
---@param aft_func function|nil?
---@return number comps_count
---@return table affect_comps
function set_comp_obj_value( entity, comp_type, tag, v_table, pre_func, aft_func )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = get_all_comp( entity, comp_type, tag )

	if ( is_not_nil_table( v_table ) ) then
		if ( pre_func ) then
			if ( aft_func ) then
				for i, comp in ipairs( comps ) do
					pre_func( comp )

					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end

					aft_func( comp )
				end
			else
				for i, comp in ipairs( comps ) do
					pre_func( comp )

					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end
				end
			end
		else
			if ( aft_func ) then
				for i, comp in ipairs( comps ) do
					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end

					aft_func( comp )
				end
			else
				for i, comp in ipairs( comps ) do
					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end
				end
			end
		end
	else
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					aft_func( comp )
				end
			else
				comps = { }
			end
		end
	end

	return #comps, comps
end

---移除每个 entity 实体所有类型为 comp_type 的组件; 
---返回影响组件的总数
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil?
---@param name string|nil?
---@return number comps_count
function remove_all_comp( entity, comp_type, tag, name )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	for _, comp in ipairs( comps ) do
		EntityRemoveComponent( EntityGetRootEntity( ComponentGetEntity( comp ) ), comp )
	end

	return #comps
end

---返回每个 entity 实体上的所有子实体
---@param entity number|number[]
---@param tag string|nil?
---@param name string|nil?
---@return number[] childs
function get_all_child( entity, tag, name )
	local childs = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	if ( is_not_nil_str( tag ) ) then
		for _, e in ipairs( entity ) do
			add_table( childs, EntityGetAllChildren( e, tag ) or { } )
		end
	else
		for _, e in ipairs( entity ) do
			add_table( childs, EntityGetAllChildren( e ) or { } )
		end
	end

	if ( is_not_nil_str( name ) ) then
		for _ = #childs, 1, -1 do
			if ( EntityGetName( childs[ _ ] ) ~= name ) then
				table.remove( childs, _ )
			end
		end
	end

	return childs
end

---移除每个 entity 实体上的所有子实体; 
---返回影响子实体的总数
---@param entity number|number[]
---@param tag string|nil?
---@return number child_count
function remove_all_child( entity, tag, name )
	local childs = get_all_child( entity, tag, name )

	for _, child in ipairs( childs or { } ) do
		EntityRemoveFromParent( child )

		EntityKill( child )
	end

	return #childs
end

---为投射物进行伤害变换
---@param entity number
---@param dmg_type string
---@param multi number|nil? --伤害损耗倍率, 默认 50%
---@param base_dmg number|nil? --基础伤害, 默认 1
function damage_to( entity, dmg_type, multi, base_dmg )
	if ( is_has_comp( entity, 'ProjectileComponent', nil ) ) then
		local sum = 0

		set_comp_value( entity, 'ProjectileComponent', nil, {
			damage = 0,
		}, function ( comp )
			sum = sum + math.abs( ComponentGetValue2( comp, 'damage' ) or 0 )
		end, nil )

		set_comp_obj_value( entity, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'damage', 0 },
		}, function ( comp )
			sum = sum + math.abs( ComponentObjectGetValue2( comp, 'config_explosion', 'damage' ) or 0 )
		end, nil )

		set_comp_obj_value( entity, 'ProjectileComponent', nil, all_proj_dmg_0_dmg_by_type,
		function ( comp )
			for i, _ in ipairs( all_proj_dmg ) do
				sum = sum + math.abs( ComponentObjectGetValue2( comp, 'damage_by_type', _ ) or 0 )
			end
		end, nil )

		sum = ( base_dmg or 1 ) / get_scale( ) + sum * ( multi or 0.5 )

		if ( dmg_type == 'projectile' ) then
			set_comp_value( entity, 'ProjectileComponent', nil, {
				damage = sum,
			}, nil, nil )
		elseif ( dmg_type == 'healing' ) then
			set_comp_obj_value( entity, 'ProjectileComponent', nil, {
				{ 'damage_by_type', dmg_type, -sum },
			}, nil, nil )
		else
			set_comp_obj_value( entity, 'ProjectileComponent', nil, {
				{ 'damage_by_type', dmg_type, sum },
			}, nil, nil )
		end
	end
end


function remove_cards_until_fix( wand, deck_cap, always )
	local cards = get_all_child( wand )

	for _ = #cards, 1, -1 do
		if ( not is_has_comp( cards[ _ ], 'ItemActionComponent' ) ) then
			table.remove( cards, _ )
		end
	end

	if ( #cards > deck_cap ) then
		local x, y = EntityGetTransform( wand )
		local act_cards = { }

		for _ = #cards, always + 1, -1 do
			if ( #cards - _ + 1 > deck_cap ) then
				local card = cards[ _ ]

				EntityRemoveFromParent( card )

				EntitySetTransform( card, x, y )

				table.insert( act_cards, card )
			end
		end

		local comps = get_all_comp( act_cards )

		set_comp_value( act_cards, nil, nil, {
			_enabled = true,
		}, nil, nil )
	end
end

---发射投射物
---@param from number|nil
---@param xml string
---@param x number|nil?
---@param y number|nil?
---@param vel_x number|nil?
---@param vel_y number|nil?
---@param tag string|nil?
---@param func_pre function|nil?
---@param func_aft function|nil?
---@return number shoot_entity
function shoot_proj( from, xml, x, y, vel_x, vel_y, tag, func_pre, func_aft )
	from, x, y, vel_x, vel_y = from or 0, x or 0, y or 0, vel_x or 0, vel_y or 0

	local e, shooter, herd = EntityLoad( xml, x, y ), nil, nil

	if ( from ~= NULL_ENTITY ) then
		if ( is_has_comp( from, 'ProjectileComponent', nil ) ) then
			shooter, herd = get_comp_info( from, 'ProjectileComponent', nil, {
				{ 'mWhoShot', 0 },
				{ 'mShooterHerdId', 0 },
			}, nil )

			set_comp_value( from, 'ProjectileComponent', nil, {
				mEntityThatShot = e,
			}, nil, nil )

			if ( is_has_comp( e, 'ProjectileComponent', nil ) ) then
				set_comp_value( e, 'ProjectileComponent', nil, {
					mWhoShot = shooter,
					mShooterHerdId = herd,
				}, nil, nil )

				if ( EntityHasTag( from, 'friendly_fire_enabled' ) ) then
					EntityAddTag( e, 'friendly_fire_enabled' )

					set_comp_value( e, 'ProjectileComponent', nil, {
						friendly_fire = true,
						collide_with_shooter_frames = 6,
					}, nil, nil )
				end
			end
		end

		if ( shooter == nil or shooter == 0 ) then
			shooter = from
		end
	end

	if ( is_not_nil_str( tag ) ) then
		EntityAddTag( e, tag or '' )
	end

	if ( func_pre ~= nil ) then
		func_pre( from, e, x, y, vel_x, vel_y, tag )
	end

	GameShootProjectile( shooter or 0, x, y, x + vel_x, y + vel_y, e, true, from or 0 )

	set_comp_value( e, 'VelocityComponent', nil, {
		mVelocity = { vel_x, vel_y },
	}, nil, nil )

	if ( func_aft ~= nil ) then
		func_aft( from, e, x, y, vel_x, vel_y, tag )
	end

	return e
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

---解析键值对字符串（智能处理值中的逗号、括号和引号）
---@param str string 解析字符串
---@param remove_quotes boolean|nil 是否去除引号包裹
---@return table result_table
function parse_kv_pairs( str, remove_quotes )
	local result, cur_k, cur_v = { }, '', ''
	local in_value, paren_depth, in_quote = false, 0, false

	for i = 1, #str do
		local char = string.sub( str, i, i )

		if ( not in_value ) then
			if ( char == '=' ) then
				in_value = true
				cur_v = ''
			elseif ( char == ',' ) then
				cur_k = ''
			else
				cur_k = cur_k .. char
			end
		else
			if ( char == '\'' and not in_quote ) then
				in_quote = true
				cur_v = cur_v .. char
			elseif ( char == '\'' and in_quote ) then
				in_quote = false
				cur_v = cur_v .. char
			elseif ( in_quote ) then
				cur_v = cur_v .. char
			elseif ( char == '(' ) then
				paren_depth = paren_depth + 1
				cur_v = cur_v .. char
			elseif ( char == ')' ) then
				paren_depth = paren_depth - 1
				cur_v = cur_v .. char
			elseif ( char == ',' and paren_depth == 0 ) then
				if ( #cur_k > 0 ) then
					local final_value = cur_v

					if ( remove_quotes and string.sub( cur_v, 1, 1 ) == '\'' and string.sub( cur_v, -1 ) == '\'' ) then
						final_value = string.sub( cur_v, 2, -2 )
					end

					result[ cur_k ] = final_value
				end

				cur_k, cur_v, in_value = '', '', false
			else
				cur_v = cur_v .. char
			end
		end
	end

	if ( in_value and #cur_k > 0 ) then
		local final_value = cur_v

		if ( remove_quotes and string.sub( cur_v, 1, 1 ) == '\'' and string.sub( cur_v, -1 ) == '\'' ) then
			final_value = string.sub( cur_v, 2, -2 )
		end

		result[ cur_k ] = final_value
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
		local value_string = tostring( value )
		if ( string.find( value_string, ',' ) or string.find( value_string, '=' ) ) then
			value_string = '\'' .. value_string .. '\''
		end
		table.insert( result_parts, key .. '=' .. value_string )
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
function merge_str_table_by_id( str, id, values, pattern )
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
					local value_string = tostring( value )
					if ( string.find( value_string, ',' ) or string.find( value_string, '=' ) ) then
						value_string = '\'' .. value_string .. '\''
					end
					table.insert( new_kv_parts, key .. '=' .. value_string )
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
function replace_str_table_by_id( str, id, values, pattern )
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

---在不完全替换的情况下更新块内容, 为键传入 nil 改为删除键
---@param str string
---@param id string
---@param updates table
---@param pattern string
---@return string str_updated
function update_str_table_by_id( str, id, updates, pattern )
	if ( type( str ) ~= 'string' or type( id ) ~= 'string' or type( updates ) ~= 'table' or type( pattern ) ~= 'string' ) then
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
						local first_char = string.sub(content, value_start, value_start )
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

					original_table[key] = value
					kv_start = kv_start + 1
				end

				for key, new_value in pairs( updates ) do
					if ( new_value == nil ) then
						original_table[ key ] = nil
					else
						original_table[ key ] = tostring( new_value )
					end
				end

				local kv_pair = { }
				for k, v in pairs( original_table ) do
					local v_str = tostring( v )
					if ( string.find( v_str, ',' ) or string.find( v_str, '=' ) ) then
						v_str = '\'' .. v_str .. '\''
					end
					table.insert( kv_pair, k .. '=' .. v_str )
				end
				local new_content = table.concat( kv_pair, ',' )
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
---@param options table
---@param args table|nil
---@param extra_entities string|nil
---@param pattern string
function add_desc_by_info( c, options, args, extra_entities, pattern )
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

		if ( values and options.replace ) then
			local str = nil

			if ( options.update ) then
				str = update_str_table_by_id( desc, args.id, args, pattern )
			elseif ( options.merge ) then
				str = merge_str_table_by_id( desc, args.id, args, pattern )
			else
				str = replace_str_table_by_id( desc, args.id, args, pattern )
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
---@param action_id string
---@param entity_id number
---@param param_names string[]
---@param pattern string|nil?
---@return table|nil result_table
function parse_and_evaluate_command_paras( action_id, entity_id, param_names, pattern )
	local p_comp = EntityGetFirstComponent( entity_id, 'ProjectileComponent' )

	if ( not p_comp ) then
		return nil
	end

	local desc = ComponentObjectGetValue2( p_comp, 'config', 'action_description' )
	local values = search_table_from_format( desc, action_id, pattern or '$' )

	if ( not values ) then
		return nil
	end

	local shooter = tonumber( values.shooter ) or 0
	local x, y = EntityGetTransform( entity_id )

	local result_table = {
		shooter = shooter,
	}

	for _, param_name in ipairs( param_names ) do
		local raw_value = values[ param_name ]

		if ( raw_value ~= nil ) then
			if ( string.find( raw_value, '@', 1, true ) or string.find( raw_value, '~', 1, true ) or string.find( raw_value, '(', 1, true ) ) then
				local result, is_correct = evaluate_delayed_expression( raw_value, '#', shooter, x, y )

				if ( is_correct and result ~= nil ) then
					result_table[ param_name ] = result
				end
			else
				local num = tonumber( raw_value )

				if ( num ~= nil ) then
					result_table[ param_name ] = num
				end
			end
		end
	end

	return result_table
end

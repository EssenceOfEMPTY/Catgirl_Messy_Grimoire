dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local all_curses_id = {
	'EMPTY_CURSE_MONK',
	'EMPTY_CURSE_ALWAYS_SHUFFLE',
	'EMPTY_CURSE_SHORT_WAND',
	'EMPTY_CURSE_MALICE_WASHES_OVER',
	'EMPTY_CURSE_REALITY_SHIFT',
	'EMPTY_CURSE_GUARANTEED_LOSE',
}

---生成所有诅咒, 返回总诅咒数量
---@param x number
---@param y number
---@return number curse_count
function empty_spawn_all_curses( x, y )
	local gap, total_curses = 32, #all_curses_id
	local count_sqrt = math.ceil( math.sqrt( total_curses ) )
	local cols, rows = count_sqrt, count_sqrt
	if ( total_curses < count_sqrt * count_sqrt ) then
		rows = count_sqrt - 1
	end

	local start_x = x - ( cols - 1 ) * gap / 2
	local start_y = y - ( rows - 1 ) * gap / 2

	local curse_index = 1
	for row = 0, rows - 1, 1 do
		local curses_in_this_row = cols
		if ( row == rows - 1 ) then
			curses_in_this_row = total_curses - ( rows - 1 ) * cols
		end

		local row_start_x = start_x
		if ( row == rows - 1 and curses_in_this_row < cols ) then
			row_start_x = start_x + (cols - curses_in_this_row) * gap / 2
		end

		for col = 0, curses_in_this_row - 1, 1 do
			if ( curse_index <= total_curses ) then
				perk_spawn( row_start_x + col * gap, start_y + row * gap, all_curses_id[ curse_index ], true )

				curse_index = curse_index + 1
			else
				return total_curses
			end
		end
	end

	return total_curses
end

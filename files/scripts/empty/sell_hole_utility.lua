dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/game_helpers.lua' )

function str( var )
	if type( var ) == 'table' then
		local s = '{ '
		for k, v in pairs( var ) do
			if type( k ) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. str( v ) .. ', '
		end
		return s .. '} '
	end
	return tostring( var )
end

function dump( o )
	 if type( o ) == 'table' then
		local s = '{ '
		for k, v in pairs( o ) do
			 if type( k ) ~= 'number' then k = '"'..k..'"' end
			 s = s .. '['..k..'] = ' .. dump( v ) .. ', '
		end
		return s .. '} '
	 else
		return tostring( o )
	 end
end

function get_entity_velocity( e )
	local comp = EntityGetFirstComponent( e, 'VelocityComponent' )
	if not comp then return nil end
	local x, y = ComponentGetValue2( comp, 'mVelocity' )
	return x, y
end

function set_entity_velocity( e, x, y )
	local comp = EntityGetFirstComponent( e, 'VelocityComponent' )
	if not comp then return nil end
	ComponentSetValue2( comp, 'mVelocity', x, y )
end

function mod_entity_velocity( e, x, y )
	local comp = EntityGetFirstComponent( e, 'VelocityComponent' )
	if not comp then return nil end
	local curr_x, curr_y = ComponentGetValue2( comp, 'mVelocity' )
	ComponentSetValue2( comp, 'mVelocity', x + curr_x, y + curr_y )
end

function get_char_velocity( e )
	local comp = EntityGetFirstComponent( e, 'CharacterDataComponent' )
	if not comp then return nil end
	local x, y = ComponentGetValue2( comp, 'mVelocity' )
	return x, y
end

function set_char_velocity( e, x, y )
	local comp = EntityGetFirstComponent( e, 'CharacterDataComponent' )
	if not comp then return nil end
	ComponentSetValue2( comp, 'mVelocity', x, y )
end

function mod_char_velocity( e, x, y )
	local comp = EntityGetFirstComponent( e, 'CharacterDataComponent' )
	if not comp then return nil end
	local curr_x, curr_y = ComponentGetValue2( comp, 'mVelocity' )
	ComponentSetValue2( comp, 'mVelocity', x + curr_x, y + curr_y )
end

function get_player( )
	local players = get_players( )
	if ( players ) then
		return players[1]
	end

	return nil
end

function drop_sell_gold( x, y, money, velo_x, velo_y )
	local entity_list = {}
	local gold_entity = 'data/entities/items/pickup/goldnugget_'
	local remove_timer = true
	local drop_first_10 = true

	local comp_worldstate = EntityGetFirstComponent( GameGetWorldStateEntity( ), 'WorldStateComponent' )

	 -- - spawn first 10 gold as small nuggets
	if ( drop_first_10 ) then
		local nugget_10_count = 0
		while money >= 10 and nugget_10_count < 5 do
			local eid = load_gold_entity( gold_entity .. '10.xml', x, y - 8, remove_timer )
			money = money - 10
			nugget_10_count = nugget_10_count + 1

			table.insert( entity_list, {eid, 6} )
		end
	end

	while money >= 200000 do
		local eid = load_gold_entity( gold_entity .. '200000.xml', x, y - 8, remove_timer )
		money = money - 200000

		table.insert( entity_list, {eid, 12} )
	end

	while money >= 10000 do
		local eid = load_gold_entity( gold_entity .. '10000.xml', x, y - 8, remove_timer )
		money = money - 10000

		table.insert( entity_list, {eid, 12} )
	end

	while money >= 1000 do
		local eid = load_gold_entity( gold_entity .. '1000.xml', x, y - 8, remove_timer )
		money = money - 1000

		table.insert( entity_list, {eid, 20} )
	end

	while money >= 200 do
		local eid = load_gold_entity( gold_entity .. '200.xml', x, y - 8, remove_timer )
		money = money - 200

		table.insert( entity_list, {eid, 12} )
	end

	while money >= 50 do
		local eid = load_gold_entity( gold_entity .. '50.xml', x, y - 8, remove_timer )
		money = money - 50

		table.insert( entity_list, {eid, 9} )
	end

	while money >= 10 do
		local eid = load_gold_entity( gold_entity .. '10.xml', x, y - 8, remove_timer )
		money = money - 10

		table.insert( entity_list, {eid, 6} )
	end

	for _, nugget in ipairs( entity_list ) do
		set_entity_velocity( nugget, velo_x, velo_y )
	end
end

function table_concat( t1, t2 )
	for i=1, #t2 do
		t1[#t1 + 1] = t2[i]	 -- corrected bug. if t1[#t1 + i] is used, indices will be skipped
	end
	return t1
end

function num_sign( number )
	return ( number > 0 and 1 ) or ( number == 0 and 0 ) or - 1
end

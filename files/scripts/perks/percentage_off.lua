dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local targets = EntityGetWithTag( 'wand' )
local targets2 = EntityGetWithTag( 'card_action' )

add_table( targets, targets2, false, true )

if ( #targets > 0 ) then
	for i, target in ipairs( targets ) do
		local x, y = EntityGetTransform( target )
		if ( EntityHasTag( target, 'discounted' ) == false ) then
			EntityAddTag( target, 'discounted' )
			SetRandomSeed( x, y )
			local itemcost = EntityGetFirstComponent( target, 'ItemCostComponent' )
			local cost_text = EntityGetFirstComponent( target, 'SpriteComponent', 'shop_cost' )
			if ( itemcost and cost_text ) then
				local cost = ComponentGetValue2( itemcost, 'cost' )
				local p = Random( 0 , 99 )
				local indicators = EntityGetInRadius( x, y, 12 )
				for i, e in ipairs( indicators ) do
					local sprite_comp = EntityGetFirstComponent( e, 'SpriteComponent' )
					if ( sprite_comp ) then
						local sprite = ComponentGetValue2( sprite_comp, 'image_file' )
						if tostring( sprite ) == 'data/ui_gfx/sale_indicator.png' then
							EntityKill( e )
							p = 100
						end
					end
				end

				if ( ( tonumber( GlobalsGetValue( 'EMPTY_DISCOUNT_EXTRA_OFF', '0' ) ) or 0 ) > 0 ) then
					p = p + 50;
				end

				if ( p < 25 ) then
					EntityLoad( empty_path .. 'ui_gfx/sale_indicator_25.xml', x, y )
				elseif ( p < 50 ) then
					EntityLoad( empty_path .. 'ui_gfx/sale_indicator_50.xml', x, y )
				elseif ( p < 75 ) then
					EntityLoad( empty_path .. 'ui_gfx/sale_indicator_75.xml', x, y )
				else
					EntityLoad( empty_path .. 'ui_gfx/free_indicator.xml', x, y )
				end

				cost = math.ceil( cost * ( 1.0 - p / 100.0 ) )

				local offsetx = 6
				local text = tostring( cost )
				local textwidth = 0
				for _=1, #text do
					local l = string.sub( text, _, _ )
					if ( l ~= '1' ) then
						textwidth = textwidth + 6
					else
						textwidth = textwidth + 3
					end
				end
				offsetx = textwidth * 0.5 - 0.5
				ComponentSetValue2( cost_text, 'offset_x', offsetx )
				ComponentSetValue2( itemcost, 'cost', cost )
			end
		end
	end
end

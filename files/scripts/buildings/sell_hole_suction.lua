dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/sell_hole_utility.lua' )
dofile_once( 'data/scripts/gun/gun_actions.lua' )

local entity = GetUpdatedEntityID( )
local player = get_player( ) or 0

local self_x, self_y = EntityGetTransform( entity )
local dist = 2048.0
local player_x, player_y = EntityGetTransform( player )
if ( player_x and player_y ) then
	dist = math.sqrt( ( self_x - player_x ) ^ 2 + ( self_y - player_y ) ^ 2 )
end

if ( dist < 1024 ) then
	local items = EntityGetInRadiusWithTag( self_x, self_y, 128, 'wand' )
	local spells = EntityGetInRadiusWithTag( self_x, self_y, 128, 'card_action' )
	add_table( items, spells, false, true )
	for _, item in ipairs( items ) do
		local cost_component = EntityGetFirstComponent( item, 'ItemCostComponent' )
		if not ( cost_component ) then
			local a, b = get_entity_velocity( item )
			if a then
				self_x, self_y = EntityGetTransform( entity )
				local x, y = EntityGetTransform( item )
				local distance = math.sqrt( ( self_x - x ) ^ 2 + ( self_y - y ) ^ 2 )
				local angle = math.atan( self_y - y, self_x - x )
				mod_entity_velocity( item, math.cos( angle ) * ( 50 - distance ) / 2, math.sin( angle ) * ( 50 - distance ) / 2)
				if math.sqrt( ( self_x - x ) ^ 2 + ( self_y - y ) ^ 2 ) < 8 + math.sqrt( a ^ 2 + b ^ 2 ) / 50 then
					local coin = 0
					local sell_num = math.floor( math.abs( self_y / 2000 ) )
					local sell_factor = math.max( sell_num, 1 ) ^ 2
					if EntityHasTag( item, 'wand' ) then
						local wand_level = math.max( sell_num ^ 2 - 1, 0 )
						coin = 50 + wand_level * 120
						local children = EntityGetAllChildren( item )
						for _, child in ipairs( children or { } ) do
							local comps = EntityGetAllComponents( child )
							for _, comp in ipairs( comps ) do
								if ( ComponentGetTypeName( comp ) == 'ItemActionComponent' ) then
									action_id = ComponentGetValue2( comp, 'action_id' )
									for _, action in ipairs( actions ) do
										if action.id == action_id then
											local price = math.max( math.floor( ( ( action.price * 0.50 ) + ( 70 * sell_factor ) ) / 10 ) * 10, 10 )
											coin = coin + math.max( price / 5, 10 )
										end
									end
								end
							end
						end
					elseif EntityHasTag( item, 'card_action' ) then
						local comps = EntityGetAllComponents( item )
						for _, comp in ipairs( comps ) do
							if ComponentGetTypeName( comp ) == 'ItemActionComponent' then
								action_id = ComponentGetValue2( comp, 'action_id' )
								for _, action in ipairs( actions ) do
									if action.id == action_id then
										local price = math.max(math.floor( ( ( action.price * 0.50 ) + ( 70 * sell_factor ) ) / 10 ) * 10, 10 )
										coin = coin + math.max( price / 5, 10 )
									end
								end
							end
						end
					end
					drop_sell_gold( self_x, self_y, coin, a, b )
					if ( coin > 500 ) then
						shoot_projectile( entity, 'data/entities/particles/gold_pickup_huge.xml', self_x, self_y, 0, 0 )
					elseif ( coin > 40 ) then
						shoot_projectile( entity, 'data/entities/particles/gold_pickup_large.xml', self_x, self_y, 0, 0 )
					else
						shoot_projectile( entity, 'data/entities/particles/gold_pickup.xml', self_x, self_y, 0, 0 )
					end
					EntityKill( item )
					sprite = EntityGetFirstComponent( entity, 'SpriteComponent' )
					if ( sprite ) then
						ComponentSetValue2( sprite, 'rect_animation', 'flash' )
						ComponentSetValue2( sprite, 'next_rect_animation', 'loop' )
					end
				end
			end
		end
	end
end

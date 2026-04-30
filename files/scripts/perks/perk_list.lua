dofile_once( 'data/scripts/magic/fungal_shift.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local ui_icon_url = empty_path .. 'ui_gfx/perk_icons/'
local perk_icon_url = empty_path .. 'items_gfx/perks/'

local new_perks =
{
	{
		info = 'extract_always_cast',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local x, y = EntityGetTransform( entity_who_picked )

			local children = EntityGetAllChildren( entity_who_picked )
			local inventory = EntityGetFirstComponent( entity_who_picked, 'Inventory2Component' )
			if ( inventory ) then
				for i, child_id in ipairs( children or { } ) do
					if ( EntityGetName( child_id ) == 'inventory_quick' ) then
						local wands = EntityGetAllChildren( child_id )
						for _, wand in ipairs( wands or { } ) do
							local ability_comp = EntityGetFirstComponentIncludingDisabled( wand, 'AbilityComponent' )
							if ( ability_comp ) then
								local deck_capacity_all = ComponentObjectGetValue2( ability_comp, 'gun_config', 'deck_capacity' )
								local deck_capacity_real = EntityGetWandCapacity( wand )

								local always_count = math.max( 0, deck_capacity_all - deck_capacity_real )
								if ( always_count > 0 ) then
									local spells = EntityGetAllChildren( wand )
									for j, spell in ipairs( spells or { } ) do
										if ( spell ) then
											local spell_comp = EntityGetFirstComponentIncludingDisabled( spell, 'ItemActionComponent' )
											if ( spell_comp ) then
												local action_id = ComponentGetValue2( spell_comp, 'action_id' )

												EntityRemoveFromParent( spell )
												EntitySetTransform( spell, x, y )
												local spell_comps = EntityGetAllComponents( spell )
												for k, comp in ipairs( spell_comps or {} ) do
													EntitySetComponentIsEnabled( spell, comp, true )
												end

												CreateItemActionEntity( action_id, x, y )
											end
										end
									end

									ComponentObjectSetValue2( ability_comp, 'gun_config', 'deck_capacity', deck_capacity_real )
								end
							end
						end
					end
				end
			end
		end,
	},
	{
		info = 'reduce_reroll_count',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		max_in_perk_pool = 2,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local reroll_count = tonumber( GlobalsGetValue( 'TEMPLE_PERK_REROLL_COUNT', '0' ) ) or 0

			reroll_count = reroll_count - 3

			GlobalsSetValue( 'TEMPLE_PERK_REROLL_COUNT', tostring( reroll_count ) )
		end,
	},
	{
		info = 'fungal_shift_add_capacity',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		max_in_perk_pool = 1,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local shift_count = tonumber( GlobalsGetValue( 'fungal_shift_iteration', '0' ) ) or 0
			shift_count = shift_count - 5
			GlobalsSetValue( 'fungal_shift_iteration', tostring( shift_count ) )
		end,
	},
	{
		info = 'berserk_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'magic_liquid_berserk' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'magic_liquid_berserk' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_berserk_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_berserk_$[1-3].xml' )
				end
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'teleport_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'magic_liquid_teleportation' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'magic_liquid_teleportation' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_freeze_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_freeze_$[1-3].xml' )
				end
			end
			if ( ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_TELEPORT_PICKUP_COUNT', '0' ) ) or 0 ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_TELEPORT', false, false, true )
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'freeze_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood_cold' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood_cold' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_freeze_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_freeze_$[1-3].xml' )
				end
			end
			if ( ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_FREEZE_PICKUP_COUNT', '0' ) ) or 0 ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_FREEZE', false, false, true )
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'lava_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'lava' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'lava' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_lava_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_lava_$[1-3].xml' )
				end
			end
			if ( ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_LAVA_PICKUP_COUNT', '0' ) ) or 0 ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_LAVA', false, false, true )
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'acid_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'acid' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'acid' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_acid_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_acid_$[1-3].xml' )
				end
			end
			if ( ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_ACID_PICKUP_COUNT', '0' ) ) or 0 ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_ACID', false, false, true )
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'polymorph_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'magic_liquid_polymorph' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'magic_liquid_polymorph' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier * 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_polymorph_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_polymorph_$[1-3].xml' )
				end
			end
			if ( ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_POLYMORPH_PICKUP_COUNT', '0' ) ) or 0 ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_POLYMORPH', false, false, true )
			end
		end,
		_remove = function ( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentSetValue2( damagemodel, 'blood_material', 'blood' )
					ComponentSetValue2( damagemodel, 'blood_spray_material', 'blood' )
					local blood_multiplier = tonumber( ComponentGetValue2( damagemodel, 'blood_multiplier' ) )
					ComponentSetValue2( damagemodel, 'blood_multiplier', blood_multiplier / 3 )
					ComponentSetValue2( damagemodel, 'blood_sprite_directional', empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml' )
					ComponentSetValue2( damagemodel, 'blood_sprite_large', empty_path .. 'particles/bloodsplatters/bloodsplatter_$[1-3].xml' )
				end
			end
		end,
	},
	{
		info = 'protection_glue',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'glue_NOT' )
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'glue_NOT' )
		end,
	},
	{
		info = 'protection_shock',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				local targetDamageMultipliers = { 'physics_objects_damage', 'physics_hit' }
				for multiplierCount = 1, #targetDamageMultipliers do
					for i, damagemodel in ipairs( damagemodels ) do
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', targetDamageMultipliers[ multiplierCount ], 0 )
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				local targetDamageMultipliers = { 'physics_objects_damage', 'physics_hit' }
				for multiplierCount = 1, #targetDamageMultipliers do
					for i, damagemodel in ipairs( damagemodels ) do
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', targetDamageMultipliers[ multiplierCount ], 1 )
					end
				end
			end
		end,
	},
	{
		info = 'protection_freeze',
		game_effect = 'PROTECTION_FREEZE',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local targetMaterials = { 'blood_cold', 'blood_cold_vapour' }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], 0 )
			end
		end,
		func_remove = function( entity_who_picked )
			local targetMaterials = { 'blood_cold', 'blood_cold_vapour' }
			local defaultDamage = { 0.0009, 0.0006 }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], defaultDamage[ materialCount ] )
			end
		end,
	},
	{
		info = 'protection_venomous_curse',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'curse_NOT' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local damageMultipliers = {
				[ 'curse' ] = 0.5,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( damageMultipliers ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'curse_NOT' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local damageMultipliers = {
				[ 'curse' ] = 0.5,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( damageMultipliers ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier / multiplier )
				end
			end
		end,
	},
	{
		info = 'protection_lava',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local targetMaterials = { 'lava' }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], 0 )
			end
		end,
		func_remove = function( entity_who_picked )
			local targetMaterials = { 'lava' }
			local defaultDamage = { 0.003 }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], defaultDamage[ materialCount ] )
			end
		end,
	},
	{
		info = 'protection_acid',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local targetMaterials = { 'acid', 'ice_acid_static', 'ice_acid_glass' }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], 0 )
			end
		end,
		func_remove = function( entity_who_picked )
			local targetMaterials = { 'acid', 'ice_acid_static', 'ice_acid_glass' }
			local defaultDamage = { 0.005, 0.001, 0.001 }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], defaultDamage[ materialCount ] )
			end
		end,
	},
	{
		info = 'protection_teleport',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityRemoveTag( entity_who_picked, 'teleportable' )
			EntityAddTag( entity_who_picked, 'teleportable_NOT' )
			EntityAddTag( entity_who_picked, 'no_swap' )

			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'empty_protection_teleport', {
				_tags = 'empty_protection_teleport',
				script_shot = empty_path .. 'scripts/perks/protection_teleport.lua',
			} )

			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'empty_remove_teleport_effect', {
				_tags = 'empty_remove_teleport_effect',
				script_source_file = empty_path .. 'scripts/perks/remove_teleport_effect.lua',
				execute_every_n_frame = 0,
			} )
		end,
		func_remove = function( entity_who_picked )
			EntityAddTag( entity_who_picked, 'teleportable' )
			EntityRemoveTag( entity_who_picked, 'teleportable_NOT' )
			EntityRemoveTag( entity_who_picked, 'no_swap' )

			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_protection_teleport' )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_remove_teleport_effect' )
		end,
	},
	{
		info = 'protection_slice',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddComponent2( entity_who_picked, 'LuaComponent', {
				_tags = 'empty_slice_immunity',
				script_shot = empty_path .. 'scripts/perks/protection_slice.lua'
			} )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'slice', 0 )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local comps = EntityGetComponent( entity_who_picked, 'LuaComponent', 'empty_slice_immunity' )
			for _, comp in ipairs( comps or { } ) do
				EntityRemoveComponent( entity_who_picked, comp )
			end

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'slice', 1 )
				end
			end
		end,
	},
	{
		info = 'protection_poison',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local targetMaterials = { 'poison', 'rock_static_poison' }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], 0 )
			end
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'poison', 0 )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local targetMaterials = {'poison', 'rock_static_poison'}
			local defaultDamage = { 0.001, 0.001 }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], defaultDamage[ materialCount ] )
			end
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'poison', 1 )
				end
			end
		end,
	}, --[[
	{
		info = 'protection_curse',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local targetMaterials = { 'rock_static_cursed', 'rock_static_cursed_green', 'cursed_liquid' }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], 0 )
			end
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'curse', 0 )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local targetMaterials = { 'rock_static_cursed', 'rock_static_cursed_green', 'cursed_liquid' }
			local defaultDamage = { 0.005, 0.004, 0.0005 }
			for materialCount = 1, #targetMaterials do
				EntitySetDamageFromMaterial( entity_who_picked, targetMaterials[ materialCount ], defaultDamage[ materialCount ] )
			end
			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			if ( damagemodels ) then
				for i, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'curse', 1 )
				end
			end
		end,
	}, ]]--
	{
		info = 'protection_touch_magic',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'touchmagic_immunity' )
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'touchmagic_immunity' )
		end,
	},
	{
		info = 'protection_polymorph',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'polymorphable_NOT' )
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'polymorphable_NOT' )
		end,
	},
	{
		info = 'stone_skin',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'drillable' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local damageMultipliers = {
				[ 'melee' ] = 0.5,
				[ 'projectile' ] = 0.5,
				[ 'explosion' ] = 0.5,
				[ 'electricity' ] = 0.25,
				[ 'fire' ] = 0.25,
				[ 'drill' ] = 3.25,
				[ 'slice' ] = 0.5,
				[ 'ice' ] = 3.25,
				[ 'physics_hit' ] = 0.5,
				[ 'radioactive' ] = 0.5,
				[ 'poison' ] = 0.5,
				[ 'curse' ] = 3.25,
				[ 'holy' ] = 3.25,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( damageMultipliers ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'drillable' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local damageMultipliers = {
				[ 'melee' ] = 0.5,
				[ 'projectile' ] = 0.5,
				[ 'explosion' ] = 0.5,
				[ 'electricity' ] = 0.25,
				[ 'fire' ] = 0.25,
				[ 'drill' ] = 3.25,
				[ 'slice' ] = 0.5,
				[ 'ice' ] = 3.25,
				[ 'physics_hit' ] = 0.5,
				[ 'radioactive' ] = 0.5,
				[ 'poison' ] = 0.5,
				[ 'curse' ] = 3.25,
				[ 'holy' ] = 3.25,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( damageMultipliers ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier / multiplier )
				end
			end
		end,
	},
	{
		info = 'radiance',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local x, y = EntityGetTransform( entity_who_picked )

			EntityAddComponent( entity_who_picked, 'LuaComponent',
			{
				_tags='empty_radiance,perk_component',
				execute_every_n_frame='60',
				script_source_file=empty_path .. 'scripts/perks/radiance.lua',
			} )

			local child_id = EntityLoad( empty_path .. 'entities/misc/perks/radiance.xml', x, y )
			EntityAddTag( child_id, 'perk_empty_radiance' )
			EntityAddChild( entity_who_picked, child_id )
		end,
		func_remove = function( entity_who_picked )
			local comps_need_remove = {
				'empty_radiance',
			}

			for i, tag in ipairs( comps_need_remove ) do
				local comp = EntityGetComponent( entity_who_picked, 'LuaComponent', tag )
				for _, each in ipairs( comp or {} ) do
					EntityRemoveComponent( entity_who_picked, each )
				end
			end

			local perk_empty_radiance = EntityGetAllChildren( entity_who_picked, 'perk_empty_radiance' )
			for _, each in ipairs( perk_empty_radiance or {} ) do
				EntityKill( each )
			end
		end,
	},
	{
		info = 'more_spell_inventory',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local inv_comp = EntityGetComponent( entity_who_picked, 'Inventory2Component' )
			for _, comp in ipairs( inv_comp or { } ) do
				local inv_size = ComponentGetValue2( comp, 'full_inventory_slots_y' )

				if ( inv_size == 1 or inv_size == '1' ) then
					ComponentSetValue2( comp, 'full_inventory_slots_y', 2 )
				else
					ComponentSetValue2( comp, 'full_inventory_slots_y', 0 )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local inv_comp = EntityGetComponent( entity_who_picked, 'Inventory2Component' )
			for _, comp in ipairs( inv_comp or { } ) do
				local inv_size = ComponentGetValue2( comp, 'full_inventory_slots_y' )

				if ( inv_size == 2 or inv_size == '2' ) then
					ComponentSetValue2( comp, 'full_inventory_slots_y', 1 )
				else
					if ( not ( inv_size == 1 or inv_size == '1' ) ) then
						ComponentSetValue2( comp, 'full_inventory_slots_y', 0 )
					else
						--
					end
				end
			end
		end,
	},
	{
		info = 'percentage_off',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddComponent( entity_who_picked, 'LuaComponent', {
				_tags='empty_percentage_off,perk_component',
				execute_every_n_frame='120',
				script_source_file=empty_path .. 'scripts/perks/percentage_off.lua',
			} )
 		end,
		func_remove = function( entity_who_picked )
			local tags_to_remove = {
				'empty_percentage_off',
			}

			for i, tag in ipairs( tags_to_remove ) do
				local comp = EntityGetComponent( entity_who_picked, 'LuaComponent', tag )
				for _, each in ipairs( comp or { } ) do
					EntityRemoveComponent( entity_who_picked, each )
				end
			end
		end,
	},
	{
		info = 'sanctuary_shield',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddComponent2( entity_who_picked, 'LuaComponent', {
				_tags = 'empty_sanctuary_shield_tracker,perk_component',
				execute_every_n_frame = 1,
				script_source_file = empty_path .. 'scripts/perks/sanctuary_shield.lua',
			} )

			EntityAddComponent2( entity_who_picked, 'VariableStorageComponent', {
				_tags = 'empty_sanctuary_shield_data,perk_component',
				value_int = 0,
				value_string = '0',
			} )

			local x, y = EntityGetTransform( entity_who_picked )
			EntityAddComponent2( entity_who_picked, 'VariableStorageComponent', {
				_tags = 'empty_sanctuary_shield_position,perk_component',
				value_float = x or 0,
				value_string = tostring( y or 0 ),
			} )
		end,
		func_remove = function( entity_who_picked )
			local data_comp = EntityGetFirstComponent( entity_who_picked, 'VariableStorageComponent', 'empty_sanctuary_shield_data' )
			if data_comp then
				local shield_entity_id = ComponentGetValue2( data_comp, 'value_string' )
				shield_entity_id = tonumber( shield_entity_id ) or 0
				if shield_entity_id ~= 0 and EntityGetIsAlive( shield_entity_id ) then
					EntityKill( shield_entity_id )
				end
			end

			local comps_to_remove = {
				'empty_sanctuary_shield_tracker',
				'empty_sanctuary_shield_data',
				'empty_sanctuary_shield_position',
			}

			for i, tag in ipairs( comps_to_remove ) do
				local comp = EntityGetComponentIncludingDisabled( entity_who_picked, 'LuaComponent', tag )
				for _, each in ipairs( comp or {} ) do
					EntityRemoveComponent( entity_who_picked, each )
				end

				comp = EntityGetComponentIncludingDisabled( entity_who_picked, 'VariableStorageComponent', tag )
				for _, each in ipairs( comp or {} ) do
					EntityRemoveComponent( entity_who_picked, each )
				end
			end
		end,
	},
	{
		info = 'hearts_also_heal',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			GlobalsSetValue( 'EMPTY_HEARTS_ALSO_HEAL', '1' )
		end,
		func_remove = function( entity_who_picked )
			GlobalsSetValue( 'EMPTY_HEARTS_ALSO_HEAL', '0' )
		end,
	},
	{
		info = 'health_regeneration',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddComponent( entity_who_picked, 'LuaComponent', {
				_tags = 'empty_health_regeneration,perk_component',
				execute_every_n_frame = 1800,
				script_source_file = empty_path .. 'scripts/perks/health_regeneration.lua',
			} )
		end,
		func_remove = function( entity_who_picked )
			local comps_to_remove = {
				'empty_health_regeneration',
			}

			for i, tag in ipairs( comps_to_remove ) do
				local comp = EntityGetComponentIncludingDisabled( entity_who_picked, 'LuaComponent', tag )
				for _, each in ipairs( comp or { } ) do
					EntityRemoveComponent( entity_who_picked, each )
				end
			end
		end,
	},--[[
	{
		info = 'dewborne_breeze',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			--
		end,
		func_remove = function ( entity_who_picked )
			--
		end,
	},
	{
		info = 'flesh_and_flame',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			--
		end,
		func_remove = function ( entity_who_picked )
			--
		end,
	},
	{
		info = 'random_neurotic_wand',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			local x, y = EntityGetTransform( entity_who_picked )

			local wand = generate_neurotic_gun( nil, 10 )
		end,
		func_remove = function ( entity_who_picked )
			--
		end,
	},]]--
--[[
	{
		info = 'curse_illiterate',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name ) --[[
			EntityAddTag( entity_who_picked, 'empty_curse_illiterate' )

			EntityAddComponent2( entity_who_picked, 'LuaComponent',
				{
					_tags = 'empty_curse_illiterate,perk_component',
					execute_every_n_frame = 15,
					script_source_file = empty_path .. 'scripts/perks/curse_illiterate.lua',
				}
			)
			local content_need_obfuscate = backup_common_csv()
			obfuscate_common_csv( content_need_obfuscate )
		end,
		func_remove = function( entity_who_picked ) --[[
			EntityRemoveTag( entity_who_picked, 'empty_curse_illiterate' )

			local tags_to_remove = {
				'empty_curse_illiterate',
			}

			for i, tag in ipairs( tags_to_remove ) do
				local comp = EntityGetComponentIncludingDisabled( entity_who_picked, 'LuaComponent', tag )
				for _, each in ipairs( comp or {} ) do
					EntityRemoveComponent( entity_who_picked, each )
				end
			end
			reset_common_csv()
		end,
	},]]--
	{
		info = 'curse_monk',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damageMultipliers = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.5,
				fire = 0.5,
				drill = 0.5,
				slice = 0.5,
				ice = 0.5,
				physics_hit = 0.5,
				radioactive = 0.75,
				poison = 0.75,
				curse = 1.0,
				holy = 0.25,
				healing = 2.0,
			}

			if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
				damageMultipliers.curse = 0.5 * damageMultipliers.curse
			end

			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '1' )

				local comp = {
					_tags = 'empty_curse_monk,perk_component',
					execute_every_n_frame = 60,
					script_source_file = empty_path .. 'scripts/perks/curse_monk.lua',
				}

				local players = EntityGetWithTag( 'player_unit' ) or { }
				local poly_players = EntityGetWithTag( 'polymorphed_player' ) or { }

				add_table( players, poly_players, false, true )

				for _, player in ipairs( players ) do
					EntityAddComponent2( player, 'LuaComponent', comp )

					local damagemodels = EntityGetComponent( player, 'DamageModelComponent' )

					for _, damagemodel in ipairs( damagemodels or { } ) do
						for damageType, multiplier in pairs( damageMultipliers ) do
							local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
							ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
						end
					end

					perk_pickup( nil, player, 'GOLD_IS_FOREVER', false, false, true )
					for _ = 1, 5 do
						perk_pickup( nil, player, 'ATTRACT_ITEMS', false, false, true )
					end
					perk_pickup( nil, player, 'EMPTY_PERCENTAGE_OFF', false, false, true )
				end
			else
				local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

				for _, damagemodel in ipairs( damagemodels or { } ) do
					for damageType, multiplier in pairs( damageMultipliers ) do
						local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local damageMultipliers = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.5,
				fire = 0.5,
				drill = 0.5,
				slice = 0.5,
				ice = 0.5,
				physics_hit = 0.5,
				radioactive = 0.75,
				poison = 0.75,
				curse = 1.0,
				holy = 0.25,
				healing = 2.0,
			}

			if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
				damageMultipliers.curse = 0.5 * damageMultipliers.curse
			end

			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '0' )

				local tags_to_remove = {
					'empty_curse_monk',
				}

				local players = EntityGetWithTag( 'player_unit' ) or { }
				local poly_players = EntityGetWithTag( 'polymorphed_player' ) or { }

				add_table( players, poly_players, false, true )

				for _, player in ipairs( players ) do
					for i, tag in ipairs( tags_to_remove ) do
						local comp = EntityGetComponentIncludingDisabled( player, 'LuaComponent', tag )
						for _, each in ipairs( comp or { } ) do
							EntityRemoveComponent( player, each )
						end

						comp = EntityGetComponentIncludingDisabled( player, 'VariableStorageComponent', tag )
						for _, each in ipairs( comp or { } ) do
							EntityRemoveComponent( player, each )
						end
					end

					local damagemodels = EntityGetComponent( player, 'DamageModelComponent' )

					for _, damagemodel in ipairs( damagemodels or { } ) do
						for damageType, multiplier in pairs( damageMultipliers ) do
							local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
							ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier / multiplier )
						end
					end
				end
			else
				local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

				for _, damagemodel in ipairs( damagemodels or { } ) do
					for damageType, multiplier in pairs( damageMultipliers ) do
						local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier / multiplier )
					end
				end
			end
		end,
	},
	{
		info = 'curse_always_shuffle',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			GlobalsSetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '1' )

			local wands = EntityGetWithTag( 'wand' )
			for i, wand in ipairs( wands ) do
				local ability_comp = EntityGetFirstComponentIncludingDisabled( wand, 'AbilityComponent' )
				if ( ability_comp ) then
					ComponentObjectSetValue2( ability_comp, 'gun_config', 'shuffle_deck_when_empty', true )

					local operate1 = { 'fire_rate_wait', 'reload_time' }
					local operate2 = { 'gunaction_config', 'gun_config' }
					for _ = 1, #operate1 do
						local temp = ComponentObjectGetValue2( ability_comp, operate2[ _ ], operate1[ _ ] )

						if ( temp > 0 ) then
							temp = temp / 2
						else
							temp = temp * 2
						end

						ComponentObjectSetValue2( ability_comp, operate2[ _ ], operate1[ _ ], temp )
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			GlobalsSetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '0' )
		end,
	},
	{
		info = 'curse_short_wand',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			GlobalsSetValue( 'EMPTY_CURSE_SHORT_WAND', '1' )

			local wands = EntityGetWithTag( 'wand' )
			for i, wand in ipairs( wands ) do
				local ability_comp = EntityGetFirstComponentIncludingDisabled( wand, 'AbilityComponent' )
				if ( ability_comp ) then
					local deck_capacity_all = ComponentObjectGetValue2( ability_comp, 'gun_config', 'deck_capacity' )
					local deck_capacity_real = EntityGetWandCapacity( wand )
					local always_cast_count = math.max( 0, deck_capacity_all - deck_capacity_real )
					if ( deck_capacity_real > 1 ) then
						if ( deck_capacity_real < 15 ) then
							deck_capacity_real = deck_capacity_real / 2
						else
							deck_capacity_real = deck_capacity_real / 4
						end
					end

					deck_capacity_all = deck_capacity_real + always_cast_count
					ComponentObjectSetValue2( ability_comp, 'gun_config', 'deck_capacity', deck_capacity_all )

					local operate = { 'mana_max', 'mana_charge_speed' }
					for _, each in ipairs( operate ) do
						local temp = ComponentGetValue2( ability_comp, each )
						temp = temp * 1.2
						ComponentSetValue2( ability_comp, each, temp )
					end

					local cards = EntityGetAllChildren( wand )
					if ( cards and #cards > deck_capacity_all ) then
						for _ = always_cast_count + 1, #cards do
							local card = cards[ _ ]
							local card_comp = EntityGetFirstComponentIncludingDisabled( card, 'ItemActionComponent' )
							if ( card_comp and _ > deck_capacity_all ) then
								EntityRemoveFromParent( card )
								local x, y = EntityGetTransform( wand )
								EntitySetTransform( card, x, y )

								local card_all_comp = EntityGetAllComponents( card )
								for j, each_comp in ipairs( card_all_comp ) do
									EntitySetComponentIsEnabled( card, each_comp, true )
								end
							end
						end
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			GlobalsSetValue( 'EMPTY_CURSE_SHORT_WAND', '0' )
		end,
	},
	{
		info = 'curse_malice_washes_over',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				local players = EntityGetWithTag( 'player_unit' ) or { }
				local poly_players = EntityGetWithTag( 'polymorphed_player' ) or { }

				add_table( players, poly_players, false, true )

				for _, player in ipairs( players ) do
					EntityAddComponent2( player, 'LuaComponent', {
						script_source_file = empty_path .. 'scripts/perks/curse_malice_washes_over_delay.lua',
						execute_every_n_frame = 300,
						remove_after_executed = true,
					} )
				end
			else
				EntityAddComponent2( entity_who_picked, 'LuaComponent', {
					script_source_file = empty_path .. 'scripts/perks/curse_malice_washes_over_delay.lua',
					execute_every_n_frame = 300,
					remove_after_executed = true,
				} )
			end
		end,
		func_remove = function( entity_who_picked )
			local effect_comps = EntityGetComponent( entity_who_picked, 'GameEffectComponent' )
			if ( effect_comps ) then
				for _, effect_comp in ipairs( effect_comps ) do
					local effect = ComponentGetValue2( effect_comp, 'effect' )
					local custom_effect_id = ComponentGetValue2( effect_comp, 'custom_effect_id' )
					if ( effect == 'CUSTOM' and custom_effect_id == 'CURSE_CLOUD_02' ) then
						EntityRemoveComponent( entity_who_picked, effect_comp )
						break
					end
				end
			end
		end,
	},
	{
		info = 'curse_reality_shift',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local x, y = EntityGetTransform( entity_who_picked )
			local a, b, c = time_for_vec3()

			fungal_shift( entity_who_picked, x + a + c, y + b + c, true )
			fungal_shift( entity_who_picked, x + a + c, y + b - c, true )
			fungal_shift( entity_who_picked, x + a + c, y - b - c, true )
			fungal_shift( entity_who_picked, x + a - c, y - b - c, true )
			fungal_shift( entity_who_picked, x - a - c, y - b - c, true )
			fungal_shift( entity_who_picked, x - a - c, y - b + c, true )
			fungal_shift( entity_who_picked, x - a - c, y + b + c, true )
			fungal_shift( entity_who_picked, x - a + c, y + b + c, true )
			fungal_shift( entity_who_picked, x + a - c, y + b - c, true )
			fungal_shift( entity_who_picked, x - a + c, y - b + c, true )

			for _ = 1, 2 do
				perk_pickup( nil, entity_who_picked, 'EMPTY_FUNGAL_SHIFT_ADD_CAPACITY', false, false, true )
			end
		end,
	},
	{
		info = 'curse_guaranteed_lose',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local damageMultipliers = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				electricity = 4.0,
				fire = 4.0,
				drill = 4.0,
				slice = 4.0,
				ice = 4.0,
				physics_hit = 4.0,
				radioactive = 4.0,
				poison = 4.0,
				curse = 3.0,
				holy = 2.0,
				healing = 4.0,
			}

			if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
				damageMultipliers.curse = 0.5 * damageMultipliers.curse
			end

			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '1' )

				local players = EntityGetWithTag( 'player_unit' ) or { }
				local poly_players = EntityGetWithTag( 'polymorphed_player' ) or { }

				add_table( players, poly_players, false, true )

				for _, player in ipairs( players ) do
					local damagemodels = EntityGetComponent( player, 'DamageModelComponent' )

					for _, damagemodel in ipairs( damagemodels or { } ) do
						for damageType, multiplier in pairs( damageMultipliers ) do
							local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
							ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
						end
					end
				end

				local x, y = EntityGetTransform( entity_who_picked )
				for _ = 1, 4, 1 do
					EntityLoad( empty_path .. 'entities/items/potions/potion_healthium_many_hp.xml', x, y )
				end
			else
				local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

				for _, damagemodel in ipairs( damagemodels or { } ) do
					for damageType, multiplier in pairs( damageMultipliers ) do
						local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' )
			end

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local damageMultipliers = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				electricity = 4.0,
				fire = 4.0,
				drill = 4.0,
				slice = 4.0,
				ice = 4.0,
				physics_hit = 4.0,
				radioactive = 4.0,
				poison = 4.0,
				curse = 3.0,
				holy = 2.0,
				healing = 4.0,
			}

			if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
				damageMultipliers.curse = 0.5 * damageMultipliers.curse
			end

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( damageMultipliers ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier / multiplier )
				end
			end
		end,
	},
	{
		info = 'curse_gravity_free',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 0,
				run_velocity = 0,
				jump_velocity_x = 0,
				fly_speed_max_up = 0,
				fly_speed_max_down = 0,
				fly_velocity_x = 0,
			}, nil )

			if ( EntityHasTag( entity_who_picked, 'player_unit' ) or EntityHasTag( entity_who_picked, 'polymorphed_player' ) ) then
				local x, y = EntityGetTransform( entity_who_picked )

				CreateItemActionEntity( 'HOOK', x, y )

				local e = EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

				set_comp_value( e, 'LifetimeComponent', nil, {
					lifetime = 3600,
				}, nil )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 350,
				run_velocity = 57,
				jump_velocity_x = 56,
				fly_speed_max_up = 95,
				fly_speed_max_down = 85,
				fly_velocity_x = 52,
			}, nil )
		end,
	},
	{
		info = 'curse_death_trail',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'CURSE_DEATH_TRAIL', {
				_tags = 'CURSE_DEATH_TRAIL',
				script_source_file = empty_path .. 'scripts/perks/curse_death_trail.lua',
				execute_every_n_frame = 1,
			} )

			local c_comp = EntityGetFirstComponent( entity_who_picked, 'CharacterPlatformingComponent' )

			if ( c_comp ~= nil ) then
				local values = {
					pixel_gravity = ComponentGetValue2( c_comp, 'pixel_gravity' ),
					run_velocity = ComponentGetValue2( c_comp, 'run_velocity' ),
					fly_velocity_x = ComponentGetValue2( c_comp, 'fly_velocity_x' ),
				}

				set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
					pixel_gravity = values.pixel_gravity / 1.2,
					run_velocity = values.run_velocity * 1.2,
					fly_velocity_x = values.fly_velocity_x * 1.2,
				}, nil )
			end
		end,
		func_remove = function ( entity_who_picked )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'CURSE_DEATH_TRAIL' )

			local c_comp = EntityGetFirstComponent( entity_who_picked, 'CharacterPlatformingComponent' )

			if ( c_comp ~= nil ) then
				local values = {
					pixel_gravity = ComponentGetValue2( c_comp, 'pixel_gravity' ),
					run_velocity = ComponentGetValue2( c_comp, 'run_velocity' ),
					fly_velocity_x = ComponentGetValue2( c_comp, 'fly_velocity_x' ),
				}

				set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
					pixel_gravity = values.pixel_gravity * 1.2,
					run_velocity = values.run_velocity / 1.2,
					fly_velocity_x = values.fly_velocity_x * 1.2,
				}, nil )
			end
		end,
	},
}

local changed_perks = {
	{
		id = 'VAMPIRISM',
		func = function( entity_perk_item, entity_who_picked, item_name )
			add_halo_level( entity_who_picked, -1 )
		end,
	},
}

for i, _ in ipairs( new_perks ) do
	if ( _.info and _.info ~= '' ) then
		local info = string.lower( _.info )
		local e_info = 'empty_' .. info

		_.id				= string.upper( e_info )
		_.ui_name			= '$perk_' .. e_info
		_.ui_description	= '$perkdesc_' .. e_info
		_.ui_icon			= ui_icon_url .. info .. '.png'
		_.perk_icon			= perk_icon_url .. info .. '.png'
		_.info				= nil
	end
end

replace_table( perk_list, changed_perks, true )
add_table( perk_list, new_perks, false, false )

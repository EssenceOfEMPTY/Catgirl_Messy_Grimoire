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

												for k, comp in ipairs( spell_comps or { } ) do
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

			GlobalsSetValue( 'TEMPLE_PERK_REROLL_COUNT', tostring( reroll_count - 3 ) )
		end,
		func_remove = function ( entity_who_picked )
			local reroll_count = tonumber( GlobalsGetValue( 'TEMPLE_PERK_REROLL_COUNT', '0' ) ) or 0

			GlobalsSetValue( 'TEMPLE_PERK_REROLL_COUNT', tostring( reroll_count - 9 ) )
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

			GlobalsSetValue( 'fungal_shift_iteration', tostring( shift_count - 5 ) )
		end,
	},
	{
		info = 'berserk_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_berserk',
				blood_spray_material = 'magic_liquid_berserk',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_berserk_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_berserk_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'teleport_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_teleportation',
				blood_spray_material = 'magic_liquid_teleportation',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_freeze_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_freeze_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_TELEPORT_PICKUP_COUNT', '0' ) ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_TELEPORT', false, false, true )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'freeze_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood_cold',
				blood_spray_material = 'blood_cold',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_freeze_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_freeze_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_FREEZE_PICKUP_COUNT', '0' ) ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_FREEZE', false, false, true )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'lava_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'lava',
				blood_spray_material = 'lava',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_lava_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_lava_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_LAVA_PICKUP_COUNT', '0' ) ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_LAVA', false, false, true )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'acid_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'acid',
				blood_spray_material = 'acid',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_acid_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_acid_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_ACID_PICKUP_COUNT', '0' ) ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_ACID', false, false, true )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'polymorph_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_polymorph',
				blood_spray_material = 'magic_liquid_polymorph',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_polymorph_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_polymorph_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PROTECTION_POLYMORPH_PICKUP_COUNT', '0' ) ) == 0 ) then
				perk_pickup( nil, entity_who_picked, 'EMPTY_PROTECTION_POLYMORPH', false, false, true )
			end
		end,
		func_remove = function ( entity_who_picked )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = tonumber( ComponentGetValue2( comp, 'blood_multiplier' ) ) or 0

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
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
					for _, damagemodel in ipairs( damagemodels ) do
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
					for _, damagemodel in ipairs( damagemodels ) do
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
				_tags = 'protection_teleport',
				script_shot = empty_path .. 'scripts/perks/protection_teleport.lua',
			} )

			--LoadGameEffectEntityTo( entity_who_picked,  )
			--add_comp_remove_dupli( entity_who_picked, 'GameEffectComponent', 'protection_teleport', {
			--	effect = 'PROTECTION_DURING_TELEPORT',
			--	frames = -1,
			--} )
		end,
		func_remove = function( entity_who_picked )
			EntityAddTag( entity_who_picked, 'teleportable' )
			EntityRemoveTag( entity_who_picked, 'teleportable_NOT' )
			EntityRemoveTag( entity_who_picked, 'no_swap' )

			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_protection_teleport' )

			-- TODO: 移除 GameEffect
		end,
	},
	{
		info = 'protection_slice',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'empty_protection_slice', {
				_tags = 'protection_slice',
				script_shot = empty_path .. 'scripts/perks/protection_slice.lua',
			} )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			if ( damagemodels ) then
				for _, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'slice', 0 )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_protection_slice' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			if ( damagemodels ) then
				for _, damagemodel in ipairs( damagemodels ) do
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
				for _, damagemodel in ipairs( damagemodels ) do
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
				for _, damagemodel in ipairs( damagemodels ) do
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', 'poison', 1 )
				end
			end
		end,
	},
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
		info = 'return',
		stackable = STACKABLE_YES,
		usable_by_enemies = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			local d_comps = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, 1 )
				end
			end
		end,
		func_remove = function ( entity_who_picked )
			local d_comps = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, 1 )
				end
			end
		end,
	},
	{
		info = 'borrowed_vulnerability',
		stackable = STACKABLE_YES,
		usable_by_enemies = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			local d_comps = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					local mul = tonumber( ComponentObjectGetValue2( d_comp, 'damage_multipliers', _ ) ) or 1.0
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, mul * 1.25 )
				end
			end
		end,
		func_remove = function ( entity_who_picked )
			local d_comps = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					local mul = tonumber( ComponentObjectGetValue2( d_comp, 'damage_multipliers', _ ) ) or 1.0
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, mul / 3.25 )
				end
			end
		end,
	},
	{
		info = 'stone_skin',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			EntityAddTag( entity_who_picked, 'drillable' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.25,
				fire = 0.25,
				drill = 3.25,
				slice = 0.5,
				ice = 3.25,
				physics_hit = 0.5,
				radioactive = 0.5,
				poison = 0.5,
				curse = 3.25,
				holy = 3.25,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( d_muls ) do
					local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
					ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
				end
			end
		end,
		func_remove = function( entity_who_picked )
			EntityRemoveTag( entity_who_picked, 'drillable' )

			local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.25,
				fire = 0.25,
				drill = 3.25,
				slice = 0.5,
				ice = 3.25,
				physics_hit = 0.5,
				radioactive = 0.5,
				poison = 0.5,
				curse = 3.25,
				holy = 3.25,
			}

			for _, damagemodel in ipairs( damagemodels or { } ) do
				for damageType, multiplier in pairs( d_muls ) do
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

			EntityAddComponent( entity_who_picked, 'LuaComponent', {
				_tags = 'empty_radiance,perk_component',
				script_source_file = empty_path .. 'scripts/perks/radiance.lua',
				execute_every_n_frame = 60,
			} )

			local child_id = EntityLoad( empty_path .. 'entities/misc/perks/radiance.xml', x, y )

			EntityAddTag( child_id, 'perk_empty_radiance' )
			EntityAddChild( entity_who_picked, child_id )
		end,
		func_remove = function( entity_who_picked )
			local remove = 'empty_radiance'

			remove_all_comp( entity_who_picked, 'LuaComponent', remove )
			remove_all_child( entity_who_picked, remove )
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
			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'empty_percentage_off', {
				_tags='empty_percentage_off,perk_component',
				execute_every_n_frame='60',
				script_source_file=empty_path .. 'scripts/perks/percentage_off.lua',
			} )
 		end,
		func_remove = function( entity_who_picked )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_percentage_off' )
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

			if ( data_comp ) then
				local shield_entity = tonumber( ComponentGetValue2( data_comp, 'value_string' ) ) or 0

				if ( is_alive( shield_entity ) ) then
					EntityKill( shield_entity )
				end
			end

			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_sanctuary_shield_tracker' )
			remove_all_comp( entity_who_picked, 'VariableStorageComponent', 'empty_sanctuary_shield_data' )
			remove_all_comp( entity_who_picked, 'VariableStorageComponent', 'empty_sanctuary_shield_position' )
		end,
	},
	{
		info = 'adjust',
		stackable = STACKABLE_YES,
		stackable_maximum = 3,
		usable_by_enemies = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local tag = 'adjust'

			if ( not EntityHasTag( entity_who_picked, tag ) ) then
				add_comp( entity_who_picked, 'VariableStorageComponent', {
					_tags = tag,
					value_int = 0,
					value_float = 1,
				} )

				add_comp( entity_who_picked, 'LuaComponent', {
					_tags = tag,
					script_source_file = empty_path .. 'scripts/perks/adjust_add_frame.lua',
					execute_every_n_frame = 0,
				} )

				add_comp( entity_who_picked, 'ShotEffectComponent', {
					_tags = tag,
					extra_modifier = 'adjust',
				} )

				local x, y = EntityGetTransform( entity_who_picked )

				local c1 = EntityLoad( empty_path .. 'entities/misc/perks/adjust_aim_1.xml', x, y )
				local c2 = EntityLoad( empty_path .. 'entities/misc/perks/adjust_aim_2.xml', x, y )

				EntityAddChild( entity_who_picked, c1 )
				EntityAddChild( entity_who_picked, c2 )

				EntityAddTag( entity_who_picked, tag )
			else
				local count, delta = get_comp_info( entity_who_picked, 'VariableStorageComponent', tag, {
					{ 'value_int', 0 },
					{ 'value_float', 1 },
				}, nil )

				set_comp_value( entity_who_picked, 'VariableStorageComponent', tag, {
					value_int = count,
					value_float = delta + 1,
				}, nil, nil )
			end
		end,
		func_remove = function( entity_who_picked )
			-- TODO
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
			local tag = 'empty_health_regeneration'

			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', tag, {
				_tags = tag,
				execute_every_n_frame = 1800,
				script_source_file = empty_path .. 'scripts/perks/health_regeneration.lua',
			} )
		end,
		func_remove = function( entity_who_picked )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_health_regeneration' )
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
					script_source_file = empty_path .. 'scripts/perks/curse/curse_illiterate.lua',
				}
			)
			local content_need_obfuscate = backup_common_csv( )
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
			reset_common_csv( )
		end,
	},]]--
	{
		info = 'curse_monk',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				fire = 0.5,
				electricity = 0.5,
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

			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '1' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'empty_curse_monk', {
					_tags = 'empty_curse_monk,perk_component',
					execute_every_n_frame = 60,
					script_source_file = empty_path .. 'scripts/perks/curse/curse_monk.lua',
				} )

				set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
					for d_type, mul in pairs( d_muls ) do
						local cur = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type ) or 1
						ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur * mul )
					end
				end, nil )

				if ( tonumber( GlobalsGetValue( 'PERK_PICKED_GOLD_IS_FOREVER_PICKUP_COUNT', '0' ) ) == 0 ) then
					perk_pickup( nil, entity_who_picked, 'GOLD_IS_FOREVER', false, false, true )
				end

				for _ = 1, 5 do
					perk_pickup( nil, entity_who_picked, 'ATTRACT_ITEMS', false, false, true )
				end

				if ( tonumber( GlobalsGetValue( 'PERK_PICKED_EMPTY_PERCENTAGE_OFF_PICKUP_COUNT', '0' ) ) == 0 ) then
					perk_pickup( nil, entity_who_picked, 'EMPTY_PERCENTAGE_OFF', false, false, true )
				end
			else
				local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )

				for _, damagemodel in ipairs( damagemodels or { } ) do
					for damageType, multiplier in pairs( d_muls ) do
						local currentMultiplier = tonumber( ComponentObjectGetValue2( damagemodel, 'damage_multipliers', damageType ) ) or 1.0
						ComponentObjectSetValue2( damagemodel, 'damage_multipliers', damageType, currentMultiplier * multiplier )
					end
				end
			end
		end,
		func_remove = function( entity_who_picked )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				fire = 0.5,
				electricity = 0.5,
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

			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '0' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				remove_all_comp( entity_who_picked, 'LuaComponent', 'empty_curse_monk' )
				remove_all_comp( entity_who_picked, 'VariableStorageComponent', 'empty_curse_monk' )

				set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
					for d_type, mul in pairs( d_muls ) do
						local cur = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type ) or 1
						ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur / mul )
					end
				end, nil )
			else
				set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
					for d_type, mul in pairs( d_muls ) do
						local cur = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type ) or 1
						ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur / mul )
					end
				end, nil )
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

			for _, wand in ipairs( wands ) do
				local fire_rate, relaod = get_comp_obj_info( wand, 'AbilityComponent', nil, {
					{ 'gunaction_config', 'fire_rate_wait', 0 },
					{ 'gun_config', 'reload_time', 0 },
				} )

				if ( fire_rate > 0 ) then
					fire_rate = fire_rate / 2
				else
					fire_rate = fire_rate * 2
				end
				if ( relaod > 0 ) then
					relaod = relaod / 2
				else
					relaod = relaod * 2
				end

				set_comp_obj_value( wand, 'AbilityComponent', nil, {
					{ 'gun_config', 'shuffle_deck_when_empty', true },
					{ 'gunaction_config', 'fire_rate_wait', fire_rate },
					{ 'gun_config', 'reload_time', relaod },
				}, nil, nil )
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

			for _, wand in ipairs( wands ) do
				local mana_charge, mana_max = get_comp_info( wand, 'AbilityComponent', nil, {
					{ 'mana_charge_speed', 0 },
					{ 'mana_max', 0 },
				}, nil )

				set_comp_value( wand, 'AbilityComponent', nil, {
					mana_charge_speed = 1.2 * mana_charge,
					mana_max = 1.2 * mana_max,
				}, nil, nil )

				local deck_cap = get_comp_obj_info( wand, 'AbilityComponent', nil, {
					{ 'gun_config', 'deck_capacity', 0 },
				}, nil )

				local deck_cap_real = EntityGetWandCapacity( wand )
				local always_count = deck_cap - deck_cap_real

				if ( deck_cap_real > 0 ) then
					if ( deck_cap_real < 15 ) then
						deck_cap_real = deck_cap_real / 2
					elseif ( deck_cap_real < 29 ) then
						deck_cap_real = deck_cap_real / 4
					else
						deck_cap_real = 1
					end
				end

				set_comp_obj_value( wand, 'AbilityComponent', nil, {
					{ 'gun_config', 'deck_capacity', math.floor( deck_cap_real ) + always_count },
				}, nil, nil )

				remove_cards_until_fix( wand, deck_cap, always_count )
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
			local curse = 'CURSE_MALICE_WASHES_OVER'

			if ( is_player( entity_who_picked ) ) then
				local players = get_all_players( )

				for _, player in ipairs( players ) do
					if ( EntityGetIsAlive( player ) ) then
						local x, y = EntityGetTransform( player )

						add_comp_remove_dupli( player, 'VariableStorageComponent', curse, {
							_tags = curse,
							value_float = x,
							value_string = tostring( y ),
						} )

						add_comp_remove_dupli( player, 'LuaComponent', curse, {
							_tags = curse,
							script_source_file = empty_path .. 'scripts/perks/curse/curse_malice_washes_over_delay.lua',
							execute_every_n_frame = 300,
							remove_after_executed = true,
						} )
					end
				end
			else
				local x, y = EntityGetTransform( entity_who_picked )

				add_comp_remove_dupli( entity_who_picked, 'VariableStorageComponent', curse, {
					_tags = curse,
					value_float = x,
					value_string = tostring( y ),
				} )

				add_comp_remove_dupli( entity_who_picked, 'LuaComponent', curse, {
					_tags = curse,
					script_source_file = empty_path .. 'scripts/perks/curse/curse_malice_washes_over_delay.lua',
					execute_every_n_frame = 180,
					remove_after_executed = true,
				} )
			end
		end,
		func_remove = function( entity_who_picked )
			local curse = 'CURSE_MALICE_WASHES_OVER'

			remove_all_comp( entity_who_picked, 'VariableStorageComponent', curse )
			remove_all_comp( entity_who_picked, 'LuaComponent', curse )

			remove_all_child( entity_who_picked, curse )
		end,
	},
	{
		info = 'curse_reality_shift',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( entity_perk_empty_item, entity_who_picked, item_name )
			local x, y = EntityGetTransform( entity_who_picked )
			local a, b, c = time_for_vec3( )

			fungal_shift( entity_who_picked, x + a + c, y + b + c, true )
			fungal_shift( entity_who_picked, x + a + c, y + b - c, true )
			fungal_shift( entity_who_picked, x + a - c, y + b - c, true )
			fungal_shift( entity_who_picked, x + a + c, y - b - c, true )
			fungal_shift( entity_who_picked, x + a - c, y - b - c, true )
			fungal_shift( entity_who_picked, x - a - c, y - b - c, true )
			fungal_shift( entity_who_picked, x - a - c, y - b + c, true )
			fungal_shift( entity_who_picked, x - a - c, y + b + c, true )
			fungal_shift( entity_who_picked, x - a + c, y - b + c, true )
			fungal_shift( entity_who_picked, x - a + c, y + b + c, true )

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
			local d_muls = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				fire = 4.0,
				electricity = 4.0,
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

			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '1' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
					for d_type, d_mul in pairs( d_muls ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type )

						ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur_mul * d_mul )
					end
				end, nil )

				local hp_max = get_comp_info( entity_who_picked, 'DamageModelComponent', nil, {
					{ 'max_hp', -1 },
				}, nil )

				if ( hp_max > 1 / get_scale( ) ) then
					set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
						hp = 2 * hp_max,
						max_hp = 2 * hp_max,
					}, nil, nil )
				end

				local x, y = EntityGetTransform( entity_who_picked )

				for _ = 1, 4, 1 do
					EntityLoad( empty_path .. 'entities/items/potions/potion_healthium_many_hp.xml', x + loc_center_fix( 4, 4, _ ), y )
				end
			else
				set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
					for d_type, d_mul in pairs( d_muls ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type )

						ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur_mul * d_mul )
					end
				end, nil )
			end
		end,
		func_remove = function( entity_who_picked )
			local d_muls = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				fire = 4.0,
				electricity = 4.0,
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

			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end
			end

			set_comp_obj_value( entity_who_picked, 'DamageModelComponent', nil, nil, function ( comp )
				for d_type, d_mul in pairs( d_muls ) do
					local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', d_type )

					ComponentObjectSetValue2( comp, 'damage_multipliers', d_type, cur_mul / d_mul )
				end
			end, nil )
		end,
	},
	{
		info = 'curse_gravity_free',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GRAVITY_FREE', '1' )
			end

			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 0,
				run_velocity = 0,
				jump_velocity_x = 0,
				fly_speed_max_up = 0,
				fly_speed_max_down = 0,
				fly_velocity_x = 0,
			}, nil, nil )

			if ( is_player( entity_who_picked ) ) then
				local x, y = EntityGetTransform( entity_who_picked )

				CreateItemActionEntity( 'HOOK', x, y )

				local e = EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

				add_comp_remove_dupli( e, 'LifetimeComponent', nil, {
					lifetime = 3600,
				} )
			end
		end,
		func_remove = function ( entity_who_picked )
			if ( is_player( entity_who_picked ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GRAVITY_FREE', '0' )
			end

			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 350,
				run_velocity = 57,
				jump_velocity_x = 56,
				fly_speed_max_up = 95,
				fly_speed_max_down = 85,
				fly_velocity_x = 52,
			}, nil, nil )
		end,
	},
	{
		info = 'curse_death_trail',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			local curse = 'CURSE_DEATH_TRAIL'

			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', curse, {
				_tags = curse,
				script_source_file = empty_path .. 'scripts/perks/curse/curse_death_trail.lua',
				execute_every_n_frame = 0,
				remove_after_executed = true,
			} )

			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', curse, {
				_tags = curse,
				script_source_file = empty_path .. 'scripts/perks/curse/curse_death_trail.lua',
				execute_every_n_frame = 2,
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
				}, nil, nil )
			end
		end,
		func_remove = function ( entity_who_picked )
			local curse = 'CURSE_DEATH_TRAIL'

			remove_all_comp( entity_who_picked, 'LuaComponent', curse )
			remove_all_comp( entity_who_picked, 'VariableStorageComponent', curse )

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
					fly_velocity_x = values.fly_velocity_x / 1.2,
				}, nil, nil )
			end
		end,
	},--[[
	{
		info = 'curse_furious_cocktail',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( entity_perk_empty_item, entity_who_picked, item_name )
			add_comp_remove_dupli( entity_who_picked, 'LuaComponent', 'CURSE_FURIOUS_COCKTAIL', {
				_tags = 'CURSE_FURIOUS_COCKTAIL',
				script_source_file = empty_path .. 'scripts/perks/curse/curse_furious_cocktail.lua',
				execute_every_n_frame = 540,
			} )
		end,
		func_remove = function ( entity_who_picked )
			remove_all_comp( entity_who_picked, 'LuaComponent', 'CURSE_FURIOUS_COCKTAIL' )
		end,
	},]]--
}

local changed_perks = {
	{
		id = 'BREATH_UNDERWATER',
		func = function( entity_perk_item, entity_who_picked, item_name )
			local swim = { }

			swim.swim_idle, swim.swim_up, swim.swim_down, swim.swim_drag, swim.swim_drag_extra =
			get_comp_info( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				{ 'swim_idle_buoyancy_coeff', 1.2 },
				{ 'swim_up_buoyancy_coeff', 0.9 },
				{ 'swim_down_buoyancy_coeff', 0.7 },
				{ 'swim_drag', 0.95 },
				{ 'swim_extra_horizontal_drag', 0.9 },
			}, nil )

			swim.swim_idle = swim.swim_idle * 0.6
			swim.swim_up = swim.swim_up * 0.2
			swim.swim_down = swim.swim_down * 0.2
			swim.swim_drag = swim.swim_drag * 1.2
			swim.swim_drag_extra = swim.swim_drag_extra * 1.2

			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, swim, nil, nil )
		end,
		func_remove = function( entity_who_picked )
			local swim = { }

			swim.swim_idle, swim.swim_up, swim.swim_down, swim.swim_drag, swim.swim_drag_extra =
			get_comp_info( entity_who_picked, 'CharacterPlatformingComponent', nil, {
				{ 'swim_idle_buoyancy_coeff', 1.2 },
				{ 'swim_up_buoyancy_coeff', 0.9 },
				{ 'swim_down_buoyancy_coeff', 0.7 },
				{ 'swim_drag', 0.95 },
				{ 'swim_extra_horizontal_drag', 0.9 },
			}, nil )

			swim.swim_idle = swim.swim_idle / 0.6
			swim.swim_up = swim.swim_up / 0.2
			swim.swim_down = swim.swim_down / 0.2
			swim.swim_drag = swim.swim_drag / 1.2
			swim.swim_drag_extra = swim.swim_drag_extra / 1.2

			set_comp_value( entity_who_picked, 'CharacterPlatformingComponent', nil, swim, nil, nil )
		end,
	},
	{
		id = 'GOLD_IS_FOREVER',
		func = function( entity_perk_item, entity_who_picked, item_name )
			local world = GameGetWorldStateEntity( )

			set_comp_value( world, 'WorldStateComponent', nil, {
				perk_gold_is_forever = true,
			}, nil, nil )
		end,
		func_remove = function( entity_who_picked )
			local world = GameGetWorldStateEntity( )

			set_comp_value( world, 'WorldStateComponent', nil, {
				perk_gold_is_forever = false,
			}, nil, nil )
		end,
	},--[[
	{
		id = '',
		func = function( entity_perk_item, entity_who_picked, item_name )
		end,
		func_remove = function( entity_who_picked )
		end,
	},]]--
	{
		id = 'VAMPIRISM',
		func = function( entity_perk_item, entity_who_picked, item_name )
			add_halo_level( entity_who_picked, -1 )
		end,
	},
	{
		id = 'PROTECTION_RADIOACTIVITY',
		func = function( entity_perk_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				radioactive = 0,
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, entity_who_picked, item_name )
			set_comp_value( entity_who_picked, 'DamageModelComponent', nil, {
				radioactive = 1,
			}, nil, nil )
		end,
	},
}

for i, _ in ipairs( new_perks ) do
	if ( is_not_nil_str( _.info ) ) then
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

update_table_by_id( perk_list, changed_perks, true )
add_table( perk_list, new_perks, false, false )

function get_perk_act_count( entity, perk_name )
	local count = 0

	for i, child in ipairs( get_all_child( entity ) ) do
		if ( is_has_comp( child, 'UIIconComponent', nil, perk_name ) ) then
			count = count + 1
		end
	end

	return count
end

function undo_perk_pickup( style )
	local flag = string.upper( style ) .. '_PERK_TOTAL_COUNT'
	local count = tonumber( GlobalsGetValue( flag, '0' ) )

	GlobalsSetValue( flag, tostring( count - 1 ) )
end

function apply_last_bleed( entity, perk_entity )
	local act_perks = get_act_perks( )
end
--[[]]--
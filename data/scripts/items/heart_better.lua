dofile( 'data/scripts/game_helpers.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function item_pickup( entity_item, entity_who_picked, name )

	local damagemodels = EntityGetComponent( entity_who_picked, 'DamageModelComponent' )
	local variablestorages = EntityGetComponent( entity_who_picked, 'VariableStorageComponent' )

	local max_hp_old = 0
	local max_hp = 0.0
	local multiplier = tonumber( GlobalsGetValue( 'HEARTS_MORE_EXTRA_HP_MULTIPLIER', '1' ) )

	local also_heal = tonumber( GlobalsGetValue( 'EMPTY_HEARTS_ALSO_HEAL', '0' ) ) or 0
	local add_count = 0.0

	local x, y = EntityGetTransform( entity_item )

	if ( damagemodels ) then
		for i,damagemodel in ipairs(damagemodels) do
			max_hp = tonumber( ComponentGetValue2( damagemodel, 'max_hp' ) ) or 0
			max_hp_old = max_hp
			max_hp = max_hp + 2 * multiplier

			local max_hp_cap = tonumber( ComponentGetValue2( damagemodel, 'max_hp_cap' ) )
			if max_hp_cap > 0 then
				max_hp = math.min( max_hp, max_hp_cap )
			end

			ComponentSetValue2( damagemodel, 'max_hp_old', max_hp_old )
			ComponentSetValue2( damagemodel, 'max_hp', max_hp )
			ComponentSetValue2( damagemodel, 'mLastMaxHpChangeFrame', GameGetFrameNum() )

			add_count = max_hp - max_hp_old
			if ( also_heal > 0 and add_count > 0 ) then
				local hp = ComponentGetValue2( damagemodel, 'hp' ) or 4
				hp = hp + add_count
				ComponentSetValue2( damagemodel, 'hp', hp )
			end
		end
	end

	EntityLoad('data/entities/particles/image_emitters/heart_effect.xml', x, y - 12 )
	EntityLoad('data/entities/particles/heart_out.xml', x, y - 8 )
	local description = GameTextGet( '$logdesc_heart_better', tostring( math.floor( max_hp * get_scale( ) ) ) )
	if ( max_hp == max_hp_old ) then
		description =  GameTextGet( '$logdesc_heart_blocked', tostring( math.floor( max_hp * get_scale( ) ) ) )
	end

	if ( also_heal > 0 and add_count > 0 ) then
		description = description .. GameTextGet( '$empty_also_heal_extra_text' )
	end

	GamePrintImportant( '$log_heart_better', description )
	GameTriggerMusicCue( 'item' )

	EntityKill( entity_item )
end

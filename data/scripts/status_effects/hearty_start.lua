dofile_once( 'data/scripts/lib/utilities.lua' )

local entity_id = GetUpdatedEntityID( )
local player_id = EntityGetParent( entity_id )

if ( player_id ~= NULL_ENTITY ) and ( entity_id ~= player_id ) then
	local variablestorages = EntityGetComponent( entity_id, 'VariableStorageComponent' )
	local dcomps = EntityGetComponent( player_id, 'DamageModelComponent' )

	local stop = false
	local max_hp_before = 0

	if ( dcomps ) then
		for _, comp in ipairs( dcomps ) do
			local hp = ComponentGetValue2( comp, 'hp' )
			local max_hp = ComponentGetValue2( comp, 'max_hp' )

			if ( max_hp <= 0.08 ) or ( EntityHasTag( player_id, 'boss_centipede' ) and ( GameGetOrbCountThisRun( ) >= 33 ) ) then
				stop = true
			end

			if ( not stop ) then
				max_hp_before = max_hp
				max_hp = max_hp * 0.5

				if ( hp > max_hp ) then
					hp = max_hp

					ComponentSetValue2( comp, 'hp', hp )
				end

				ComponentSetValue2( comp, 'max_hp', max_hp )
			end
		end
	end

	if ( variablestorages ) then
		for _, storage_id in ipairs( variablestorages ) do
			local var_name = ComponentGetValue2( storage_id, 'name' )
			if ( var_name == 'effect_hearty' ) then
				if ( not stop ) then
					ComponentSetValue2( storage_id, 'value_float', max_hp_before )
				else
					EntityRemoveComponent( entity_id, storage_id )
				end

				break
			end
		end
	end
end

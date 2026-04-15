dofile_once( 'data/scripts/lib/utilities.lua' )

local entity_id = GetUpdatedEntityID( )
local player_id = EntityGetRootEntity( entity_id )

local variablestorages = EntityGetComponent( entity_id, 'VariableStorageComponent' )
local max_hp_before = 0

if ( variablestorages ) then
	for _, storage_id in ipairs( variablestorages ) do
		local var_name = ComponentGetValue2( storage_id, 'name' )
		if ( var_name == 'effect_hearty' ) then
			max_hp_before = ComponentGetValue2( storage_id, 'value_float' )
		end
	end
end

if ( max_hp_before > 0 ) then
	edit_component( player_id, 'DamageModelComponent', function( comp, vars )
		ComponentSetValue2( comp, 'max_hp', max_hp_before )
	end )
end

dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function init_potion( entity_id, potion_material )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )

	local components = EntityGetComponent( entity_id, 'VariableStorageComponent' )

	if ( components ) then
		for _, comp_id in pairs( components ) do
			local var_name = ComponentGetValue2( comp_id, 'name' )
			if ( var_name == 'potion_material' ) then
				potion_material = ComponentGetValue2( comp_id, 'value_string' )
			end
		end
	end

	local total_capacity = tonumber( GlobalsGetValue( 'EXTRA_POTION_CAPACITY_LEVEL', '2000' ) ) or 2000
	if ( total_capacity > 2000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, 'MaterialSuckerComponent' )

		if ( comp ) then
			ComponentSetValue2( comp, 'barrel_size', total_capacity )
		end

		EntityAddTag( entity_id, 'extra_potion_capacity' )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end

dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

if ( entity ~= NULL_ENTITY ) then
	local v_comps = EntityGetComponent( entity, 'VariableStorageComponent', 'CURSE_MALICE_WASHES_OVER' )

	if ( v_comps ) then
		local comp = v_comps[ 1 ]
		local x, y = ComponentGetValue2( comp, 'value_float' ), tonumber( ComponentGetValue2( comp, 'value_string' ) ) or 0

		local child_e = EntityLoad( empty_path .. 'entities/misc/curse/curse_malice_washes_over.xml', x, y )
		EntityAddChild( entity, child_e )

		for _, v_comp in ipairs( v_comps ) do
			EntityRemoveComponent( entity, v_comp )
		end
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local lua_comps = EntityGetComponentIncludingDisabled( entity, 'LuaComponent' )

	for _, lua_comp in ipairs( lua_comps or { } ) do
		EntityRemoveComponent( entity, lua_comp )
	end
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_arc_set'
local command_delay = command .. '_delay'
local command_death = command_delay .. '_death'

if ( entity ~= NULL_ENTITY ) then
	local remove_comps = EntityGetComponent( entity, 'VariableStorageComponent', command_delay ) or { }

	add_table( remove_comps, EntityGetComponent( entity, 'LuaComponent', command_delay ) or { } )
	add_table( remove_comps, EntityGetComponent( entity, 'LuaComponent', command_death ) or { } )

	for _, remove_comp in ipairs( remove_comps ) do
		EntityRemoveComponent( entity, remove_comp )
	end
end

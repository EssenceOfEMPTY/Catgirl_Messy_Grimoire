dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
local command = 'projectile_arc_set'
local command_delay = command .. '_delay'
local command_reflect = command .. '_reflect'
local command_trigger = command_delay .. '_trigger'

if ( entity ~= NULL_ENTITY ) then
	local remove_comps = EntityGetComponent( entity, 'VariableStorageComponent', command_reflect ) or { }

	add_table( remove_comps, EntityGetComponent( entity, 'LuaComponent', command_reflect ) or { } )
	add_table( remove_comps, EntityGetComponent( entity, 'VariableStorageComponent', 'projectile_arc_add_reflect' ) or { } )
	add_table( remove_comps, EntityGetComponent( entity, 'LuaComponent', 'projectile_arc_add_reflect' ) or { } )

	for _, remove_comp in ipairs( remove_comps or { } ) do
		EntityRemoveComponent( entity, remove_comp )
	end

	EntityAddComponent2( entity, 'LuaComponent', {
		_tags = command_delay,
		script_source_file = empty_path .. 'scripts/projectiles/command/' .. command_delay .. '.lua',
		execute_every_n_frame = 0,
	} )

	local l_comps = EntityGetComponent( entity, 'LuaComponent', command_trigger )

	for _, l_comp in ipairs( l_comps or { } ) do
		EntityRemoveComponent( entity, l_comp )
	end
end

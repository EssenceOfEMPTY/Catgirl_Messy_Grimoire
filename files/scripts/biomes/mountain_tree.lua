
local old_spawn_ocarina = spawn_ocarina
function spawn_ocarina( x, y )
	EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

	old_spawn_ocarina( x, y )
end

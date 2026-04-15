dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function init( entity_id )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )
	-- local potion = random_from_array( potions )
	local materials = nil

	if ( Random( 0, 100 ) <= 50 ) then
		materials = CellFactory_GetAllLiquids( false )
	else
		materials = CellFactory_GetAllSands( false )
	end

	local potion_material = random_from_array( materials )

	-- AddMaterialInventoryMaterial( entity_id, potion.material, 1000 )
	AddMaterialInventoryMaterial( entity_id, potion_material, 2000 )
end

dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'data/scripts/items/init_potion.lua' )
 dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )


function potion_a_materials( )
	return random_from_array( { 'water', 'blood',
		'mud', 'water_swamp', 'water_salt', 'swamp', 'snow',
		'acid', 'magic_liquid_polymorph', 'magic_liquid_random_polymorph', 'magic_liquid_berserk', 'magic_liquid_charm', 'magic_liquid_movement_faster',
		'gold', 'slime', 'gunpowder_unstable', 'urine',
		'magic_liquid_teleportation', 'magic_liquid_unstable_teleportation', 'material_confusion', 'magic_liquid_invisibility', 'magic_liquid_protection_all', 'void_liquid' } )
end


function init( entity_id )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )

	local potion_material = 'water'

	local n_of_deaths = tonumber( StatsGlobalGetValue( 'death_count' ) )
	if ( n_of_deaths >= 1 ) then

		potion_material = potion_a_materials( )
	end

	if ( Random( 1, 100 ) < 5 ) then
		potion_material = 'sima'
	end

	init_potion( entity_id, potion_material )
end

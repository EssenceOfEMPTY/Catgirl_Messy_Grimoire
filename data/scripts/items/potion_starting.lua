dofile_once( 'data/scripts/items/init_potion.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function init( entity_id )
	local x, y = EntityGetTransform( entity_id )
	local a, b, c = time_for_vec3( )
	SetRandomSeed( x + a - c, y + b - c )

	local mat = 'water'

	local n_of_deaths = tonumber( StatsGlobalGetValue( 'death_count' ) )

	if ( n_of_deaths >= 1 ) then
		mat = get_random_from( {
			'gold',
			'water', 'blood', 'mud', 'water_swamp', 'water_salt', 'swamp', 'snow', 'slime', 'urine',
			'acid',
			'magic_liquid_polymorph', 'magic_liquid_random_polymorph',
			'magic_liquid_berserk',
			'magic_liquid_charm',
			'magic_liquid_movement_faster',
			'gunpowder_unstable',
			'magic_liquid_teleportation', 'magic_liquid_unstable_teleportation',
			'material_confusion',
			'magic_liquid_invisibility',
			'magic_liquid_protection_all',
			'void_liquid'
		} )
	end

	if ( Random( 1, 100 ) < 5 ) then
		mat = 'sima'
	end

	init_potion( entity_id, mat )
end

dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )

set_comp_value( entity, 'HitboxComponent', nil, nil, function ( comp )
	local dm = ComponentGetValue2( comp, 'damage_multiplier' ) or 1.0

	ComponentSetValue2( comp, 'damage_multiplier', math.min( 1.0, dm + 0.15 ) )
end, nil )

EntitySetComponentsWithTagEnabled( entity, 'invincible', false )

local state = 0
local p = ''
local pathfinding_frames_stuck = 0
local comps = EntityGetComponent( entity, 'VariableStorageComponent' )

for i, v in ipairs( comps or { } ) do
	local n = ComponentGetValue2( v, 'name' )
	if ( n == 'state' ) then
		state = ComponentGetValue2( v, 'value_int' )
		state = ( state + 1 ) % 10
		ComponentSetValue2( v, 'value_int', state )
	elseif ( n == 'memory' ) then
		p = ComponentGetValue2( v, 'value_string' )
		if ( #p == 0 ) then
			p = 'data/entities/projectiles/enlightened_laser_darkbeam.xml'
			ComponentSetValue2( v, 'value_string', p )
		end
	elseif ( n == 'pathfinding_frames_stuck' ) then
		pathfinding_frames_stuck = ComponentGetValue2( v, 'value_int' )
	end
end

local a, b, c = time_for_vec3( )
SetRandomSeed( x + a + c, y + b + c )

if ( state == 1 ) then
	if ( #p > 0 ) then
		local angle = Random( 1, 200 ) * math.pi
		local vel_x = math.cos( angle ) * 100
		local vel_y = 0 - math.cos( angle ) * 100

		local spells = { 'rocket', 'rocket_tier_2', 'rocket_tier_3', 'grenade', 'grenade_tier_2', 'grenade_tier_3', 'rubber_ball' }
		local rnd = Random( 1, #spells )
		local path = 'data/entities/projectiles/deck/' .. spells[ rnd ] .. '.xml'

		local wid = shoot_proj( entity, 'data/entities/animals/boss_pit/wand.xml', x, y, vel_x, vel_y, nil, nil, nil )

		set_comp_value( wid, 'VariableStorageComponent', nil, {
			value_string = path,
		}, nil, nil )

		EntityAddComponent( wid, 'HomingComponent', {
			homing_targeting_coeff = '30.0',
			homing_velocity_multiplier = '0.16',
			target_tag = 'player_unit',
		} )

		EntityAddComponent( wid, 'HomingComponent', {
			homing_targeting_coeff = '30.0',
			homing_velocity_multiplier = '0.16',
			target_tag = 'polymorphed_player',
		} )

		if ( string.find( path, 'rocket' ) ) then
			EntityAddComponent( wid, 'VariableStorageComponent', {
				name = 'mult',
				value_float = 0.5,
			} )
		else
			EntityAddComponent( wid, 'VariableStorageComponent', {
				name = 'mult',
				value_float = 1.2,
			} )
		end
	end
elseif ( state == 7 ) then
	-- if we're stuck shoot blackholes towards player
	if ( pathfinding_frames_stuck > 180 ) then
		-- we're stuck, lets hunt for that connoisseur of cheese
		shoot_proj( entity, empty_path .. 'entities/projectiles/circle_empty_remove.xml', x, y, 0, 0, nil, nil, nil )
	end

	-- standard logic
	local spells = { 'orb_poly', 'orb_neutral', 'orb_tele', 'orb_dark' }
	local rnd = Random( 1, #spells )
	local path = 'data/entities/projectiles/' .. spells[ rnd ] .. '.xml'

	local arc = math.pi * 0.25
	local offset = math.pi * ( Random( 1, 10 ) * 0.1 )

	for _ = 0, 7 do
		local vel_x = math.cos( arc * _ + offset ) * 300
		local vel_y = 0 - math.sin( arc * _ + offset ) * 300

		shoot_proj( entity, path, x, y, vel_x, vel_y, nil, nil, nil )
	end
end

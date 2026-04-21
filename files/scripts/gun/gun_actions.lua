dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
dofile_once( empty_path .. 'scripts/empty/empty_command_utility.lua' )

local sprite_url = empty_path .. 'ui_gfx/gun_actions/'
local img_unident = 'data/ui_gfx/gun_actions/unidentified.png'

local new_actions =
{
	{
		info = 'summon_frog',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles	= { 'data/entities/animals/frog.xml', 'data/entities/animals/frog_big.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4', -- EMPTY_SUMMON_FROG
		spawn_probability				= '0.1,0.3,0.5,0.7,0.5', -- EMPTY_SUMMON_FROG
		price = 50,
		mana = 20,
		max_uses = 20,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 30

			c.spread_degrees = c.spread_degrees + 3.0

			local entity = GetUpdatedEntityID( )
			local x, y = EntityGetTransform( entity )
			x, y = x or 0, y or 0

			local a, b, c = time_for_vec3( )
			SetRandomSeed( x + a - c, y + b - c )

			if ( Random( 1, 10 ) < 4 ) then
				add_projectile( 'data/entities/animals/frog_big.xml' )
			else
				add_projectile( 'data/entities/animals/frog.xml' )
			end
		end,
	},
	{
		info = 'summon_crystal_red',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles	= { 'data/entities/props/crystal_red.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,5,6', -- EMPTY_SUMMON_CRYSTAL_RED
		spawn_probability				= '0.3,0.4,0.5,0.4,0.3', -- EMPTY_SUMMON_CRYSTAL_RED
		price = 150,
		mana = 60,
		max_uses	= 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 40
			current_reload_time = current_reload_time - 20

			add_projectile( 'data/entities/props/crystal_red.xml' )
		end,
	},
	{
		info = 'summon_crystal_pink',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles	= { 'data/entities/props/crystal_pink.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,5,6', -- EMPTY_SUMMON_CRYSTAL_PINK
		spawn_probability				= '0.3,0.4,0.5,0.4,0.3', -- EMPTY_SUMMON_CRYSTAL_PINK
		price = 150,
		mana = 60,
		max_uses	= 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 40
			current_reload_time = current_reload_time - 20

			add_projectile( 'data/entities/props/crystal_pink.xml' )
		end,
	},
	{
		info = 'summon_crystal_green',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles	= { 'data/entities/props/crystal_green.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,5,6', -- EMPTY_SUMMON_CRYSTAL_GREEN
		spawn_probability				= '0.3,0.4,0.5,0.4,0.3', -- EMPTY_SUMMON_CRYSTAL_GREEN
		price = 150,
		mana = 60,
		max_uses	= 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 40
			current_reload_time = current_reload_time - 20

			add_projectile( 'data/entities/props/crystal_green.xml' )
		end,
	},
	{
		info = 'summon_vine',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/summon_vine.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4,5', -- EMPTY_SUMMON_VINE
		spawn_probability				= '0.6,0.7,0.7,0.6,0.4,0.1', -- EMPTY_SUMMON_VINE
		price = 100,
		mana = 50,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 30
			current_reload_time = current_reload_time - 60

			add_projectile( empty_path .. 'entities/projectiles/deck/summon_vine.xml' )
		end,
	},
	{
		info = 'sticky_bomb',
		series = {
			[ 'bomb' ] = true,
			[ 'sticky' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/sticky_bomb.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4,5,6', -- EMPTY_STICKY_BOMB
		spawn_probability				= '1,1,1,1,0.5,0.5,0.1', -- EMPTY_STICKY_BOMB
		price = 200,
		mana = 30,
		max_uses	= 3,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/sticky_bomb.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 50
			current_reload_time = current_reload_time - 20

			add_projectile( empty_path .. 'entities/projectiles/sticky_bomb.xml' )
		end,
	},
	{
		info = 'bouncy_bomb',
		series = {
			[ 'bomb' ] = true,
			[ 'bouncy' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/bouncy_bomb.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4,5,6', -- EMPTY_BOUNCY_BOMB
		spawn_probability				= '1,1,1,1,0.5,0.5,0.1', -- EMPTY_BOUNCY_BOMB
		price = 200,
		mana = 30,
		max_uses	= 3,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/bouncy_bomb.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 100
			current_reload_time = current_reload_time - 40

			add_projectile( empty_path .. 'entities/projectiles/bouncy_bomb.xml' )
		end,
	},
	{
		info = 'sticky_dynamite',
		series = {
			[ 'dynamite' ] = true,
			[ 'sticky' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/sticky_dynamite.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4', -- EMPTY_STICKY_DYNAMITE
		spawn_probability				= '1,0.9,0.8,0.7,0.6', -- EMPTY_STICKY_DYNAMITE
		price = 160,
		mana = 60,
		max_uses	= 16,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/sticky_dynamite.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 25
			current_reload_time = current_reload_time - 10

			c.spread_degrees = c.spread_degrees + 6.0

			add_projectile( empty_path .. 'entities/projectiles/sticky_dynamite.xml' )
		end,
	},
	{
		info = 'bouncy_dynamite',
		series = {
			[ 'dynamite' ] = true,
			[ 'bouncy' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/bouncy_dynamite.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4', -- EMPTY_BOUNCY_DYNAMITE
		spawn_probability				= '1,0.9,0.8,0.7,0.6', -- EMPTY_BOUNCY_DYNAMITE
		price = 160,
		mana = 60,
		max_uses	= 16,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/bouncy_dynamite.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 50
			current_reload_time = current_reload_time - 20

			c.spread_degrees = c.spread_degrees + 6.0

			add_projectile( empty_path .. 'entities/projectiles/bouncy_dynamite.xml' )
		end,
	},
	{
		info = 'white_hole_death_trigger',
		related_projectiles	= { 'data/entities/projectiles/deck/white_hole.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,4,5,10', -- EMPTY_WHITE_HOLE_DEATH_TRIGGER
		spawn_probability				= '0.2,0.3,0.5,0.8', -- EMPTY_WHITE_HOLE_DEATH_TRIGGER
		price = 220,
		mana = 200,
		max_uses	= 3,
		never_unlimited = true,
		custom_xml_file = 'data/entities/misc/custom_cards/white_hole.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 90

			c.screenshake = c.screenshake + 20

			add_projectile_trigger_death('data/entities/projectiles/deck/white_hole.xml', 1)
		end,
	},
	{
		info = 'light_bullet_death_trigger',
		related_projectiles	= { 'data/entities/projectiles/deck/light_bullet.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3', -- EMPTY_LIGHT_BULLET_DEATH_TRIGGER
		spawn_probability					= '1,0.5,0.5,0.5', -- EMPTY_LIGHT_BULLET_DEATH_TRIGGER
		price = 140,
		mana = 10,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 3

			c.screenshake = c.screenshake + 0.5
			c.damage_critical_chance = c.damage_critical_chance + 5

			add_projectile_trigger_death( 'data/entities/projectiles/deck/light_bullet.xml', 1 )
		end,
	},
	{
		info = 'light_bullet_timer_2',
		related_projectiles	= { 'data/entities/projectiles/deck/light_bullet_blue.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,5,6,10', -- EMPTY_LIGHT_BULLET_TIMER_2
		spawn_probability					= '1,0.5,1,1,0.2', -- EMPTY_LIGHT_BULLET_TIMER_2
		price = 250,
		mana = 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 6

			c.screenshake = c.screenshake + 1
			c.damage_critical_chance = c.damage_critical_chance + 10

			add_projectile_trigger_timer( 'data/entities/projectiles/deck/light_bullet_blue.xml', 10, 2 )
		end,
	},
	{
		info = 'light_bullet_trigger_timer',
		related_projectiles	= { 'data/entities/projectiles/deck/light_bullet.xml', 'data/entities/projectiles/deck/light_bullet_blue.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '3,4,5,6,10', -- EMPTY_LIGHT_BULLET_TRIGGER_TIMER
		spawn_probability					= '1,0.5,0.5,0.5,1', -- EMPTY_LIGHT_BULLET_TRIGGER_TIMER
		price = 320,
		mana = 20,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 9

			c.screenshake = c.screenshake + 1.5
			c.damage_critical_chance = c.damage_critical_chance + 15

			add_projectile_trigger_hit_world( 'data/entities/projectiles/deck/light_bullet.xml', 1 )
			add_projectile_trigger_timer( 'data/entities/projectiles/deck/light_bullet_blue.xml', 10, 1 )
		end,
	},
	{
		info = 'rubber_ball_trigger',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,6', -- EMPTY_RUBBER_BALL_TRIGGER
		spawn_probability					= '1,0.5,0.3,0.2', -- EMPTY_RUBBER_BALL_TRIGGER
		price = 140,
		mana = 10,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 2

			c.spread_degrees = c.spread_degrees - 1.0

			add_projectile_trigger_hit_world( empty_path .. 'entities/projectiles/deck/rubber_ball.xml', 1 )
		end,
	},
	{
		info = 'rubber_ball_timer',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,2,3,6', -- EMPTY_RUBBER_BALL_TIMER
		spawn_probability					= '0.5,0.5,0.25,0.2', -- EMPTY_RUBBER_BALL_TIMER
		price = 140,
		mana = 10,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 2

			c.spread_degrees = c.spread_degrees - 1.0

			add_projectile_trigger_timer( empty_path .. 'entities/projectiles/deck/rubber_ball.xml', 20, 1 )
		end,
	},
	{
		info = 'rubber_ball_death_trigger',
		related_projectiles	= { 'data/entities/projectiles/deck/rubber_ball.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,10', -- EMPTY_RUBBER_BALL_DEATH_TRIGGER
		spawn_probability					= '0.4,0.3,0.2,0.5', -- EMPTY_RUBBER_BALL_DEATH_TRIGGER
		price = 140,
		mana = 10,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 2

			c.spread_degrees = c.spread_degrees - 1.0

			add_projectile_trigger_death( empty_path .. 'entities/projectiles/deck/rubber_ball.xml', 1 )
		end,
	},
	{
		info = 'rubber_ball_trigger_2',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball_pink.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,6,10', -- EMPTY_RUBBER_BALL_TRIGGER_2
		spawn_probability					= '1,0.5,0.3,0.2,1', -- EMPTY_RUBBER_BALL_TRIGGER_2
		price = 220,
		mana = 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 4

			c.spread_degrees = c.spread_degrees - 2.0

			add_projectile_trigger_hit_world( empty_path .. 'entities/projectiles/deck/rubber_ball_pink.xml', 2 )
		end,
	},
	{
		info = 'rubber_ball_timer_2',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball_pink.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,2,3,6,10', -- EMPTY_RUBBER_BALL_TIMER_2
		spawn_probability					= '0.5,0.5,0.25,0.2,1', -- EMPTY_RUBBER_BALL_TIMER_2
		price = 220,
		mana = 15,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 4

			c.spread_degrees = c.spread_degrees - 2.0

			add_projectile_trigger_timer( empty_path .. 'entities/projectiles/deck/rubber_ball_pink.xml', 20, 2 )
		end,
	},
	{
		info = 'rubber_ball_trigger_timer',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball.xml', 'data/entities/projectiles/deck/rubber_ball_pink.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,10', -- EMPTY_RUBBER_BALL_TRIGGER_TIMER
		spawn_probability					= '0.4,0.3,0.2,1', -- EMPTY_RUBBER_BALL_TRIGGER_TIMER
		price = 300,
		mana = 20,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 6

			c.spread_degrees = c.spread_degrees - 3.0

			add_projectile_trigger_hit_world( empty_path .. 'entities/projectiles/deck/rubber_ball.xml', 1 )
			add_projectile_trigger_timer( empty_path .. 'entities/projectiles/deck/rubber_ball_pink.xml', 20, 1 )
		end,
	},
	{
		info = 'holy_orb',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/holy_orb.xml', 7 },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,3,4,5,6', -- EMPTY_HOLY_ORB
		spawn_probability				= '0.7,0.7,0.8,0.8,0.6', -- EMPTY_HOLY_ORB
		price = 220,
		mana = 20,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 12
			current_reload_time = current_reload_time + 25

			add_projectile( empty_path .. 'entities/projectiles/deck/holy_orb.xml' )
		end,
	},
	{
		info = 'ice_circle',
		series = {
			[ 'projectile_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/ice_circle.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,2,3,4,5', -- EMPTY_ICE_CIRCLE
		spawn_probability				= '0.2,0.5,1,0.5,0.2', -- EMPTY_ICE_CIRCLE
		price = 270,
		mana = 80,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 15
			current_reload_time = current_reload_time - 40

			add_projectile( empty_path .. 'entities/projectiles/deck/ice_circle.xml' )
		end,
	},
	{
		info = 'bloom_circle',
		series = {
			[ 'projectile_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/bloom_circle.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,2,3,4,5', -- EMPTY_BLOOM_CIRCLE
		spawn_probability				= '0.2,0.5,1,0.5,0.2', -- EMPTY_BLOOM_CIRCLE
		price = 280,
		mana = 90,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 15
			current_reload_time = current_reload_time - 40

			add_projectile( empty_path .. 'entities/projectiles/deck/bloom_circle.xml' )
		end,
	},
	{
		info = 'orb_timer_circle',
		series = {
			[ 'orb_timer' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/orb_timer_circle.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4,5,6,7,10', -- EMPTY_ORB_TIMER_CIRCLE
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1', -- EMPTY_ORB_TIMER_CIRCLE
		price = 320,
		mana = 240,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 60
			add_projectile( empty_path .. 'entities/projectiles/deck/orb_timer_circle.xml' )
		end,
	},
	{
		info = 'orb_timer_spiral',
		series = {
			[ 'orb_timer' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/orb_timer_spiral.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '0,1,2,3,4,5,6,7,10', -- EMPTY_ORB_TIMER_SPIRAL
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1', -- EMPTY_ORB_TIMER_SPIRAL
		price = 320,
		mana = 240,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 60
			add_projectile( empty_path .. 'entities/projectiles/deck/orb_timer_spiral.xml' )
		end,
	},--[[
	{
		info = 'colorful_rec_projectile_rubber_ball', -- TODO
		series = {
			[ 'colorful' ] = true,
			[ 'rec' ] = true,
			[ 'iter' ] = true,
		},
		related_projectiles		= { empty_path .. 'entities/projectiles/deck/colorful__projectile_.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,3,5,7', -- EMPTY_COLORFUL__PROJECTILE_
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COLORFUL__PROJECTILE_
		price = 160,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			--
		end
	},]]--
	{
		info = 'colorful_iter_projectile_buckshot',
		series = {
			[ 'colorful' ] = true,
			[ 'iter' ] = true,
			[ 'colorful_projectile' ] = true,
		},
		related_projectiles		= { empty_path .. 'entities/projectiles/colorful/iter_buckshot_alt.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '2,4,6,8', -- EMPTY_COLORFUL_ITER_PROJECTILE_BUCKSHOT
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COLORFUL_ITER_PROJECTILE_BUCKSHOT
		price = 160,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( reflecting ) then
				c.fire_rate_wait = c.fire_rate_wait + 3

				c.spread_degrees = c.spread_degrees + 5

				add_projectile( empty_path .. 'entities/projectiles/colorful/iter_buckshot_alt.xml' )
			else
				local iter, count = iteration, 0
				local has_iter = iter and iter > 0

				if ( has_iter ) then
					count = iter - 1
				else
					add_desc_by_info( c, true, false, {
						id = 'empty_colorful_iter_projectile_buckshot',
						count = 0,
					}, nil, '$' )
				end

				if ( count > 0 ) then
					c.fire_rate_wait = c.fire_rate_wait + 3 * count

					c.spread_degrees = c.spread_degrees + 5 * count * count

					for _ = 1, count, 1 do
						add_projectile( empty_path .. 'entities/projectiles/colorful/iter_buckshot.xml' )
					end

					add_desc_by_info( c, true, true, {
						id = 'empty_colorful_iter_projectile_buckshot',
						count = count,
					}, nil, '$' )
				end
			end
		end
	},
	{
		info = 'colorful_rec_iter_projectile_chainsaw',
		series = {
			[ 'colorful' ] = true,
			[ 'rec' ] = true,
			[ 'iter' ] = true,
			[ 'colorful_projectile' ] = true,
		},
		related_projectiles		= { empty_path .. 'entities/projectiles/colorful/rec_iter_chainsaw_alt.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '3,5,7,9', -- EMPTY_COLORFUL_REC_ITER_PROJECTILE_CHAINSAW
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COLORFUL_REC_ITER_PROJECTILE_CHAINSAW
		price = 160,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( reflecting ) then
				c.fire_rate_wait = 0
				current_reload_time = 0

				add_projectile( empty_path .. 'entities/projectiles/colorful/rec_iter_chainsaw_alt.xml' )
			else
				local rec, iter, count = recursion_level, iteration, 0
				local has_rec, has_iter = rec and rec > -1, iter and iter > 0

				if ( has_rec ) then
					c.fire_rate_wait = 0

					count = count + 3 * ( rec + 1 )
				end

				if ( has_iter ) then
					current_reload_time = 0

					count = count + iter
				end

				if ( has_rec and has_iter ) then
					mana = math.ceil( mana / 2 )
				end

				if ( ( not rec ) and ( not iter ) ) then
					add_desc_by_info( c, true, false, {
						id = 'empty_colorful_rec_iter_projectile_chainsaw',
						count = 0,
					}, nil, '$' )
				end

				if ( count > 0 ) then
					add_projectile( empty_path .. 'entities/projectiles/colorful/rec_iter_chainsaw.xml' )

					add_desc_by_info( c, true, true, {
						id = 'empty_colorful_rec_iter_projectile_chainsaw',
						count = count,
					}, nil, '$' )
				end
			end
		end
	},
	{
		info = 'colorful_rec_iter_projectile_hole',
		series = {
			[ 'colorful' ] = true,
			[ 'rec' ] = true,
			[ 'iter' ] = true,
			[ 'colorful_projectile' ] = true,
		},
		related_projectiles = { 'data/entities/projectiles/deck/bouncy_orb.xml' },
		type		= ACTION_TYPE_PROJECTILE,
		spawn_level						= '1,3,5,7,9', --EMPTY_COLORFUL_REC_ITER_PROJECTILE_HOLE
		spawn_probability				= '0.2,0.4,0.6,0.8,1', --EMPTY_COLORFUL_REC_ITER_PROJECTILE_HOLE
		price = 320,
		mana = 160,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( reflecting ) then
				add_projectile( 'data/entities/projectiles/deck/bouncy_orb.xml' )
			else
				local rec, iter, proj = recursion_level, iteration, nil
				local has_rec, has_iter = rec and rec > -1, iter and iter > 0

				if ( has_rec ) then
					if ( has_iter ) then
						proj = empty_path .. 'entities/projectiles/colorful/rec_iter_hole_white_' .. tostring( rec ) .. '.xml'
					else
						proj = empty_path .. 'entities/projectiles/colorful/rec_iter_hole_black_' .. tostring( rec ) .. '.xml'
					end
				else
					if ( has_iter ) then
						proj = 'data/entities/projectiles/deck/bullet_slow.xml'
					else
						proj = 'data/entities/projectiles/deck/bouncy_orb.xml'

						add_table( discarded, deck, false, true )
						add_table( discarded, hand, false, true )

						dont_draw_actions = true
					end
				end

				if ( proj and proj ~= '' ) then
					if ( has_rec ) then
						c.fire_rate_wait = c.fire_rate_wait + 60
					end

					if ( has_iter ) then
						current_reload_time = current_reload_time + 60
					end

					add_projectile( proj )
				end
			end
		end
	},
	{
		info = 'nuke_ray_line',
		series = {
			[ 'nuke' ] = true,
			[ 'ray_line' ] = true,
		},
		related_extra_entities = { empty_path .. 'entities/misc/nuke_ray_line.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5,6,10', -- EMPTY_NUKE_RAY_LINE
		spawn_probability				= '0.4,0.7,0.9,1,1,0.1', -- EMPTY_NUKE_RAY_LINE
		price = 500,
		mana = 400,
		max_uses = 2,
		action		= function ( )
			c.fire_rate_wait	= c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 60

			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/nuke_ray_line.xml,'

			draw_actions( 1,true )
		end,
	},
	{
		info = 'fire_rate_wait_increase_damage',
		series = {
			[ 'increase_damage' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5', -- EMPTY_FIRE_RATE_WAIT_INCREASE_DAMAGE
		spawn_probability				= '0.5,0.8,0.8,0.5', -- EMPTY_FIRE_RATE_WAIT_INCREASE_DAMAGE
		price = 120,
		mana = 25,
		action		= function ( )
			current_reload_time = current_reload_time + 60

			c.damage_drill_add = c.damage_drill_add + ( c.fire_rate_wait - 10 ) / get_scale( )

			draw_actions( 1, true )
		end,
	},
	{
		info = 'reload_time_increase_damage',
		series = {
			[ 'increase_damage' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5', -- EMPTY_RELOAD_TIME_INCREASE_DAMAGE
		spawn_probability				= '0.5,0.8,0.8,0.5', -- EMPTY_RELOAD_TIME_INCREASE_DAMAGE
		price = 120,
		mana = 25,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 60

			c.damage_slice_add = c.damage_slice_add + ( current_reload_time - 10 ) / get_scale( )

			draw_actions( 1, true )
		end,
	},
	{
		info = 'uses_increase_damage',
		series = {
			[ 'increase_damage' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5', -- EMPTY_USES_INCREASE_DAMAGE
		spawn_probability				= '0.5,0.8,0.8,0.5', -- EMPTY_USES_INCREASE_DAMAGE
		price = 120,
		mana = 25,
		action		= function ( )
			local sum, sum_max_uses, sum_uses_remaining = 0, 0, 0
			for _, data in ipairs( deck ) do
				if ( data.max_uses and data.uses_remaining and data.uses_remaining > -1 ) then
					sum_max_uses = sum_max_uses + data.max_uses
					sum_uses_remaining = sum_uses_remaining + data.uses_remaining
				end
			end

			if ( sum_max_uses > sum_uses_remaining ) then
				sum = sum_max_uses - sum_uses_remaining

				c.damage_ice_add = c.damage_ice_add + ( sum / get_scale( ) )
				c.fire_rate_wait = c.fire_rate_wait + 20
				current_reload_time = current_reload_time + 20
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'lifetime_infinite',
		series = {
			[ 'lifetime' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/lifetime_infinite.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '3,4,5,6,10', -- EMPTY_LIFETIME_INFINITE
		spawn_probability				= '0.5,0.5,0.5,0.5,1', -- EMPTY_LIFETIME_INFINITE
		price = 450,
		mana = 400,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/lifetime_infinite.xml',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 300

			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/lifetime_infinite.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'slow',
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3', -- EMPTY_SLOW
		spawn_probability				= '1,0.5,0.5', -- EMPTY_SLOW
		price = 100,
		mana = 3,
		action		= function ( )
			c.speed_multiplier = c.speed_multiplier * 0.4

			if ( c.speed_multiplier < 0 ) then
				c.speed_multiplier = 0
			end

			draw_actions( 1, true )
		end
	},
	{
		info = 'cast_at_0_speed',
		series = {
			[ 'remove' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3', -- EMPTY_CAST_AT_0_SPEED
		spawn_probability				= '1,0.5,0.5', -- EMPTY_CAST_AT_0_SPEED
		price = 100,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 20
			current_reload_time = current_reload_time - 20

			c.speed_multiplier = 0

			draw_actions( 1, true )
		end
	},
	{
		info = 'remove_gravity',
		series = {
			[ 'remove' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/remove_gravity.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5,6', -- EMPTY_REMOVE_GRAVITY
		spawn_probability				= '0.5,0.4,0.4,0.3,0.3', -- EMPTY_REMOVE_GRAVITY
		price = 50,
		mana = 1,
		action		= function ( )
			c.gravity = 0
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/remove_gravity.xml,'

			draw_actions( 1, true )
		end
	},
	{
		info = 'remove_air_friction',
		series = {
			[ 'remove' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/remove_air_friction.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5,6', -- EMPTY_REMOVE_AIR_FRICTION
		spawn_probability				= '0.5,0.4,0.4,0.3,0.3', -- EMPTY_REMOVE_AIR_FRICTION
		price = 50,
		mana = 1,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/remove_air_friction.xml,'

			draw_actions( 1, true )
		end
	},
	{
		info = 'remove_lua',
		series = {
			[ 'remove' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/remove_lua.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3,4,5,6,10', -- EMPTY_REMOVE_LUA
		spawn_probability				= '0.1,0.2,0.5,0.7,0.5,0.2,0.1', -- EMPTY_REMOVE_LUA
		price = 100,
		mana = 5,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/remove_lua.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'remove_self_damage',
		series = {
			[ 'remove' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/remove_self_damage.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '4,5,6,10', -- EMPTY_REMOVE_SELF_DAMAGE
		spawn_probability				= '0.5,0.8,0.8,0.5', -- EMPTY_REMOVE_SELF_DAMAGE
		price = 120,
		mana = 25,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/remove_self_damage.xml,'
			current_reload_time = current_reload_time + 180

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_projectile',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_projectile.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,2,3,4', -- EMPTY_DAMAGE_TO_PROJECTILE
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_PROJECTILE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_projectile.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_fire',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_fire.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,2,3,4', -- EMPTY_DAMAGE_TO_FIRE
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_FIRE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_fire.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_explosion',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_explosion.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,2,3,4', -- EMPTY_DAMAGE_TO_EXPLOSION
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_EXPLOSION
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_explosion.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_electricity',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_electricity.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4,5,6', -- EMPTY_DAMAGE_TO_ELECTRICITY
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_ELECTRICITY
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_electricity.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_ice',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_ice.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3,4,5', -- EMPTY_DAMAGE_TO_ICE
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_ICE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_ice.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_radioactive',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_radioactive.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3,4,5', -- EMPTY_DAMAGE_TO_RADIOACTIVE
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_RADIOACTIVE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_radioactive.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_poison',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_poison.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '6,7,8,9,10', -- EMPTY_DAMAGE_TO_POISON
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_POISON
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_poison.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_slice',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_slice.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,4,6,8,10', -- EMPTY_DAMAGE_TO_SLICE
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_SLICE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_slice.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_drill',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_drill.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,3,5,7,9', -- EMPTY_DAMAGE_TO_DRILL
		spawn_probability				= '0.1,0.2,0.4,0.2,0.1', -- EMPTY_DAMAGE_TO_DRILL
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_drill.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_melee',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_melee.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,2,9,10', -- EMPTY_DAMAGE_TO_MELEE
		spawn_probability				= '0.4,0.2,0.1,0.1,0.2', -- EMPTY_DAMAGE_TO_MELEE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_melee.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_physics_hit',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_physics_hit.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,8,9,10', -- EMPTY_DAMAGE_TO_PHYSICS_HIT
		spawn_probability				= '0.2,0.1,0.1,0.2,0.4', -- EMPTY_DAMAGE_TO_PHYSICS_HIT
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_physics_hit.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_curse',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_curse.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '8,9,10', -- EMPTY_DAMAGE_TO_CURSE
		spawn_probability				= '0.2,0.4,0.8', -- EMPTY_DAMAGE_TO_CURSE
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_curse.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_holy',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_holy.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,1,2', -- EMPTY_DAMAGE_TO_HOLY
		spawn_probability				= '0.8,0.4,0.2', -- EMPTY_DAMAGE_TO_HOLY
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_holy.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'damage_to_healing',
		series = {
			[ 'damage_to' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/damage_to_healing.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '0,10', -- EMPTY_DAMAGE_TO_HEALING
		spawn_probability				= '0.5,0.5', -- EMPTY_DAMAGE_TO_HEALING
		price = 300,
		mana = 50,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/damage_to_healing.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'wall_trail',
		series = {
			[ 'trail' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/wall_trail.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,2,3,5,8', -- EMPTY_WALL_TRAIL
		spawn_probability				= '0.1,0.2,0.3,0.5,0.8', -- EMPTY_WALL_TRAIL
		price = 160,
		mana = 60,
		action		= function ()
			c.fire_rate_wait = c.fire_rate_wait - 40
			current_reload_time = current_reload_time - 80

			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/wall_trail.xml,'

			draw_actions( 1, true )
		end,
	},
	{
		info = 'blood_trail',
		series = {
			[ 'trail' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4', -- EMPTY_BLOOD_TRAIL
		spawn_probability				= '0.3,0.3,0.3', -- EMPTY_BLOOD_TRAIL
		price = 150,
		mana = 15,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/blood_trail.xml',
		action		= function ( )
			c.game_effect_entities = c.game_effect_entities .. 'data/entities/misc/effect_apply_bloody.xml,'
			c.trail_material = c.trail_material .. 'blood,'
			c.trail_material_amount = c.trail_material_amount + 20

			draw_actions( 1, true )
		end,
	},
	{
		info = 'urine_trail',
		series = {
			[ 'trail' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,3,4', -- EMPTY_URINE_TRAIL
		spawn_probability				= '0.3,0.3,0.3', -- EMPTY_URINE_TRAIL
		price = 160,
		mana = 15,
		custom_xml_file = empty_path .. 'entities/misc/custom_cards/urine_trail.xml',
		action		= function ( )
			c.game_effect_entities = c.game_effect_entities .. empty_path .. 'entities/misc/effect_apply_urine.xml,'
			c.trail_material = c.trail_material .. 'urine,'
			c.trail_material_amount = c.trail_material_amount + 20

			draw_actions( 1, true )
		end,
	},
	{
		info = 'hitfx_critical_urine',
		series = {
			[ 'hitfx_critical' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/hitfx_critical_urine.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,3,4,5', -- EMPTY_HITFX_CRITICAL_URINE
		spawn_probability				= '0.2,0.2,0.4,0.2', -- EMPTY_HITFX_CRITICAL_URINE
		price = 60,
		mana = 10,
		action		= function ( )
			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/hitfx_critical_urine.xml,'

			draw_actions( 1, true )
		end
	},
	{
		info = 'colorful_rec_modifier_complex',
		series = {
			[ 'colorful' ] = true,
			[ 'rec' ] = true,
			[ 'colorful_modifier' ] = true,
		},
		related_extra_entities	= { 'data/entities/misc/nolla.xml' },
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '1,3,5,7,9', -- EMPTY_COLORFUL_REC_MODIFIER_COMPLEX
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5', -- EMPTY_COLORFUL_REC_MODIFIER_COMPLEX
		price = 300,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( reflecting ) then
				c.fire_rate_wait = c.fire_rate_wait - 20
				current_reload_time = current_reload_time + 40

				c.extra_entities = c.extra_entities .. 'data/entities/misc/nolla.xml,'

				draw_actions( 1, true )
			else
				local rec, iter = recursion_level, iteration
				local has_rec, has_iter = rec and rec > -1, iter and iter > 0

				if ( has_rec ) then
					c.fire_rate_wait = c.fire_rate_wait + 40
					current_reload_time = current_reload_time - 20

					c.lifetime_add = c.lifetime_add + 120

					if ( rec == 0 ) then
						c.extra_entities = c.extra_entities .. 'data/entities/misc/piercing_shot.xml,'
					end

					if ( rec == 1 ) then
						c.extra_entities = c.extra_entities .. 'data/entities/misc/clipping_shot.xml,'
					end

					if ( rec == 2 ) then
						c.extra_entities = c.extra_entities .. 'data/entities/misc/homing.xml,'
					end
				else
					c.fire_rate_wait = c.fire_rate_wait - 20
					current_reload_time = current_reload_time + 40

					c.extra_entities = 'data/entities/misc/nolla.xml,'
				end

				draw_actions( 1, true )
			end
		end
	},--[[
	{
		info = 'colorful_iter_modifier_damage',
		series = {
			[ 'colorful' ] = true,
			[ 'rec' ] = true,
			[ 'iter' ] = true,
			[ 'colorful_modifier' ] = true,
		},
		type		= ACTION_TYPE_MODIFIER,
		spawn_level						= '2,4,6,8,10', -- EMPTY_COLORFUL_ITER_MODIFIER_DAMAGE
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5', -- EMPTY_COLORFUL_ITER_MODIFIER_DAMAGE
		price = 300,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( reflecting ) then
				--
			else
				local rec, iter = recursion_level, iteration
				local has_rec, has_iter = rec and rec > -1, iter and iter > 0

				--
			end
		end
	},]]--
	{
		info = 'material_urine',
		series = {
			[ 'material' ] = true,
		},
		related_projectiles = { empty_path .. 'entities/projectiles/deck/material_urine.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5', -- EMPTY_MATERIAL_URINE
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4', -- EMPTY_MATERIAL_URINE
		price = 150,
		mana = 0,
		sound_loop_tag = 'sound_spray',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10

			c.game_effect_entities = c.game_effect_entities .. empty_path .. 'entities/misc/effect_apply_urine.xml,'

			add_projectile( empty_path .. 'entities/projectiles/deck/material_urine.xml' )
		end
	},
	{
		info = 'material_lava',
		series = {
			[ 'material' ] = true,
		},
		related_projectiles = { empty_path .. 'entities/projectiles/deck/material_lava.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5', -- EMPTY_MATERIAL_LAVA
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4', -- EMPTY_MATERIAL_LAVA
		price = 160,
		mana = 0,
		sound_loop_tag = 'sound_spray',
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10

			c.game_effect_entities = c.game_effect_entities .. 'data/entities/misc/effect_apply_on_fire.xml,'

			add_projectile( empty_path .. 'entities/projectiles/deck/material_lava.xml' )
		end
	},
	{
		info = 'chunk_of_cement',
		series = {
			[ 'chunk_of' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/chunk_of_cement.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,5', -- EMPTY_CEMENTBALL
		spawn_probability				= '0.8,0.8,1,0.75', -- EMPTY_CEMENTBALL
		price = 10,
		mana = 5,
		action		= function ( )
			add_projectile( empty_path .. 'entities/projectiles/chunk_of_cement.xml' )
		end,
	},
	{
		info = 'chunk_of_gunpowder',
		series = {
			[ 'chunk_of' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/chunk_of_gunpowder.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,5', -- EMPTY_GUNPOWDERBALL
		spawn_probability				= '0.8,0.8,1,0.75', -- EMPTY_GUNPOWDERBALL
		price = 10,
		mana = 5,
		action		= function ( )
			add_projectile( empty_path .. 'entities/projectiles/chunk_of_gunpowder.xml' )
		end,
	},
	{
		info = 'circle_rainbow',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_rainbow.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_RAINBOW
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_RAINBOW
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_rainbow.xml' )
		end,
	},
	{
		info = 'circle_blood',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_blood.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_BLOOD
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_BLOOD
		price = 160,
		mana = 40,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_blood.xml' )
		end,
	},
	{
		info = 'circle_radioactive',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_radioactive.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_RADIOACTIVE
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_RADIOACTIVE
		price = 180,
		mana = 50,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_radioactive.xml' )
		end,
	},
	{
		info = 'circle_freeze',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_freeze.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_FREEZE
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_FREEZE
		price = 200,
		mana = 60,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_freeze.xml' )
		end,
	},
	{
		info = 'circle_lava',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_lava.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_LAVA
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_LAVA
		price = 200,
		mana = 60,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_lava.xml' )
		end,
	},
	{
		info = 'circle_void',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_void.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_VOID
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_VOID
		price = 220,
		mana = 100,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_void.xml' )
		end,
	},
	{
		info = 'circle_invisible',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_invisible.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_INVISIBLE
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_INVISIBLE
		price = 250,
		mana = 150,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_invisible.xml' )
		end,
	},
	{
		info = 'circle_pheromone',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_pheromone.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '5,6,7,10', -- EMPTY_CIRCLE_PHEROMONE
		spawn_probability				= '0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_PHEROMONE
		price = 480,
		mana = 160,
		max_uses = 1,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 120

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_pheromone.xml' )
		end,
	},
	{
		info = 'circle_berserk',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_berserk.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_BERSERK
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_BERSERK
		price = 320,
		mana = 240,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_berserk.xml' )
		end,
	},
	{
		info = 'circle_teleport',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_teleport.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_TELEPORT
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_TELEPORT
		price = 300,
		mana = 200,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_teleport.xml' )
		end,
	},
	{
		info = 'circle_weak',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_weak.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '3,4,5,6,7,10', -- EMPTY_CIRCLE_WEAK
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_WEAK
		price = 320,
		mana = 240,
		max_uses = 3,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 10

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_weak.xml' )
		end,
	},
	{
		info = 'circle_ominous',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_ominous.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '3,4,5,6,7,10', -- EMPTY_CIRCLE_OMINOUS
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_OMINOUS
		price = 360,
		mana = 250,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_ominous.xml' )
		end,
	},
	{
		info = 'circle_polymorph',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_polymorph.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '5,6,7,10', -- EMPTY_CIRCLE_POLYMORPH
		spawn_probability				= '0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_POLYMORPH
		price = 450,
		mana = 400,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_polymorph.xml' )
		end,
	},
	{
		info = 'circle_molten_gold',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_molten_gold.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '5,6,7,10', -- EMPTY_CIRCLE_MOLTEN_GOLD
		spawn_probability				= '0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_MOLTEN_GOLD
		price = 450,
		mana = 500,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_molten_gold.xml' )
		end,
	},
	{
		info = 'circle_creepy',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_creepy.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_CREEPY
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_CREEPY
		price = 500,
		mana = 300,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_creepy.xml' )
		end,
	},
	{
		info = 'circle_monster_powder',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_monster_powder.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '5,6,7,10', -- EMPTY_CIRCLE_MONSTER_POWDER
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_CIRCLE_MONSTER_POWDER
		price = 800,
		mana = 1000,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 60

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_monster_powder.xml' )
		end,
	},
	{
		info = 'circle_hp_regeneration',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_polymorph.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '4,5,6,7,8,9,10', -- EMPTY_CIRCLE_HP_REGENERATION
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5,0.7,1', -- EMPTY_CIRCLE_HP_REGENERATION
		price = 1200,
		mana = 1200,
		max_uses = 1,
		never_unlimited = true,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 120

			if ( copy_series == nil and copy_specific == nil and recursion_level == nil and iteration == nil )
				or ( copy_series[ 'ori_random' ] and copy_specific == 'spell' )
				or ( copy_series[ 'ori_greek_letter' ] and copy_specific == 'zeta' )
				or ( copy_series[ 'greek_letter-' ] and copy_specific == 'omega' )
			then
				add_projectile( empty_path .. 'entities/projectiles/deck/circle_hp_regeneration.xml' )
			else
				if ( copy_series[ 'random' ] or copy_series[ 'copy_all' ] ) then
					add_projectile( empty_path .. 'entities/projectiles/deck/circle_creepy.xml' )
				elseif ( copy_series[ 'greek_letter' ] ) then
					add_projectile( empty_path .. 'entities/projectiles/deck/circle_monster_powder.xml' )
				elseif ( copy_series[ 'divide' ] ) then
					add_projectile( empty_path .. 'entities/projectiles/deck/circle_ominous.xml' )
				else
					add_projectile( empty_path .. 'entities/projectiles/deck/circle_just_death.xml' )
				end
			end
		end,
	},
	{
		info = 'circle_just_death',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_just_death.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '5,6,7,8,9,10', -- EMPTY_CIRCLE_JUST_DEATH
		spawn_probability				= '0.1,0.1,0.2,0.3,0.4,0.5', -- EMPTY_CIRCLE_JUST_DEATH
		price = 600,
		mana = 600,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 180

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_just_death.xml' )
		end,
	},
	{
		info = 'circle_empty',
		series = {
			[ 'material_circle' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_empty.xml' },
		type		= ACTION_TYPE_MATERIAL,
		spawn_level						= '1,2,3,4,5,6', -- EMPTY_CIRCLE_EMPTY
		spawn_probability				= '0.4,0.4,0.4,0.4,0.4,0.4', -- EMPTY_CIRCLE_EMPTY
		price = 600,
		mana = 0,
		max_uses = 1,
		never_unlimited = true,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 40

			add_projectile( empty_path .. 'entities/projectiles/deck/circle_empty.xml' )
		end,
	},
	{
		info = 'deck_to_power',
		series = {
			[ 'increase_damage' ] = true,
		},
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '6,10', -- EMPTY_DECK_TO_POWER
		spawn_probability				= '0.1,0.5', -- EMPTY_DECK_TO_POWER
		price = 180,
		mana = 90,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 60

			local count = #deck

			if ( count > 0 ) then
				local damage_add = ( ( count + 1 ) * ( count + 1 ) ) / get_scale( )
				c.damage_curse_add = c.damage_curse_add + damage_add

				add_table( discarded, deck, false, true )
				add_table_1( discarded, deck )
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'spell_recharge',
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '3,4,5,6,10', -- EMPTY_SPELL_RECHARGE
		spawn_probability				= '1,0.9,0.8,0.5,0.2', -- EMPTY_SPELL_RECHARGE
		price = 500,
		mana = 160,
		max_uses = 6,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 120
			current_reload_time = current_reload_time + 120

			local deck_before = { }

			add_table( deck_before, deck, false, false )
			add_table( deck, hand, false, false )
			add_table( deck, discarded, false, false )

			for _, data in ipairs( deck ) do
				if ( data.uses_remaining > -1 and data.max_uses and data.uses_remaining < data.max_uses ) and ( data.id ~= 'EMPTY_SPELL_RECHARGE' ) then
					data.uses_remaining = data.uses_remaining + 1
					ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
				end
			end

			add_table( deck, deck_before, true, true )
		end,
	},
	{
		info = 'gold_magic',
		related_extra_entities = { empty_path .. 'data/entities/particles/gold_sparks.xml,' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '0,1,2,3,4,5', -- EMPTY_GOLD_MAGIC
		spawn_probability				= '0.1,0.3,0.4,0.4,0.3,0.1', -- EMPTY_GOLD_MAGIC
		price = 50,
		mana = -50,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 10
			current_reload_time = current_reload_time - 10

			c.extra_entities = c.extra_entities .. 'data/entities/particles/gold_sparks.xml,'

			local entity_id = GetUpdatedEntityID( )
			local gold_comp = EntityGetFirstComponent( entity_id, 'WalletComponent' )
			if ( gold_comp ) then
				local money = ComponentGetValue2( gold_comp, 'money' )
				local moneyspent = ComponentGetValue2( gold_comp, 'money_spent' )
				if ( money > 0 ) then
					local variable_num = money
					money = math.max( money - 2, 0 )
					variable_num = variable_num - money
					moneyspent = moneyspent + variable_num
					ComponentSetValue2( gold_comp, 'money', money )
					ComponentSetValue2( gold_comp, 'money_spent', moneyspent )
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'all_giga_blackhole',
		series = {
			[ 'all' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_alchemy',
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '6,7,8,9,10', -- EMPTY_ALL_GIGA_BLACKHOLE
		spawn_probability				= '0.2,0.4,0.6,0.8,1', -- EMPTY_ALL_GIGA_BLACKHOLE
		price = 400,
		mana = 400,
		max_uses = 2,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 40

			add_projectile( empty_path .. 'entities/projectiles/deck/all_giga_blackhole.xml' )
		end,
	},
	{
		info = 'all_giga_whitehole',
		series = {
			[ 'all' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_alchemy',
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '6,7,8,9,10', -- EMPTY_ALL_GIGA_WHITEHOLE
		spawn_probability				= '0.2,0.4,0.6,0.8,1', -- EMPTY_ALL_GIGA_WHITEHOLE
		price = 400,
		mana = 400,
		max_uses = 2,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 40

			add_projectile( empty_path .. 'entities/projectiles/deck/all_giga_whitehole.xml' )
		end,
	},
	{
		info = 'all_empty',
		series = {
			[ 'all' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_alchemy',
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '6,7,8,9,10', -- EMPTY_ALL_EMPTY
		spawn_probability				= '0.2,0.4,0.6,0.8,1', -- EMPTY_ALL_EMPTY
		price = 500,
		mana = 500,
		max_uses = 1,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 60

			add_projectile( empty_path .. 'entities/projectiles/deck/all_empty.xml' )
		end,
	},
	{
		info = 'cursor_homing',
		series = {
			[ 'cursor' ] = true,
			[ 'homing' ] = true,
		},
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/cursor_homing.xml' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '3,4,6,10', -- EMPTY_CURSOR_HOMING
		spawn_probability				= '0.4,0.4,0.4,0.5', -- EMPTY_CURSOR_HOMING
		price = 500,
		mana = 200,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/cursor_homing.xml' )
		end,
	},
	{
		info = 'cursor_teleport',
		series = {
			[ 'cursor' ] = true,
			[ 'teleport' ] = true,
		},
		related_projectiles = { empty_path .. 'entities/projectiles/deck/cursor_teleport.xml' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '4,5,6,10', -- EMPTY_CURSOR_TELEPORT
		spawn_probability				= '0.1,0.2,0.3,0.5', -- EMPTY_CURSOR_TELEPORT
		price = 500,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 20

			add_projectile( empty_path .. 'entities/projectiles/deck/cursor_teleport.xml' )
		end,
	},
	{
		info = 'cursor_cast',
		series = {
			[ 'cursor' ] = true,
		},
		related_extra_entities	= { empty_path .. 'entities/misc/cursor_cast.xml' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '10', -- EMPTY_CURSOR_CAST
		spawn_probability				= '0.2', -- EMPTY_CURSOR_CAST
		price = 600,
		mana = 360,
		max_uses = 3,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time - 40

			c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/cursor_cast.xml,'
		end,
	},
	{
		info = 'create_potion',
		related_projectiles	= { 'data/entities/items/pickup/potion.xml' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '4,5,6,10', -- EMPTY_CREATE_POTION
		spawn_probability				= '0.4,0.4,0.4,0.5', -- EMPTY_CREATE_POTION
		price = 600,
		mana = 300,
		max_uses = 3,
		never_unlimited = true,
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait + 120
			current_reload_time = current_reload_time + 120

			add_projectile( 'data/entities/items/pickup/potion.xml' )
		end,
	},
	{
		info = 'summon_sell_hole',
		series = {
			[ 'summon' ] = true,
		},
		related_projectiles = { empty_path .. 'entities/buildings/sell_hole.xml' },
		type		= ACTION_TYPE_UTILITY,
		spawn_level						= '2,3,5,10', -- EMPTY_SUMMON_SELL_HOLE
		spawn_probability				= '0.1,0.15,0.25,0.5', -- EMPTY_SUMMON_SELL_HOLE
		price = 720,
		mana = 300,
		max_uses = 1,
		never_unlimited = true,
		action		= function ( )
			local sell_holes = EntityGetWithTag( 'empty_sell_hole' )

			if ( #sell_holes < 1 ) then
				c.fire_rate_wait = c.fire_rate_wait + 60
				current_reload_time = current_reload_time + 60

				add_projectile( empty_path .. 'entities/buildings/sell_hole.xml' )
			end
		end
	},
	{
		info = 'discard_magic_queue',
		series = {
			[ 'discard_magic' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '1,2,4,5,10', -- EMPTY_DISCARD_MAGIC_QUEUE
		spawn_probability				= '0.1,0.2,0.4,0.5,0.3', -- EMPTY_DISCARD_MAGIC_QUEUE
		price = 50,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.damage_electricity_add = c.damage_electricity_add + #hand * 0.04

			if ( #hand > 0 ) then
				add_table_1( hand, discarded )
			end
		end,
	},
	{
		info = 'discard_magic_stack',
		series = {
			[ 'discard_magic' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '1,2,4,5,10', -- EMPTY_DISCARD_MAGIC_STACK
		spawn_probability				= '0.1,0.2,0.4,0.5,0.3', -- EMPTY_DISCARD_MAGIC_STACK
		price = 50,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.damage_fire_add = c.damage_fire_add + #hand * 0.04

			if ( #hand > 0 ) then
				add_table_1( hand, discarded, #hand )
			end
		end,
	},
	{
		info = 'discard_magic_self',
		series = {
			[ 'discard_magic' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '0,1,2,3,4,5,6,7,8,9,10', -- EMPTY_DISCARD_MAGIC_SELF
		spawn_probability				= '0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1', -- EMPTY_DISCARD_MAGIC_SELF
		price = 50,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.damage_ice_add = c.damage_ice_add + #hand * 0.04

			if ( #hand > 0 and hand[ #hand ].id == 'EMPTY_DISCARD_MAGIC_SELF' ) then
				add_table_1( hand, discarded, #hand )
			end
		end,
	},
	{
		info = 'swap_life_and_death',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '0,1,2,3,4,5,6,7,8,9,10', -- EMPTY_SWAP_LIFE_AND_DEATH
		spawn_probability				= '0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1', -- EMPTY_SWAP_LIFE_AND_DEATH
		price = 300,
		mana = 50,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			current_reload_time = current_reload_time + 30

			local temp, count = { }, math.abs( #deck - #discarded )

			add_table( temp, deck, false, false )
			add_table( deck, discarded, true, true )
			add_table( discarded, temp, true, true )

			if ( count > 0 ) then
				draw_actions( count, true )
			end
		end,
	},
	{
		info = 'x2',
		series = {
			[ 'ori' ] = true,
			[ 'copy_all' ] = true,
			[ 'ori_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_X2
		spawn_probability				= '0.4,0.7,1', -- EMPTY_X2
		price = 250,
		mana = 250,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 20

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }
			add_table( copy_list, hand, false, false )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data.id ~= 'EMPTY_DEPARTURE' and data.id ~= 'RESET' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'copy_all' ] = true,
						[ 'ori_copy_all' ] = true,
					}, 'x2' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			draw_actions( 1, true )
		end,
	},
	{
		info = 'arrival',
		series = {
			[ 'ori' ] = true,
			[ 'copy_all' ] = true,
			[ 'ori_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_ARRIVAL
		spawn_probability				= '0.4,0.7,1', -- EMPTY_ARRIVAL
		price = 250,
		mana = 250,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 20

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }
			add_table( copy_list, deck, false, false )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data.id ~= 'EMPTY_ARRIVAL' and data.id ~= 'RESET' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'copy_all' ] = true,
						[ 'ori_copy_all' ] = true,
					}, 'arrival' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			draw_actions( 1, true )
		end,
	},
	{
		info = 'departure',
		series = {
			[ 'ori' ] = true,
			[ 'copy_all' ] = true,
			[ 'ori_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_DEPARTURE
		spawn_probability				= '0.4,0.7,1', -- EMPTY_DEPARTURE
		price = 250,
		mana = 250,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 20

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }
			add_table( copy_list, discarded, false, false )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data.id ~= 'EMPTY_DEPARTURE' and data.id ~= 'RESET' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'copy_all' ] = true,
						[ 'ori_copy_all' ] = true,
					}, 'departure' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			draw_actions( 1, true )
		end,
	},
	{
		info = 'return',
		series = {
			[ 'ori' ] = true,
			[ 'copy_all' ] = true,
			[ 'ori_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '6,7,8,9,10', -- EMPTY_RETURN
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5', -- EMPTY_RETURN
		price = 270,
		mana = 270,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 30

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local count = #hand
			add_table( discarded, hand, false, true )

			draw_actions( count, true )

			local copy_list = { }
			add_table( copy_list, hand, false, false )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data.id ~= 'EMPTY_RETURN' and data.id ~= 'RESET' ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'copy_all' ] = true,
						[ 'ori_copy_all' ] = true,
					}, 'return' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			draw_actions( 1, true )
		end,
	},
	{
		info = 'triphase_reincarnation',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '6,7,10', -- EMPTY_TRIPHASE_REINCARNATION
		spawn_probability				= '0.2,0.5,1', -- EMPTY_TRIPHASE_REINCARNATION
		price = 360,
		mana = 360,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( triphase_reincarnation_check ) then
				add_table( discarded, hand, false, true )
				add_table( discarded, deck, false, true )

				force_stop_draws = true
			else
				triphase_reincarnation_check = true

				local count = #hand

				if ( count > 0 ) then
					current_reload_time = current_reload_time + 30

					add_table( discarded, hand, false, true )

					if ( count > 0 ) then
						add_table_count( discarded, deck, count )

						draw_actions( count, true )
					end
				end
			end
		end,
	},
	{
		info = 'alpha+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_ALPHA+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_ALPHA+
		price = 200,
		mana = 40,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			local data = nil

			for _ = 1, #copy_list, 1 do
				local each = copy_list [ _ ]
				if ( each.id ~= 'EMPTY_ALPHA-' and each.id ~= 'EMPTY_ALPHA+' and each.id ~= 'RESET' ) then
					data = each

					break
				end
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'greek_letter' ] = true,
					[ '+' ] = true,
					[ 'greek_letter+' ] = true,
				}, 'alpha' )
			end
		end,
	},
	{
		info = 'gamma+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_GAMMA+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_GAMMA+
		price = 200,
		mana = 40,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			local data = nil

			for _ = #copy_list, 1, -1 do
				local each = copy_list[ _ ]
				if ( each.id ~= 'EMPTY_GAMMA-' and each.id ~= 'EMPTY_GAMMA+' and each.id ~= 'RESET' ) then
					data = each

					break
				end
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'greek_letter' ] = true,
					[ '+' ] = true,
					[ 'greek_letter+' ] = true,
				}, 'gamma' )
			end
		end,
	},
	{
		info = 'tau+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_TAU+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_TAU+
		price = 200,
		mana = 90,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 35

			local copy_list = { }

			if ( #deck > 0 ) then
				table.insert( copy_list, deck [ 1 ] )
				if ( #deck > 1 ) then
					table.insert( copy_list, deck [ 2 ] )
				else
					table.insert( copy_list, deck [ 1 ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'tau' )
				end
			end
		end,
	},
	{
		info = 'omega+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_OMEGA+
		spawn_probability				= '0.1,0.1,1', -- EMPTY_OMEGA+
		price = 600,
		mana = 320,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.id ~= 'EMPTY_OMEGA-' and data.id ~= 'EMPTY_OMEGA+' and data.id ~= 'RESET' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'omega' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'mu+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_MU+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_MU+
		price = 500,
		mana = 120,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_MODIFIER ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'mu' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'phi+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_PHI+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_PHI+
		price = 500,
		mana = 120,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_PROJECTILE ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'phi' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'sigma+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '4,5,10', -- EMPTY_SIGMA+
		spawn_probability				= '0.1,0.2,1', -- EMPTY_SIGMA+
		price = 500,
		mana = 120,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 30

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_STATIC_PROJECTILE ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'sigma' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'zeta+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		spawn_manual_unlock = true,
		recursive	= true,
		spawn_level						= '2,5,10', -- EMPTY_ZETA+
		spawn_probability				= '0.2,0.4,0.5', -- EMPTY_ZETA+
		price = 200,
		mana = 10,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local entity_id = GetUpdatedEntityID( )
			local x, y = EntityGetTransform( entity_id )
			local wand_index = nil
			local options = { }

			local children = EntityGetAllChildren( entity_id )
			local inventory = EntityGetFirstComponent( entity_id, 'Inventory2Component' )

			if ( inventory ) then
				local active_wand = ComponentGetValue2( inventory, 'mActiveItem' )

				for i, child_id in ipairs( children or {} ) do
					if ( EntityGetName( child_id ) == 'inventory_quick' ) then
						local wands = EntityGetAllChildren( child_id )
						for _, wand in ipairs( wands or {} ) do
							if ( wand == active_wand ) then
								wand_index = _
							else
							local spells = EntityGetAllChildren( wand )
								local temp_spell = { }
								for j, spell in ipairs( spells or {} ) do

									local comp = EntityGetFirstComponentIncludingDisabled( spell, 'ItemActionComponent' )
									if ( comp ) then
										local action_id = ComponentGetValue2( comp, 'action_id' )

										if ( action_id ~= 'EMPTY_ZETA-' and action_id ~= 'EMPTY_ZETA+' and action_id ~= 'RESET' ) then
											table.insert( temp_spell, action_id )
										end
									end
								end

								if ( #temp_spell > 0 ) then
									if ( _ == 1 ) or ( _ == wand_index + 1 ) then
										add_table( options, temp_spell ,true, true )
									end
								end
							end
						end
					end
				end
			end

			if ( #options > 0 ) then
				local a, b, c = time_for_vec3( )
				SetRandomSeed( x + a - c, y + b - c )

				local rnd = Random( 1, #options )
				local action_id = options [ rnd ]

				for _, data in ipairs( actions ) do
					if ( data.id == action_id ) then
						local rec = check_recursion( data, recursion_level )
						if ( rec > -1 ) then
							dont_draw_actions = true

							data.action( rec, nil, {
								[ 'greek_letter' ] = true,
								[ '+' ] = true,
								[ 'greek_letter+' ] = true,
							}, 'zeta' )

							dont_draw_actions = false
						end
						break
					end
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'beta+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '0,2,4,6', -- EMPTY_BETA+
		spawn_probability				= '0.1,0.3,0.5,0.4', -- EMPTY_BETA+
		price = 160,
		mana = 80,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 45

			local copy_list = { }

			if ( #hand > 1 ) then
				for _ = 2, #hand, 2 do
					table.insert( copy_list, hand[ _ ] )
				end
			end
			if ( #deck > 0 ) then
				for _ = 1, #deck, 2 do
					table.insert( copy_list, deck[ _ ] )
				end
			end
			if ( #discarded > 0 ) then
				for _ = 1, #discarded, 2 do
					table.insert( copy_list, discarded[ _ ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) and ( data.id ~= 'EMPTY_BETA+' and data.id ~= 'EMPTY_BETA-' and data.id ~= 'RESET' ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'beta' )
				end
			end
		end,
	},
	{
		info = 'lambda+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '3,4,5,6', -- EMPTY_LAMBDA+
		spawn_probability				= '0.3,0.4,0.5,0.6', -- EMPTY_LAMBDA+
		price = 200,
		mana = 160,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 45

			local copy_list = { }

			if ( #hand > 0 ) then
				table.insert( copy_list, hand [ 1 ] )

				if ( #hand > 1 ) then
					table.insert( copy_list, hand [ 2 ] )
				else
					table.insert( copy_list, hand [ 1 ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'lambda' )
				end
			end
		end,
	},
	{
		info = 'chi+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_CHI+
		spawn_probability				= '0.1,0.3,1', -- EMPTY_CHI+
		price = 500,
		mana = 120,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= 'RESET' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'chi' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'theta+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_THETA+
		spawn_probability				= '0.1,0.3,1', -- EMPTY_THETA+
		price = 500,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait - 60
			current_reload_time = current_reload_time - 120

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'theta' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'omicron+',
		series = {
			[ 'greek_letter' ] = true,
			[ '+' ] = true,
			[ 'greek_letter+' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_OMICRON+
		spawn_probability				= '0.1,0.3,1', -- EMPTY_OMICRON+
		price = 500,
		mana = 120,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 60

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			add_table( copy_list, deck, false, false )
			add_table( copy_list, hand, false, false )
			add_table( copy_list, discarded, false, false )

			loc_sort( copy_list )

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == ACTION_TYPE_OTHER ) and ( data.id ~= 'EMPTY_OMICRON-' and data.id ~= 'EMPTY_OMICRON+' ) and ( rec > -1 ) then
					dont_draw_actions = true

					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '+' ] = true,
						[ 'greek_letter+' ] = true,
					}, 'omicron' )
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'alpha-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_ALPHA-
		spawn_probability				= '0.1,0.2,1', -- EMPTY_ALPHA-
		price = 100,
		mana = 20,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 5

			local data = nil

			for _ = 1, #deck, 1 do
				local each = deck [ _ ]
				if ( each.id ~= 'EMPTY_ALPHA-' and each.id ~= 'EMPTY_ALPHA+' and each.id ~= 'RESET' ) then
					data = each

					break
				end
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'greek_letter' ] = true,
					[ '-' ] = true,
					[ 'greek_letter-' ] = true,
				}, 'alpha' )
			end
		end,
	},
	{
		info = 'gamma-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_GAMMA-
		spawn_probability				= '0.1,0.2,1', -- EMPTY_GAMMA-
		price = 100,
		mana = 20,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 5

			local data = nil

			for _ = #discarded, 1, -1 do
				local each = discarded [ _ ]
				if ( each.id ~= 'EMPTY_GAMMA-' and each.id ~= 'EMPTY_GAMMA+' and each.id ~= 'RESET' ) then
					data = each

					break
				end
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'greek_letter' ] = true,
					[ '-' ] = true,
					[ 'greek_letter-' ] = true,
				}, 'gamma' )
			end
		end,
	},
	{
		info = 'tau-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_TAU-
		spawn_probability				= '0.1,0.2,1', -- EMPTY_TAU-
		price = 100,
		mana = 45,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 12

			local copy_list = { }

			if ( #discarded > 0 ) then
				table.insert( copy_list, discarded [ #discarded ] )

				if ( #discarded > 1 ) then
					table.insert( copy_list, discarded [ # discarded - 1 ] )
				else
					table.insert( copy_list, discarded [ #discarded ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '-' ] = true,
						[ 'greek_letter-' ] = true,
					}, 'tau' )
				end
			end
		end,
	},
	{
		info = 'omega-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_OMEGA-
		spawn_probability				= '0.1,0.1,1', -- EMPTY_OMEGA-
		price = 300,
		mana = 160,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 17

			local copy_list = { }

			local entity = GetUpdatedEntityID( )
			local children = EntityGetAllChildren( entity )
			local inventory = EntityGetFirstComponent( entity, 'Inventory2Component' )

			if ( inventory ) then
				for i, child_id in ipairs( children or {} ) do
					if ( EntityGetName( child_id ) == 'inventory_quick' ) then
						local wands = EntityGetAllChildren( child_id )
						for _, wand in ipairs( wands or {} ) do
							local spells = EntityGetAllChildren( wand )
							for j, spell in ipairs( spells or {} ) do
								local comp = EntityGetFirstComponentIncludingDisabled( spell, 'ItemActionComponent' )
								if ( comp ) then
									local action_id = ComponentGetValue2( comp, 'action_id' )

									table.insert( copy_list, action_id )
								end
							end
						end
					end
				end
			end

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			for i, action_id in ipairs( copy_list or {} ) do
				for j, data in ipairs( actions ) do
					if ( action_id == data.id ) then
						if not ( data.recursive ) then
							dont_draw_actions = true

							data.action( nil, nil, {
								[ 'greek_letter' ] = true,
								[ '-' ] = true,
								[ 'greek_letter-' ] = true,
							}, 'omega' )
						end

						break
					end
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			if ( #copy_list > 0 ) then
				draw_actions( #copy_list, true )
			end
		end,
	},
	{
		info = 'mu-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_MU-
		spawn_probability				= '0.1,0.2,1', -- EMPTY_MU-
		price = 250,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 17

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			if ( #discarded > 0 ) then
				add_table( copy_list, discarded, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MODIFIER ) and ( rec > -1 ) then
						dont_draw_actions = false

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'mu' )
					end
				end
			end

			if ( #deck > 0 ) then
				add_table( copy_list, deck, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MODIFIER ) and ( rec > -1 ) then
						dont_draw_actions = false

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'mu' )
					end
				end
			end

			if ( #hand > 0 ) then
				add_table( copy_list, hand, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MODIFIER ) and ( rec > -1 ) then
						dont_draw_actions = false

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'mu' )
					end
				end
			end

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
		end,
	},
	{
		info = 'zeta-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		spawn_manual_unlock = true,
		recursive	= true,
		spawn_level						= '2,5,10', -- EMPTY_ZETA-
		spawn_probability				= '0.2,0.4,0.5', -- EMPTY_ZETA-
		price = 100,
		mana = 5,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local entity_id = GetUpdatedEntityID( )
			local x, y = EntityGetTransform( entity_id )
			local wand_index = nil
			local options = { }

			local children = EntityGetAllChildren( entity_id )
			local inventory = EntityGetFirstComponent( entity_id, 'Inventory2Component' )

			if ( inventory ) then
				local active_wand = ComponentGetValue2( inventory, 'mActiveItem' )

				for i, child_id in ipairs( children or {} ) do
					if ( EntityGetName( child_id ) == 'inventory_quick' ) then
						local wands = EntityGetAllChildren( child_id )
						for _, wand in ipairs( wands or {} ) do
							if ( wand == active_wand ) then
								local spells = EntityGetAllChildren( wand )
								local temp_spell = { }
								for j, spell in ipairs( spells or {} ) do

									local comp = EntityGetFirstComponentIncludingDisabled( spell, 'ItemActionComponent' )
									if ( comp ) then
										local action_id = ComponentGetValue2( comp, 'action_id' )

										if ( action_id ~= 'EMPTY_ZETA-' and action_id ~= 'EMPTY_ZETA+' and action_id ~= 'RESET' ) then
											table.insert( temp_spell, action_id )
										end
									end
								end

								if ( #temp_spell > 0 ) then
									if ( _ == 1 ) or ( _ == wand_index + 1 ) then
										add_table( options, temp_spell ,true, true )
									end
								end
							end
						end
					end
				end
			end

			if ( #options > 0 ) then
				local a, b, c = time_for_vec3( )
				SetRandomSeed( x + a - c, y + b - c )

				local rnd = Random( 1, #options )
				local action_id = options [ rnd ]

				for _, data in ipairs( actions ) do
					if ( data.id == action_id ) then
						local rec = check_recursion( data, recursion_level )
						if ( rec > -1 ) then
							local already_ban_draw = dont_draw_actions
							if not ( already_ban_draw ) then
								dont_draw_actions = true
							end

							data.action( rec, nil, {
								[ 'greek_letter' ] = true,
								[ '-' ] = true,
								[ 'greek_letter-' ] = true,
							}, 'zeta' )

							if not ( already_ban_draw ) then
								dont_draw_actions = false
							end
						end
						break
					end
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'beta-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '1,3,5,7', -- EMPTY_BETA-
		spawn_probability				= '0.1,0.3,0.5,0.4', -- EMPTY_BETA-
		price = 160,
		mana = 40,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local copy_list = { }

			if ( #hand > 0 ) then
				for _ = 1, #hand, 2 do
					table.insert( copy_list, hand[ _ ] )
				end
			end
			if ( #deck > 1 ) then
				for _ = 2, #deck, 2 do
					table.insert( copy_list, deck[ _ ] )
				end
			end
			if ( #discarded > 1 ) then
				for _ = 2, #discarded, 2 do
					table.insert( copy_list, discarded[ _ ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) and ( data.id ~= 'EMPTY_BETA+' and data.id ~= 'EMPTY_BETA-' and data.id ~= 'RESET' ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '-' ] = true,
						[ 'greek_letter-' ] = true,
					}, 'beta' )
				end
			end
		end,
	},
	{
		info = 'lambda-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_duplicate',
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '3,4,5,6', -- EMPTY_LAMBDA-
		spawn_probability				= '0.3,0.4,0.5,0.6', -- EMPTY_LAMBDA-
		price = 100,
		mana = 80,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local copy_list = { }

			if ( #hand > 0 ) then
				table.insert( copy_list, hand [ #hand ] )

				if ( #hand > 1 ) then
					table.insert( copy_list, hand [ # hand - 1 ] )
				else
					table.insert( copy_list, hand [ #hand ] )
				end
			end

			for _, data in ipairs( copy_list ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'greek_letter' ] = true,
						[ '-' ] = true,
						[ 'greek_letter-' ] = true,
					}, 'lambda' )
				end
			end
		end,
	},
	{
		info = 'chi-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_CHI-
		spawn_probability				= '0.1,0.3,1', -- EMPTY_CHI-
		price = 500,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 17

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }

			if ( #discarded > 0 ) then
				add_table( copy_list, discarded, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'chi' )
					end
				end
			end

			if ( #deck > 0 ) then
				add_table( copy_list, deck, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'chi' )
					end
				end
			end

			if ( #hand > 0 ) then
				add_table( copy_list, hand, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'chi' )
					end
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			loc_shuffle( deck )
			loc_shuffle( hand )
			loc_shuffle( discarded )
		end,
	},
	{
		info = 'theta-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_THETA-
		spawn_probability				= '0.1,0.3,1', -- EMPTY_THETA-
		price = 500,
		mana = 30,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait - 180
			current_reload_time = current_reload_time - 360

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }
			local count = 0

			if ( #discarded > 0 ) then
				add_table( copy_list, discarded, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'theta' )

						count = count + 1
					end
				end
			end

			if ( #deck > 0 ) then
				add_table( copy_list, deck, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'theta' )

						count = count + 1
					end
				end
			end

			if ( #hand > 0 ) then
				add_table( copy_list, hand, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'theta' )

						count = count + 1
					end
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			if ( count > 0 ) then
				draw_actions( count, true )
			end
		end,
	},
	{
		info = 'omicron-',
		series = {
			[ 'greek_letter' ] = true,
			[ '-' ] = true,
			[ 'greek_letter-' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '5,6,10', -- EMPTY_OMICRON-
		spawn_probability				= '0.1,0.3,1', -- EMPTY_OMICRON-
		price = 500,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20

			local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana

			local copy_list = { }
			local count = 0

			if ( #discarded > 0 ) then
				add_table( copy_list, discarded, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_OTHER ) and ( data.id ~= 'EMPTY_OMICRON-' and data.id ~= 'EMPTY_OMICRON+' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( 2, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'omicron' )

						count = count + 1
					end
				end
			end

			if ( #deck > 0 ) then
				add_table( copy_list, deck, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_OTHER ) and ( data.id ~= 'EMPTY_OMICRON-' and data.id ~= 'EMPTY_OMICRON+' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( 2, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'omicron' )

						count = count + 1
					end
				end
			end

			if ( #hand > 0 ) then
				add_table( copy_list, hand, true, false )
				for _ = #copy_list, 1 -1 do
					local data = copy_list[ _ ]
					local rec = check_recursion( data, recursion_level )
					if ( data ) and ( data.type == ACTION_TYPE_OTHER ) and ( data.id ~= 'EMPTY_OMICRON-' and data.id ~= 'EMPTY_OMICRON+' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( 2, nil, {
							[ 'greek_letter' ] = true,
							[ '-' ] = true,
							[ 'greek_letter-' ] = true,
						}, 'omicron' )

						count = count + 1
					end
				end
			end

			dont_draw_actions = false

			c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

			if ( count > 0 ) then
				count = math.min( count, #hand )

				add_table_count( hand, discarded, count )
			end
		end,
	},
	{
		info = 'divide_2+',
		series = {
			[ 'divide' ] = true,
			[ '+' ] = true,
			[ 'divide+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '3,5,6,10', -- EMPTY_DIVIDE_2+
		spawn_probability				= '0.2,0.3,0.2,1', -- EMPTY_DIVIDE_2+
		price = 200,
		mana = 35,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( iter <= #deck ) then
				data = deck [ iter ]
			else
				return iter_max
			end

			local count = 2
			if ( iter > 5 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
				local firerate, reload = c.fire_rate_wait, current_reload_time

				for _ = 1, count, 1 do
					dont_draw_actions = true

					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( nil, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '2' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '2' )
					end

					if ( imax ) then
						iter_max = imax
					end
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time = firerate, reload

				if ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if ( not reduce_uses ) then
						data.uses_remaining = data.uses_remaining + 1
					end
				end

				if ( iter == 1 ) then
					add_table_count( deck, discarded, iter_max )

					draw_actions( 1, true )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.2
			c.explosion_radius = math.max( c.explosion_radius - 5.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_3+',
		series = {
			[ 'divide' ] = true,
			[ '+' ] = true,
			[ 'divide+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '4,5,6,10', -- EMPTY_DIVIDE_3+
		spawn_probability				= '0.1,0.1,0.2,1', -- EMPTY_DIVIDE_3+
		price = 250,
		mana = 50,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 35

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( iter <= #deck ) then
				data = deck [ iter ]
			else
				return iter_max
			end

			local count = 3
			if ( iter > 4 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
				local firerate, reload = c.fire_rate_wait, current_reload_time

				for _ = 1, count, 1 do
					dont_draw_actions = true

					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( nil, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '3' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '3' )
					end

					if ( imax ) then
						iter_max = imax
					end
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time = firerate, reload

				if ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if ( not reduce_uses ) then
						data.uses_remaining = data.uses_remaining + 1
					end
				end

				if ( iter == 1 ) then
					add_table_count( deck, discarded, iter_max )

					draw_actions( 1, true )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.4
			c.explosion_radius = math.max( c.explosion_radius - 10.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_4+',
		series = {
			[ 'divide' ] = true,
			[ '+' ] = true,
			[ 'divide+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '5,6,10', -- EMPTY_DIVIDE_4+
		spawn_probability				= '0.1,0.1,1', -- EMPTY_DIVIDE_4+
		price = 300,
		mana = 70,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( iter <= #deck ) then
				data = deck [ iter ]
			else
				return iter_max
			end

			local count = 4
			if ( iter > 3 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
				local firerate, reload = c.fire_rate_wait, current_reload_time

				for _ = 1, count, 1 do
					dont_draw_actions = true

					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( nil, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '4' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '4' )
					end

					if ( imax ) then
						iter_max = imax
					end
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time = firerate, reload

				if ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if ( not reduce_uses ) then
						data.uses_remaining = data.uses_remaining + 1
					end
				end

				if ( iter == 1 ) then
					add_table_count( deck, discarded, iter_max )

					draw_actions( 1, true )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.6
			c.explosion_radius = math.max( c.explosion_radius - 20.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_10+',
		series = {
			[ 'divide' ] = true,
			[ '+' ] = true,
			[ 'divide+' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_divide',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '10', -- EMPTY_DIVIDE_10+
		spawn_probability				= '1', -- EMPTY_DIVIDE_10+
		price = 400,
		mana = 200,
		max_uses = 5,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 80
			current_reload_time = current_reload_time + 20

			local data = { }

			local iter = iteration or 1
			local iter_max = iter

			if ( iter <= #deck ) then
				data = deck [ iter ]
			else
				return iter_max
			end

			local count = 10
			if ( iter > 2 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
				local firerate, reload = c.fire_rate_wait, current_reload_time

				for _ = 1, count, 1 do
					dont_draw_actions = true

					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( nil, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '10' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '+' ] = true,
							[ 'divide+' ] = true,
						}, '10' )
					end

					if ( imax ) then
						iter_max = imax
					end
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time = firerate, reload

				if ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if ( not reduce_uses ) then
						data.uses_remaining = data.uses_remaining + 1
					end
				end

				if ( iter == 1 ) then
					add_table_count( deck, discarded, iter_max )

					draw_actions( 1, true )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 1.5
			c.explosion_radius = math.max( c.explosion_radius - 40.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_2-',
		series = {
			[ 'divide' ] = true,
			[ '-' ] = true,
			[ 'divide-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '3,5,6,10', -- EMPTY_DIVIDE_2-
		spawn_probability				= '0.2,0.3,0.2,1', -- EMPTY_DIVIDE_2-
		price = 100,
		mana = 18,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 10

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			local count = 2
			if ( iter > 7 ) then
				count = 1
			end

			local firerate, reload = c.fire_rate_wait, current_reload_time

			for _ = 1, count do
				if ( iter <= #deck ) then
					data = deck [ iter ]
				else
					return iter_max
				end

				local rec = check_recursion( data, recursion_level )

				if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( 2, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '2' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '2' )
					end

					if ( imax ) then
						iter_max = imax
					end

					if ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if ( not reduce_uses ) then
							data.uses_remaining = data.uses_remaining + 1
						end
					end

					if ( iter == 1 ) then
						add_table_count( deck, discarded, iter_max )
					end
				end
			end

			c.fire_rate_wait, current_reload_time = firerate, reload

			c.damage_projectile_add = c.damage_projectile_add - 0.1
			c.explosion_radius = math.max( c.explosion_radius - 2.5, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_3-',
		series = {
			[ 'divide' ] = true,
			[ '-' ] = true,
			[ 'divide-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '4,5,6,10', -- EMPTY_DIVIDE_3-
		spawn_probability				= '0.1,0.1,0.2,1', -- EMPTY_DIVIDE_3-
		price = 125,
		mana = 25,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 18

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			local count = 3
			if ( iter > 5 ) then
				count = 1
			end

			local firerate, reload = c.fire_rate_wait, current_reload_time

			for _ = 1, count do
				if ( iter <= #deck ) then
					data = deck [ iter ]
				else
					return iter_max
				end

				local rec = check_recursion( data, recursion_level )

				if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( 2, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '3' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '3' )
					end

					if ( imax ) then
						iter_max = imax
					end

					if ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if ( not reduce_uses ) then
							data.uses_remaining = data.uses_remaining + 1
						end
					end

					if ( iter == 1 ) then
						add_table_count( deck, discarded, iter_max )
					end
				end
			end

			c.fire_rate_wait, current_reload_time = firerate, reload

			c.damage_projectile_add = c.damage_projectile_add - 0.2
			c.explosion_radius = math.max( c.explosion_radius - 5.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_4-',
		series = {
			[ 'divide' ] = true,
			[ '-' ] = true,
			[ 'divide-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_musicbox',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '5,6,10', -- EMPTY_DIVIDE_4-
		spawn_probability				= '0.1,0.1,1', -- EMPTY_DIVIDE_4-
		price = 150,
		mana = 35,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 25

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			local count = 4
			if ( iter > 4 ) then
				count = 1
			end

			local firerate, reload = c.fire_rate_wait, current_reload_time

			for _ = 1, count do
				if ( iter <= #deck ) then
					data = deck [ iter ]
				else
					return iter_max
				end

				local rec = check_recursion( data, recursion_level )

				if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( 2, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '4' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '4' )
					end

					if ( imax ) then
						iter_max = imax
					end

					if ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if ( not reduce_uses ) then
							data.uses_remaining = data.uses_remaining + 1
						end
					end

					if ( iter == 1 ) then
						add_table_count( deck, discarded, iter_max )
					end
				end
			end

			c.fire_rate_wait, current_reload_time = firerate, reload

			c.damage_projectile_add = c.damage_projectile_add - 0.3
			c.explosion_radius = math.max( c.explosion_radius - 10.0, 0 )

			return iter_max
		end,
	},
	{
		info = 'divide_10-',
		series = {
			[ 'divide' ] = true,
			[ '-' ] = true,
			[ 'divide-' ] = true,
		},
		spawn_requires_flag = 'card_unlocked_divide',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '10', -- EMPTY_DIVIDE_10-
		spawn_probability				= '1', -- EMPTY_DIVIDE_10-
		price = 200,
		mana = 100,
		max_uses = 10,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 10

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			local count = 10
			if ( iter > 3 ) then
				count = 1
			end

			local firerate, reload = c.fire_rate_wait, current_reload_time

			for _ = 1, count do
				if ( iter <= #deck ) then
					data = deck [ iter ]
				else
					return iter_max
				end

				local rec = check_recursion( data, recursion_level )

				if ( data ) and ( rec > -1 ) and ( data.uses_remaining ~= 0 ) then
					local imax = nil

					if ( data.series and data.series[ 'colorful' ] ) then
						imax = data.action( 2, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '10' )
					else
						imax = data.action( rec, iter + 1, {
							[ 'divide' ] = true,
							[ '-' ] = true,
							[ 'divide-' ] = true,
						}, '10' )
					end

					if ( imax ) then
						iter_max = imax
					end

					if ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if ( not reduce_uses ) then
							data.uses_remaining = data.uses_remaining + 1
						end
					end

					if ( iter == 1 ) then
						add_table_count( deck, discarded, iter_max )
					end
				end
			end

			c.fire_rate_wait, current_reload_time = firerate, reload

			c.damage_projectile_add = c.damage_projectile_add - 0.75
			c.explosion_radius = math.max( c.explosion_radius - 20.0, 0 )

			return iter_max
		end,
	},
	-- GameHasFlagRun( 'essence_fire' )
	-- GameHasFlagRun( 'essence_air' )
	-- GameHasFlagRun( 'essence_water' )
	-- GameHasFlagRun( 'essence_laser' )
	--[[
	{
		info = 'midas',
		type		= ACTION_TYPE_OTHER,
		spawn_level						= '10', -- EMPTY_MIDAS
		spawn_probability				= '0.01', -- EMPTY_MIDAS
		price = 5000,
		mana = 3000,
		max_uses = 1,
		never_unlimited = true,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			if ( copy_series == nil ) then
				local orb_count = GameGetOrbCountThisRun( )
				local newgame_orbs_required = get_ng_num( ) + 4
				GameAddFlagRun( 'ending_game_completed' )
				GameOnCompleted( )

				if ( orb_count >= 33 ) then
					AddFlagPersistent( 'secret_amulet' )
					if ( orb_count > 33 ) then
						GameAddFlagRun( 'ending_game_completed_with_34_orbs' )
					end
					local players = EntityGetWithTag( 'player_unit' )
					local x, y = 782, -1150
					for _, each_player in ipairs( players ) do
						EntityApplyTransform( each_player, x, y )
					end

					EntityLoad( 'data/entities/particles/image_emitters/magical_symbol_fast.xml', x, y )
					AddFlagPersistent( 'progress_ending2' )
					GamePlaySound( 'data/audio/Desktop/event_cues.bank', 'event_cues/happy_ending/create', x, y )
					GameDoEnding2( )
				elseif ( orb_count > newgame_orbs_required ) then
					--
				else
					local x, y = EntityGetTransform( GetUpdatedEntityID( ) )
					EntityLoad( 'data/entities/particles/image_emitters/magical_symbol_fast.xml', x, y )
				end
			else
				add_projectile( empty_path .. 'entities/projectiles/deck/circle_monster_powder.xml' )
			end
		end
	},]]--
	{
		info = 'command_number_hex',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '0x',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_HEX
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_HEX
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 16, current_reload_time - 16

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_0',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '0',
		spawn_level						= '0,10', -- EMPTY_COMMAND_NUMBER_0
		spawn_probability				= '0.1,0.1', -- EMPTY_COMMAND_NUMBER_0
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = current_reload_time, c.fire_rate_wait

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_1',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '1',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_1
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_1
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 1, current_reload_time - 1

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_2',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '2',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_2
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_2
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 2, current_reload_time - 2

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_3',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '3',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_3
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_3
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 3, current_reload_time - 3

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_4',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '4',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_4
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_4
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 4, current_reload_time - 4

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_5',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '5',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_5
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_5
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 5, current_reload_time - 5

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_6',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '6',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_6
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_6
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 6, current_reload_time - 6

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_7',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '7',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_7
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_7
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 7, current_reload_time - 7

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_8',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '8',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_8
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_8
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 8, current_reload_time - 8

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_9',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = '9',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_9
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_9
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 9, current_reload_time - 9

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_a',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'a',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_A
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_A
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 10, current_reload_time - 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_b',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'b',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_B
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_B
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 11, current_reload_time - 11

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_c',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'c',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_C
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_C
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 12, current_reload_time - 12

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_d',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'd',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_D
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_D
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 13, current_reload_time - 13

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_e',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'e',
		spawn_level						= '0,2,4,6,10', -- EMPTY_COMMAND_NUMBER_E
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_E
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 14, current_reload_time - 14

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_number_f',
		series = {
			[ 'command' ] = true,
			[ 'number' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'NUMBER',
		command_value = 'f',
		spawn_level						= '0,1,3,5,7', -- EMPTY_COMMAND_NUMBER_F
		spawn_probability				= '0.1,0.2,0.3,0.4,0.6', -- EMPTY_COMMAND_NUMBER_F
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = c.fire_rate_wait - 15, current_reload_time - 15

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@self',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@self',
		spawn_level						= '0,1,2,3', -- EMPTY_COMMAND_SELECTOR_@SELF
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SELECTOR_@SELF
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 5

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@closest',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@closest',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_SELECTOR_@CLOSEST
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SELECTOR_@CLOSEST
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@random',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@random',
		spawn_level						= '0,1,2,3,4,5', -- EMPTY_COMMAND_SELECTOR_@RANDOM
		spawn_probability				= '0.1,0.2,0.3,0.4,0.3,0.2', -- EMPTY_COMMAND_SELECTOR_@RANDOM
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 30

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@players',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@players',
		spawn_level						= '1,2,3,4', -- EMPTY_COMMAND_SELECTOR_@PLAYERS
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SELECTOR_@PLAYERS
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@enemies',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@enemies',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_SELECTOR_@ENEMIES
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SELECTOR_@ENEMIES
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@bosses',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@bosses',
		spawn_level						= '10', -- EMPTY_COMMAND_SELECTOR_@BOSSES
		spawn_probability				= '0.1', -- EMPTY_COMMAND_SELECTOR_@BOSSES
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 20

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@projectiles',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@projectiles',
		spawn_level						= '3,4,5,6', -- EMPTY_COMMAND_SELECTOR_@PROJECTILES
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SELECTOR_@PROJECTILES
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@wands',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@wands',
		spawn_level						= '1,3,5,7,9', -- EMPTY_COMMAND_SELECTOR_@WANDS
		spawn_probability				= '0.2,0.2,0.2,0.2,0.2', -- EMPTY_COMMAND_SELECTOR_@WANDS
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@potions',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@potions',
		spawn_level						= '2,4,6,8,10', -- EMPTY_COMMAND_SELECTOR_@POTIONS
		spawn_probability				= '0.2,0.2,0.2,0.2,0.2', -- EMPTY_COMMAND_SELECTOR_@POTIONS
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 15

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@items',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@items',
		spawn_level						= '10', -- EMPTY_COMMAND_SELECTOR_@ITEMS
		spawn_probability				= '0.5', -- EMPTY_COMMAND_SELECTOR_@ITEMS
		price = 10,
		mana = 0,
		action		= function ( )
			mana = mana + 10

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@chunk_len',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@chunk_len',
		spawn_level						= '0,3,6,9', -- EMPTY_COMMAND_SELECTOR_@CHUNK_LEN
		spawn_probability				= '0.1,0.2,0.3,0.2', -- EMPTY_COMMAND_SELECTOR_@CHUNK_LEN
		price = 10,
		mana = 0,
		action		= function ( )
			add_table( discarded, hand, false, true )

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@world_len',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@world_len',
		spawn_level						= '0,5,10', -- EMPTY_COMMAND_SELECTOR_@WORLD_LEN
		spawn_probability				= '0.1,0.2,0.3', -- EMPTY_COMMAND_SELECTOR_@WORLD_LEN
		price = 10,
		mana = 0,
		action		= function ( )
			add_table( discarded, deck, false, true )

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_@entities',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '@entities',
		spawn_level						= '0,1,2,3,4,5,6,7,8,9,10', -- EMPTY_COMMAND_SELECTOR_@ENTITIES
		spawn_probability				= '1,1,1,1,1,1,1,1,1,1,1', -- EMPTY_COMMAND_SELECTOR_@ENTITIES
		price = 10,
		mana = 0,
		action		= function ( )
			mana = 0

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_selector_~',
		series = {
			[ 'command' ] = true,
			[ 'selector' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SELECTOR',
		command_value = '~',
		spawn_level						= '6,7,8,9,10', -- EMPTY_COMMAND_SELECTOR_~
		spawn_probability				= '0.2,0.4,0.6,0.8,1', -- EMPTY_COMMAND_SELECTOR_~
		price = 10,
		mana = 0,
		action		= function ( )
			reverse_table( deck, true )
			reverse_table( hand, true )
			reverse_table( discarded, true )

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_operator_add',
		series = {
			[ 'command' ] = true,
			[ 'operator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'OPERATOR',
		command_value = '+',
		spawn_level						= '1,3,5,7', -- EMPTY_COMMAND_OPERATOR_ADD
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_OPERATOR_ADD
		price = 10,
		mana = 0,
		action		= function ( )
			local delay = c.fire_rate_wait + current_reload_time
			c.fire_rate_wait, current_reload_time = delay, delay
			draw_actions( 1, true )
		end
	},
	{
		info = 'command_operator_minus',
		series = {
			[ 'command' ] = true,
			[ 'operator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'OPERATOR',
		command_value = '-',
		spawn_level						= '0,2,4,6', -- EMPTY_COMMAND_OPERATOR_MINUS
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_OPERATOR_MINUS
		price = 10,
		mana = 0,
		action		= function ( )
			local delay = current_reload_time - c.fire_rate_wait

			c.fire_rate_wait, current_reload_time = delay, -delay

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_operator_multi',
		series = {
			[ 'command' ] = true,
			[ 'operator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'OPERATOR',
		command_value = '*',
		spawn_level						= '6,7,8,9,10', -- EMPTY_COMMAND_OPERATOR_MULTI
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_OPERATOR_MULTI
		price = 10,
		mana = 0,
		action		= function ( )
			local delay = c.fire_rate_wait * current_reload_time

			c.fire_rate_wait, current_reload_time = delay, delay

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_operator_divide',
		series = {
			[ 'command' ] = true,
			[ 'operator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'OPERATOR',
		command_value = '/',
		spawn_level						= '1,2,3,4,5', -- EMPTY_COMMAND_OPERATOR_DIVIDE
		spawn_probability				= '0.5,0.4,0.3,0.2,0.1', -- EMPTY_COMMAND_OPERATOR_DIVIDE
		price = 10,
		mana = 0,
		action		= function ( )
			local delay1, delay2 = 0, 0

			if ( c.fire_rate_wait == 0 ) then
				delay1 = current_reload_time
			else
				delay1 = math.ceil( current_reload_time / c.fire_rate_wait )
			end
			if ( current_reload_time == 0 ) then
				delay2 = c.fire_rate_wait
			else
				delay2 = math.ceil( c.fire_rate_wait / current_reload_time )
			end

			c.fire_rate_wait, current_reload_time = delay1, delay2

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_separator_comma',
		series = {
			[ 'command' ] = true,
			[ 'separator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SEPARATOR',
		command_value = ',',
		spawn_level						= '1,3,5,7', -- EMPTY_COMMAND_SEPARATOR_,
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SEPARATOR_,
		price = 10,
		mana = 0,
		action		= function ( )
			mana = 60

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_separator_right_parenthesis',
		series = {
			[ 'command' ] = true,
			[ 'separator' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'SEPARATOR',
		command_value = ')',
		spawn_level						= '0,2,4,6', -- EMPTY_COMMAND_SEPARATOR_RIGHT_PARENTHESIS
		spawn_probability				= '0.1,0.2,0.3,0.4', -- EMPTY_COMMAND_SEPARATOR_RIGHT_PARENTHESIS
		price = 10,
		mana = 0,
		action		= function ( )
			c.fire_rate_wait, current_reload_time = 60, 60

			draw_actions( 1, true )
		end
	},
	{
		info = 'command_function_random_get',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'random_get(',
		spawn_level						= '6,7,8,9,10', -- EMPTY_COMMAND_FUNCTION_RANDOM_GET
		spawn_probability				= '0.1,0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_RANDOM_GET
		price = 160,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'random_get', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'random_get' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'random_get(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_get_first',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'get_first(',
		spawn_level						= '1,2,3', -- EMPTY_COMMAND_FUNCTION_GET_FIRST
		spawn_probability				= '0.1,0.2,0.3', -- EMPTY_COMMAND_FUNCTION_GET_FIRST
		price = 240,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'get_first', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'get_first' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				elseif ( #paras == 2 ) then
					empty_command_functions[ 'get_first' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'get_first(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_get_last',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'get_last(',
		spawn_level						= '1,2,3', -- EMPTY_COMMAND_FUNCTION_GET_LAST
		spawn_probability				= '0.1,0.2,0.3', -- EMPTY_COMMAND_FUNCTION_GET_LAST
		price = 240,
		mana = 0,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'get_last', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'get_last' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				elseif ( #paras == 2 ) then
					empty_command_functions[ 'get_last' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'get_last(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_variable_get',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'variable_get(',
		spawn_level						= '0,1,2,3,4', -- EMPTY_COMMAND_FUNCTION_VARIABLE_GET
		spawn_probability				= '0.1,0.1,0.2,0.2,0.3', -- EMPTY_COMMAND_FUNCTION_VARIABLE_GET
		price = 80,
		mana = 40,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'variable_get', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'variable_get' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'variable_get(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_variable_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'variable_set(',
		spawn_level						= '1,2,3,4,5', -- EMPTY_COMMAND_FUNCTION_VARIABLE_SET
		spawn_probability				= '0.1,0.1,0.2,0.2,0.3', -- EMPTY_COMMAND_FUNCTION_VARIABLE_SET
		price = 120,
		mana = 60,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'variable_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 2 ) then
					empty_command_functions[ 'variable_set' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'variable_set(', '$empty_command_error_lack_paras', '2', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_lifetime_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'lifetime_set(',
		spawn_level						= '7,8,9,10', -- EMPTY_COMMAND_FUNCTION_LIFETIME_SET
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_LIFETIME_SET
		price = 500,
		mana = 0,
		max_uses	= 3,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'lifetime_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					if ( paras[ 1 ] == -1 ) then
						mana = mana - 500
					else
						mana = mana - paras[ 1 ]
					end

					empty_command_functions[ 'lifetime_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'lifetime_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_lifetime_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_lifetime_set(',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_LIFETIME_SET
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_LIFETIME_SET
		price = 500,
		mana = 0,
		max_uses	= 10,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_lifetime_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					if ( paras[ 1 ] == -1 ) then
						mana = mana - 300
					else
						mana = mana - paras[ 1 ]
					end

					empty_command_functions[ 'projectile_lifetime_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'projectile_lifetime_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_speed_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_speed_set(',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_SPEED_SET
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_SPEED_SET
		price = 500,
		mana = 10,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_speed_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_speed_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'projectile_speed_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_gravity_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_gravity_set(',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_GRAVITY_SET
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_GRAVITY_SET
		price = 500,
		mana = 10,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_gravity_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_gravity_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				elseif ( #paras == 2 ) then
					empty_command_functions[ 'projectile_gravity_set' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'projectile_gravity_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_air_friction_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_air_friction_set(',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_AIR_FRICTION_SET
		spawn_probability				= '0.2,0.3,0.4,0.5', -- EMPTY_COMMAND_FUNCTION_PROJECTILE_AIR_FRICTION_SET
		price = 500,
		mana = 5,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_air_friction_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_air_friction_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'projectile_air_friction_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_shoot_angle_add',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_shoot_angle_add(',
		spawn_level						= '7,8,9,10', --EMPTY_COMMAND_FUNCTION_PROJECTILE_SHOOT_ANGLE_ADD
		spawn_probability				= '0.7,0.8,0.9,1', --EMPTY_COMMAND_FUNCTION_PROJECTILE_SHOOT_ANGLE_ADD
		price = 500,
		mana = 15,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_shoot_angle_add', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_shoot_angle_add' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'projectile_shoot_angle_add(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_shoot_angle_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_shoot_angle_set(',
		spawn_level						= '7,8,9,10', --EMPTY_COMMAND_FUNCTION_PROJECTILE_SHOOT_ANGLE_SET
		spawn_probability				= '0.7,0.8,0.9,1', --EMPTY_COMMAND_FUNCTION_PROJECTILE_SHOOT_ANGLE_SET
		price = 500,
		mana = 15,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_shoot_angle_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_shoot_angle_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				else
					command_print( 'projectile_shoot_angle_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	--[[
	{},
	]]--
	{
		info = 'command_function_projectile_arc_add',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_arc_add(',
		spawn_level						= '10', --EMPTY_COMMAND_FUNCTION_PROJECTILE_ARC_ADD
		spawn_probability				= '0.3', --EMPTY_COMMAND_FUNCTION_PROJECTILE_ARC_ADD
		price = 500,
		mana = 125,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_arc_add', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_arc_add' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				elseif ( #paras == 2 ) then
					empty_command_functions[ 'projectile_arc_add' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'projectile_arc_add(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_projectile_arc_set',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'projectile_arc_set(',
		spawn_level						= '10', --EMPTY_COMMAND_FUNCTION_PROJECTILE_ARC_SET
		spawn_probability				= '0.3', --EMPTY_COMMAND_FUNCTION_PROJECTILE_ARC_SET
		price = 500,
		mana = 125,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'projectile_arc_set', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 1 ) then
					empty_command_functions[ 'projectile_arc_set' ].action_1_paras( c, false, shooter, paras[ 1 ] )
				elseif ( #paras == 2 ) then
					empty_command_functions[ 'projectile_arc_set' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				else
					command_print( 'projectile_arc_set(', '$empty_command_error_lack_paras', '1', to_string( #paras ) )
					return
				end

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end

				draw_actions( 1, true )
			end
		end
	},
	{
		info = 'command_function_explode',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'explode(',
		spawn_level						= '4,5,6,7', -- EMPTY_COMMAND_FUNCTION_EXPLODE
		spawn_probability				= '0.2,0.3,0.3,0.2', -- EMPTY_COMMAND_FUNCTION_EXPLODE
		price = 120,
		mana = 120,
		max_uses	= 6,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'explode', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 2 ) then
					empty_command_functions[ 'explode' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				elseif ( #paras == 3 ) then
					empty_command_functions[ 'explode' ].action_3_paras( c, false, shooter, paras[ 1 ], paras[ 2 ], paras[ 3 ] )
				else
					command_print( 'explode(', '$empty_command_error_lack_paras', '2', to_string( #paras ) )
					return
				end

				add_projectile( empty_path .. 'entities/projectiles/command/explode_with_lua.xml' )

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'command_function_tp',
		series = {
			[ 'command' ] = true,
			[ 'function' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		command_type = 'FUNCTION',
		command_value = 'tp(',
		spawn_level						= '8,9,10', -- EMPTY_COMMAND_FUNCTION_TP
		spawn_probability				= '0.1,0.2,0.5', -- EMPTY_COMMAND_FUNCTION_TP
		price = 360,
		mana = 360,
		max_uses	= 3,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local shooter = GetUpdatedEntityID( )
			local tar_x, tar_y = EntityGetTransform( shooter )
			local paras, command_count, is_correct = from_table_get_paras( c, 'tp', deck, '#', shooter, tar_x, tar_y )

			if ( is_correct ) then
				if ( #paras == 2 ) then
					empty_command_functions[ 'tp' ].action_2_paras( c, false, shooter, paras[ 1 ], paras[ 2 ] )
				elseif ( #paras == 3 ) then
					empty_command_functions[ 'tp' ].action_3_paras( c, false, shooter, paras[ 1 ], paras[ 2 ], paras[ 3 ] )
				else
					command_print( 'tp(', '$empty_command_error_lack_paras', '2', to_string( #paras ) )
					return
				end

				add_projectile( empty_path .. 'entities/projectiles/command/tp.xml' )

				if ( command_count > 0 and recursion_level == nil and iteration == nil ) then
					add_table_count( deck, hand, command_count )
				end
			end
		end
	},
	{
		info = 'colorful_x2',
		series = {
			[ 'colorful' ] = true,
			[ 'copy_all' ] = true,
			[ 'colorful_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '10', -- EMPTY_COLORFUL_X2
		spawn_probability				= '0.3', -- EMPTY_COLORFUL_X2
		price = 500,
		mana = 325,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10

			if ( not reflecting ) then
				local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana
				local count = 2 * ( #hand + #deck + #discarded )

				while ( #hand > 0 and count > 0 ) do
					local data = hand[ 1 ]

					local rec = check_recursion( data, recursion_level )
					if ( data.id ~= 'EMPTY_COLORFUL_X2' and data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'colorful' ] = true,
							[ 'copy_all' ] = true,
							[ 'colorful_copy_all' ] = true,
						}, 'x2' )

						count = count - 1
					end

					table.insert( discarded, table.remove( hand, 1 ) )
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'colorful_arrival',
		series = {
			[ 'colorful' ] = true,
			[ 'copy_all' ] = true,
			[ 'colorful_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '10', -- EMPTY_COLORFUL_ARRIVAL
		spawn_probability				= '0.3', -- EMPTY_COLORFUL_ARRIVAL
		price = 500,
		mana = 325,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10

			if ( not reflecting ) then
				local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana
				local count = 2 * ( #hand + #deck + #discarded )

				while ( #deck > 0 and count > 0 ) do
					local data = deck[ 1 ]

					local rec = check_recursion( data, recursion_level )
					if ( data.id ~= 'EMPTY_COLORFUL_ARRIVAL' and data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'colorful' ] = true,
							[ 'copy_all' ] = true,
							[ 'colorful_copy_all' ] = true,
						}, 'arrival' )

						count = count - 1
					end

					table.insert( discarded, table.remove( deck, 1 ) )
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'colorful_departure',
		series = {
			[ 'colorful' ] = true,
			[ 'copy_all' ] = true,
			[ 'colorful_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '10', -- EMPTY_COLORFUL_DEPARTURE
		spawn_probability				= '0.3', -- EMPTY_COLORFUL_DEPARTURE
		price = 500,
		mana = 325,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10

			if ( not reflecting ) then
				local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana
				local count = 2 * ( #hand + #deck + #discarded )

				while ( #discarded > 0 and count > 0 ) do
					local data = discarded[ 1 ]

					local rec = check_recursion( data, recursion_level )
					if ( data.id ~= 'EMPTY_COLORFUL_DEPARTURE' and data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'colorful' ] = true,
							[ 'copy_all' ] = true,
							[ 'colorful_copy_all' ] = true,
						}, 'departure' )

						count = count - 1
					end

					table.insert( deck, table.remove( discarded, 1 ) )
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before
			end

			draw_actions( 1, true )
		end,
	},
	{
		info = 'colorful_return',
		series = {
			[ 'colorful' ] = true,
			[ 'copy_all' ] = true,
			[ 'colorful_copy_all' ] = true,
		},
		type		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level						= '10', -- EMPTY_COLORFUL_RETURN
		spawn_probability				= '0.1', -- EMPTY_COLORFUL_RETURN
		price = 540,
		mana = 400,
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15
			current_reload_time = current_reload_time + 15

			if ( not reflecting ) then
				local firerate, reload, mana_before = c.fire_rate_wait, current_reload_time, mana
				local dis_count, count = 0, 0

				while ( #hand > 0 ) do
					local data = hand[ 1 ]

					local rec = check_recursion( data, recursion_level )
					if ( data.id ~= 'EMPTY_COLORFUL_RETURN' and data.id ~= 'RESET' ) and ( rec > -1 ) then
						dont_draw_actions = true

						data.action( rec, nil, {
							[ 'colorful' ] = true,
							[ 'copy_all' ] = true,
							[ 'colorful_copy_all' ] = true,
						}, 'return' )

						count = count + 1
					end

					if ( count % 2 == 1 ) then
						add_table_1( hand, discarded )

						dis_count = dis_count + 1
					else
						add_table_1( hand, deck )
					end
				end

				dont_draw_actions = false

				c.fire_rate_wait, current_reload_time, mana = firerate, reload, mana_before

				if ( count > 0 ) then
					if ( dis_count > 0 ) then
						add_table_count( discarded, deck, dis_count, true, true, false )
					end

					draw_actions( count, true )
				end
			end
		end,
	},
}

local changed_actions =
{
	{
		id			= 'BUBBLESHOT',
		related_projectiles	= { 'data/entities/projectiles/deck/bubbleshot.xml', 3 },
		action		= function ( )
			c.fire_rate_wait = c.fire_rate_wait - 5

			for _ = 1, 3, 1 do
				add_projectile( 'data/entities/projectiles/deck/bubbleshot.xml' )
			end
		end,
	},
	{
		id			= 'BLACK_HOLE_DEATH_TRIGGER',
		sprite		= sprite_url .. 'black_hole_death_trigger.png',
	},
	{
		id			= 'RUBBER_BALL',
		sprite		= sprite_url .. 'rubber_ball.png',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/rubber_ball.xml' },
	},
	{
		id			= 'SUMMON_HOLLOW_EGG',
		sprite		= sprite_url .. 'summon_egg_death_trigger.png',
	},
	{
		id			= 'CIRCLE_FIRE',
		sprite		= sprite_url .. 'circle_fire.png',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_fire.xml' },
	},
	{
		id			= 'CIRCLE_ACID',
		sprite		= sprite_url .. 'circle_acid.png',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_acid.xml' },
	},
	{
		id			= 'CIRCLE_OIL',
		sprite		= sprite_url .. 'circle_oil.png',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_oil.xml' },
	},
	{
		id			= 'CIRCLE_WATER',
		sprite		= sprite_url .. 'circle_water.png',
		related_projectiles	= { empty_path .. 'entities/projectiles/deck/circle_water.xml' },
	},
	{
		id			= 'DUPLICATE',
		series = {
			[ 'ori' ] = true,
			[ 'copy_all' ] = true,
			[ 'ori_copy_all' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 20

			local hand_count = #hand

			for _, data in ipairs( hand ) do
				local rec = check_recursion( data, recursion_level )
				if ( data.id ~= "DUPLICATE" ) and ( _ <= hand_count ) and ( rec > -1 ) then
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'copy_all' ] = true,
						[ 'ori_copy_all' ] = true,
					}, '2x' )
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		id			= 'RANDOM_SPELL',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) + 263 )
			local rnd = Random( 1, #actions )
			local data = actions [ rnd ]

			local safety = 0
			local rec = check_recursion( data, recursion_level )
			local flag = data.spawn_requires_flag
			local usable = true
			if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
				usable = false
			end

			while ( safety < 100 ) and ( ( rec == -1 ) or ( usable == false ) ) do
				rnd = Random( 1, #actions )
				data = actions [ rnd ]
				rec = check_recursion( data, recursion_level )
				flag = data.spawn_requires_flag
				usable = true
				if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
					usable = false
				end

				safety = safety + 1
			end

			data.action( rec, nil, {
				[ 'ori' ] = true,
				[ 'random' ] = true,
				[ 'ori_random' ] = true,
			}, 'spell' )
		end,
	},
	{
		id			= 'RANDOM_PROJECTILE',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) + 203 )
			local rnd = Random( 1, #actions )
			local data = actions [ rnd ]

			local safety = 0
			local rec = check_recursion( data, recursion_level )
			local flag = data.spawn_requires_flag
			local usable = true
			if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
				usable = false
			end

			while ( safety < 100 ) and ( ( data.type ~= 0 ) or ( rec == -1 ) or ( usable == false ) ) do
				rnd = Random( 1, #actions )
				data = actions [ rnd ]
				rec = check_recursion( data, recursion_level )
				flag = data.spawn_requires_flag
				usable = true
				if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
					usable = false
				end

				safety = safety + 1
			end

			data.action( rec, nil, {
				[ 'ori' ] = true,
				[ 'random' ] = true,
				[ 'ori_random' ] = true,
			}, 'projectile' )
		end,
	},
	{
		id			= 'RANDOM_MODIFIER',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) + 133 )
			local rnd = Random( 1, #actions )
			local data = actions [ rnd ]

			local safety = 0
			local rec = check_recursion( data, recursion_level )
			local flag = data.spawn_requires_flag
			local usable = true
			if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
				usable = false
			end

			while ( safety < 100 ) and ( ( data.type ~= 2 ) or ( rec == -1 ) or ( usable == false ) ) do
				rnd = Random( 1, #actions )
				data = actions [ rnd ]
				rec = check_recursion( data, recursion_level )
				flag = data.spawn_requires_flag
				usable = true
				if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
					usable = false
				end

				safety = safety + 1
			end

			data.action( rec, nil, {
				[ 'ori' ] = true,
				[ 'random' ] = true,
				[ 'ori_random' ] = true,
			}, 'modifier' )
		end,
	},
	{
		id			= 'RANDOM_STATIC_PROJECTILE',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) + 253 )
			local rnd = Random( 1, #actions )
			local data = actions [ rnd ]

			local safety = 0
			local rec = check_recursion( data, recursion_level )
			local flag = data.spawn_requires_flag
			local usable = true
			if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
				usable = false
			end

			while ( safety < 100 ) and ( ( data.type ~= 1 ) or ( rec == -1 ) or ( usable == false ) ) do
				rnd = Random( 1, #actions )
				data = actions [ rnd ]
				rec = check_recursion( data, recursion_level )
				flag = data.spawn_requires_flag
				usable = true
				if ( flag ) and ( HasFlagPersistent( flag ) == false ) then
					usable = false
				end

				safety = safety + 1
			end

			data.action( rec, nil, {
				[ 'ori' ] = true,
				[ 'random' ] = true,
				[ 'ori_random' ] = true,
			}, 'static' )
		end,
	},
	{
		id			= 'DRAW_RANDOM',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) - 325 + #discarded )
			local datasize = #deck + #discarded
			local rnd = Random( 1, datasize )

			local data = { }

			if ( rnd <= #deck ) then
				data = deck [ rnd ]
			else
				data = discarded [ rnd - #deck ]
			end

			local checks = 0
			local rec = check_recursion( data, recursion_level )

			while ( data ) and ( ( rec == -1 ) or ( ( data.uses_remaining ) and ( data.uses_remaining == 0 ) ) ) and ( checks < datasize ) do
				rnd = ( rnd % datasize ) + 1
				checks = checks + 1

				if ( rnd <= #deck ) then
					data = deck [ rnd ]
				else
					data = discarded [ rnd - #deck ]
				end

				rec = check_recursion( data, recursion_level )
			end

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				data.action( rec, nil, {
					[ 'ori' ] = true,
					[ 'random' ] = true,
					[ 'ori_random' ] = true,
				}, 'draw_1' )

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end
			end
		end,
	},
	{
		id			= 'DRAW_RANDOM_X3',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) - 325 + #discarded )
			local datasize = #deck + #discarded
			local rnd = Random( 1, datasize )

			local data = { }

			if ( rnd <= #deck ) then
				data = deck [ rnd ]
			else
				data = discarded [ rnd - #deck ]
			end

			local checks = 0
			local rec = check_recursion( data, recursion_level )

			while ( data ) and ( ( rec == -1 ) or ( ( data.uses_remaining ) and ( data.uses_remaining == 0 ) ) ) and ( checks < datasize ) do
				rnd = ( rnd % datasize ) + 1
				checks = checks + 1

				if ( rnd <= #deck ) then
					data = deck [ rnd ]
				else
					data = discarded [ rnd - #deck ]
				end

				rec = check_recursion( data, recursion_level )
			end

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				for i=1, 3 do
					data.action( rec, nil, {
						[ 'random' ] = true,
						[ 'ori_random' ] = true,
					}, 'draw_x3' )
				end

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end
			end
		end,
	},
	{
		id			= 'DRAW_3_RANDOM',
		series = {
			[ 'ori' ] = true,
			[ 'random' ] = true,
			[ 'ori_random' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			SetRandomSeed( GameGetFrameNum( ) + #deck, GameGetFrameNum( ) - 325 + #discarded )
			local datasize = #deck + #discarded

			for i=1, 3 do
				local rnd = Random( 1, datasize )

				local data = { }

				if ( rnd <= #deck ) then
					data = deck [ rnd ]
				else
					data = discarded [ rnd - #deck ]
				end

				local checks = 0
				local rec = check_recursion( data, recursion_level )

				while ( data ) and ( ( rec == -1 ) or ( ( data.uses_remaining ) and ( data.uses_remaining == 0 ) ) ) and ( checks < datasize ) do
					rnd = ( rnd % datasize ) + 1
					checks = checks + 1

					if ( rnd <= #deck ) then
						data = deck [ rnd ]
					else
						data = discarded [ rnd - #deck ]
					end

					rec = check_recursion( data, recursion_level )
				end

				if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'random' ] = true,
						[ 'ori_random' ] = true,
					}, 'draw_3' )

					if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end
				end
			end
		end,
	},
	{
		id			= 'ADD_TRIGGER',
		series = {
			[ 'ori' ] = true,
			[ 'add_X' ] = true,
			[ 'ori_add_X' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local data = {}

			local how_many = 1

			if ( #deck > 0 ) then
				data = deck[ 1 ]
			else
				data = nil
			end

			if ( data ) then
				local rec = check_recursion( data, recursion_level )

				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= 'ADD_TRIGGER' ) and ( data.id ~= 'ADD_TIMER' ) and ( data.id ~= 'ADD_DEATH_TRIGGER' ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							data.action( rec, nil, {
								[ 'ori' ] = true,
								[ 'add_X' ] = true,
								[ 'ori_add_X' ] = true,
							}, 'trigger' )
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[ how_many ]
				end

				if ( data ) and ( data.related_projectiles ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[ 1 ]
					local count = data.related_projectiles[ 2 ] or 1

					for i = 1, how_many do
						add_table_1( deck, discarded )
					end

					local valid = false

					for i = 1, #deck do
						local check = deck[ i ]

						if ( check ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end

					if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if ( valid ) then
						for i = 1, count do
							add_projectile_trigger_hit_world(target, 1)
						end
					else
						dont_draw_actions = true
						data.action( rec, nil, {
							[ 'ori' ] = true,
							[ 'add_X' ] = true,
							[ 'ori_add_X' ] = true,
						}, 'trigger' )
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	{
		id			= 'ADD_TIMER',
		series = {
			[ 'ori' ] = true,
			[ 'add_X' ] = true,
			[ 'ori_add_X' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local data = {}

			local how_many = 1

			if ( #deck > 0 ) then
				data = deck[ 1 ]
			else
				data = nil
			end

			if ( data ) then
				local rec = check_recursion( data, recursion_level )

				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= 'ADD_TRIGGER' ) and ( data.id ~= 'ADD_TIMER' ) and ( data.id ~= 'ADD_DEATH_TRIGGER' ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							data.action( rec, nil, {
								[ 'ori' ] = true,
								[ 'add_X' ] = true,
								[ 'ori_add_X' ] = true,
							}, 'timer' )
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[ how_many ]
				end

				if ( data ) and ( data.related_projectiles ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[ 1 ]
					local count = data.related_projectiles[ 2 ] or 1

					for i = 1, how_many do
						add_table_1( deck, discarded )
					end

					local valid = false

					for i = 1,# deck do
						local check = deck[ i ]

						if ( check ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end

					if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if ( valid ) then
						for i = 1, count do
							add_projectile_trigger_timer( target, 20, 1 )
						end
					else
						dont_draw_actions = true
						data.action( rec, nil, {
							[ 'ori' ] = true,
							[ 'add_X' ] = true,
							[ 'ori_add_X' ] = true,
						}, 'timer' )
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	{
		id			= 'ADD_DEATH_TRIGGER',
		series = {
			[ 'ori' ] = true,
			[ 'add_X' ] = true,
			[ 'ori_add_X' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local data = {}

			local how_many = 1

			if ( #deck > 0 ) then
				data = deck[ 1 ]
			else
				data = nil
			end

			if ( data ) then
				local rec = check_recursion( data, recursion_level )

				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= 'ADD_TRIGGER' ) and ( data.id ~= 'ADD_TIMER' ) and ( data.id ~= 'ADD_DEATH_TRIGGER' ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							data.action( rec, nil, {
								[ 'ori' ] = true,
								[ 'add_X' ] = true,
								[ 'ori_add_X' ] = true,
							}, 'death_trigger' )
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[ how_many ]
				end

				if ( data ) and ( data.related_projectiles ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[ 1 ]
					local count = data.related_projectiles[ 2 ] or 1

					for i = 1, how_many do
						add_table_1( deck, discarded )
					end

					local valid = false

					for i = 1, #deck do
						local check = deck[ i ]

						if ( check ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end

					if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if ( valid ) then
						for i = 1, count do
							add_projectile_trigger_death( target, 1 )
						end
					else
						dont_draw_actions = true
						data.action( rec, nil, {
							[ 'ori' ] = true,
							[ 'add_X' ] = true,
							[ 'ori_add_X' ] = true,
						}, 'death_trigger' )
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	{
		id			= 'ALPHA',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local data = { }

			if ( #discarded > 0 ) then
				data = discarded [ 1 ]
			elseif ( #hand > 0 ) then
				data = hand [ 1 ]
			elseif ( #deck > 0 ) then
				data = deck [ 1 ]
			else
				data = nil
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'ori' ] = true,
					[ 'greek_letter' ] = true,
					[ 'ori_greek_letter' ] = true,
				}, 'alpha' )
			end
		end,
	},
	{
		id			= 'GAMMA',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 15

			local data = { }

			if ( #deck > 0 ) then
				data = deck [ #deck ]
			elseif ( #hand > 0 ) then
				data = hand [ #hand ]
			else
				data = nil
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) then
				data.action( rec, nil, {
					[ 'ori' ] = true,
					[ 'greek_letter' ] = true,
					[ 'ori_greek_letter' ] = true,
				}, 'gamma' )
			end
		end,
	},
	{
		id			= 'TAU',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 35

			local data1 = { }
			local data2 = { }

			local s1 = ''
			local s2 = ''

			if ( #deck > 0 ) then
				s1 = 'deck'
				data1 = deck [ 1 ]
			else
				data1 = nil
			end

			if ( #deck > 0 ) then
				s2 = 'deck 2'
				data2 = deck [ 2 ]
			else
				data2 = nil
			end

			local rec1 = check_recursion( data1, recursion_level )
			local rec2 = check_recursion( data2, recursion_level )

			if ( data1 ) and ( rec1 > -1 ) then
				data1.action( rec1, nil, {
					[ 'ori' ] = true,
					[ 'greek_letter' ] = true,
					[ 'ori_greek_letter' ] = true,
				}, 'tau' )
			end

			if ( data2 ) and ( rec2 > -1 ) then
				data2.action( rec2, nil, {
					[ 'ori' ] = true,
					[ 'greek_letter' ] = true,
					[ 'ori_greek_letter' ] = true,
				}, 'tau' )
			end
		end,
	},
	{
		id			= 'OMEGA',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			for _, data in ipairs( discarded ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) and ( data.id ~= 'RESET' ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'omega' )
					dont_draw_actions = false
				end
			end

			for _, data in ipairs( hand ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( ( data.recursive == nil ) or ( data.recursive == false ) ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'omega' )
					dont_draw_actions = false
				end
			end

			for _, data in ipairs( deck ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( rec > -1 ) and ( data.id ~= 'RESET' ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'omega' )
					dont_draw_actions = false
				end
			end
		end,
	},
	{
		id			= 'MU',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana

			for _, data in ipairs( discarded ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 2 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'mu' )
					dont_draw_actions = false
				end
			end

			for _, data in ipairs( hand ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 2 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'mu' )
					dont_draw_actions = false
				end
			end

			for _, data in ipairs( deck ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 2 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'mu' )
					dont_draw_actions = false
				end
			end

			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_

			draw_actions( 1, true )
		end,
	},
	{
		id			= 'PHI',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana

			for i,data in ipairs( discarded ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 0 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'phi' )
					dont_draw_actions = false
				end
			end

			for i,data in ipairs( hand ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 0 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'phi' )
					dont_draw_actions = false
				end
			end

			for i,data in ipairs( deck ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 0 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'phi' )
					dont_draw_actions = false
				end
			end

			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_
		end,
	},
	{
		id			= 'SIGMA',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 30

			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana

			for i,data in ipairs( discarded ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 1 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'sigma' )
					dont_draw_actions = false
				end
			end

			for i,data in ipairs( hand ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 1 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'sigma' )
					dont_draw_actions = false
				end
			end

			for i,data in ipairs( deck ) do
				local rec = check_recursion( data, recursion_level )
				if ( data ) and ( data.type == 1 ) and ( rec > -1 ) then
					dont_draw_actions = true
					data.action( rec, nil, {
						[ 'ori' ] = true,
						[ 'greek_letter' ] = true,
						[ 'ori_greek_letter' ] = true,
					}, 'sigma' )
					dont_draw_actions = false
				end
			end

			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_

			draw_actions( 1, true )
		end,
	},
	{
		id			= 'ZETA',
		series = {
			[ 'ori' ] = true,
			[ 'greek_letter' ] = true,
			[ 'ori_greek_letter' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			local entity_id = GetUpdatedEntityID( )
			local x, y = EntityGetTransform( entity_id )
			local options = { }

			local children = EntityGetAllChildren( entity_id )
			local inventory = EntityGetFirstComponent( entity_id, 'Inventory2Component' )

			if ( inventory ) then
				local active_wand = ComponentGetValue2( inventory, 'mActiveItem' )

				for _, child_id in ipairs( children or {} ) do
					if ( EntityGetName( child_id ) == 'inventory_quick' ) then
						local wands = EntityGetAllChildren( child_id )
						for k,wand_id in ipairs( wands or {} ) do
							if ( wand_id ~= active_wand ) and EntityHasTag( wand_id, 'wand' ) then
								local spells = EntityGetAllChildren( wand_id )
								for j,spell_id in ipairs( spells or {} ) do
									local comp = EntityGetFirstComponentIncludingDisabled( spell_id, 'ItemActionComponent' )

									if ( comp ) then
										local action_id = ComponentGetValue2( comp, 'action_id' )

										table.insert( options, action_id )
									end
								end
							end
						end
					end
				end
			end

			if ( #options > 0 ) then
				SetRandomSeed( x + GameGetFrameNum( ), y + 251 )

				local rnd = Random( 1, #options )
				local action_id = options [ rnd ]

				for i,data in ipairs( actions ) do
					if ( data.id == action_id ) then
						local rec = check_recursion( data, recursion_level )
						if ( rec > -1 ) then
							dont_draw_actions = true
							data.action( rec, nil, {
								[ 'ori' ] = true,
								[ 'greek_letter' ] = true,
								[ 'ori_greek_letter' ] = true,
							}, 'zeta' )
							dont_draw_actions = false
						end
						break
					end
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		id			= 'DIVIDE_2',
		series = {
			[ 'ori' ] = true,
			[ 'divide' ] = true,
			[ 'ori_divide' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 20

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( #deck > 0 ) then
				data = deck [ iter ] or nil
			else
				data = nil
			end

			local count = 2
			if ( iter >= 5 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				local firerate = c.fire_rate_wait
				local reload = current_reload_time

				for i = 1,count do
					if ( i == 1 ) then
						dont_draw_actions = true
					end
					local imax = data.action( rec, iter + 1, {
						[ 'ori' ] = true,
						[ 'divide' ] = true,
						[ 'ori_divide' ] = true,
					}, '2' )

					dont_draw_actions = false

					if ( imax ) then
						iter_max = imax
					end
				end

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end

				if ( iter == 1 ) then
					c.fire_rate_wait, current_reload_time = firerate, reload

					add_table_count( deck, discarded, iter_max )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.2
			c.explosion_radius = c.explosion_radius - 5.0
			if (c.explosion_radius < 0) then
				c.explosion_radius = 0
			end

			c.pattern_degrees = 5

			return iter_max
		end,
	},
	{
		id			= 'DIVIDE_3',
		series = {
			[ 'ori' ] = true,
			[ 'divide' ] = true,
			[ 'ori_divide' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 35

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( #deck > 0 ) then
				data = deck [ iter ] or nil
			else
				data = nil
			end

			local count = 3
			if ( iter >= 4 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				local firerate = c.fire_rate_wait
				local reload = current_reload_time

				for i = 1,count do
					if ( i == 1 ) then
						dont_draw_actions = true
					end
					local imax = data.action( rec, iter + 1, {
						[ 'ori' ] = true,
						[ 'divide' ] = true,
						[ 'ori_divide' ] = true,
					}, '3' )

					dont_draw_actions = false

					if ( imax ) then
						iter_max = imax
					end
				end

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end

				if ( iter == 1 ) then
					c.fire_rate_wait, current_reload_time = firerate, reload

					add_table_count( deck, discarded, iter_max )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.4
			c.explosion_radius = c.explosion_radius - 10.0
			if (c.explosion_radius < 0) then
				c.explosion_radius = 0
			end

			c.pattern_degrees = 5

			return iter_max
		end,
	},
	{
		id			= 'DIVIDE_4',
		series = {
			[ 'ori' ] = true,
			[ 'divide' ] = true,
			[ 'ori_divide' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 50

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( #deck > 0 ) then
				data = deck [ iter ] or nil
			else
				data = nil
			end

			local count = 4
			if ( iter >= 4 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				local firerate = c.fire_rate_wait
				local reload = current_reload_time

				for i = 1,count do
					if ( i == 1 ) then
						dont_draw_actions = true
					end
					local imax = data.action( rec, iter + 1, {
						[ 'ori' ] = true,
						[ 'divide' ] = true,
						[ 'ori_divide' ] = true,
					}, '4' )

					dont_draw_actions = false

					if ( imax ) then
						iter_max = imax
					end
				end

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end

				if ( iter == 1 ) then
					c.fire_rate_wait, current_reload_time = firerate, reload

					add_table_count( deck, discarded, iter_max )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 0.6
			c.explosion_radius = c.explosion_radius - 20.0
			if (c.explosion_radius < 0) then
				c.explosion_radius = 0
			end

			c.pattern_degrees = 5

			return iter_max
		end,
	},
	{
		id			= 'DIVIDE_10',
		series = {
			[ 'ori' ] = true,
			[ 'divide' ] = true,
			[ 'ori_divide' ] = true,
		},
		action		= function ( recursion_level, iteration, copy_series, copy_specific )
			c.fire_rate_wait = c.fire_rate_wait + 80
			current_reload_time = current_reload_time + 20

			local data = { }

			local iter = iteration or 1
			local iter_max = iteration or 1

			if ( #deck > 0 ) then
				data = deck [ iter ] or nil
			else
				data = nil
			end

			local count = 10
			if ( iter >= 3 ) then
				count = 1
			end

			local rec = check_recursion( data, recursion_level )

			if ( data ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				local firerate = c.fire_rate_wait
				local reload = current_reload_time

				for i = 1,count do
					if ( i == 1 ) then
						dont_draw_actions = true
					end
					local imax = data.action( rec, iter + 1, {
						[ 'ori' ] = true,
						[ 'divide' ] = true,
						[ 'ori_divide' ] = true,
					}, '10' )

					dont_draw_actions = false

					if ( imax ) then
						iter_max = imax
					end
				end

				if ( data.uses_remaining ) and ( data.uses_remaining > 0 ) then
					data.uses_remaining = data.uses_remaining - 1

					local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
					if not reduce_uses then
						data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
					end
				end

				if ( iter == 1 ) then
					c.fire_rate_wait, current_reload_time = firerate, reload

					add_table_count( deck, discarded, iter_max )
				end
			end

			c.damage_projectile_add = c.damage_projectile_add - 1.5
			c.explosion_radius = c.explosion_radius - 40.0
			if (c.explosion_radius < 0) then
				c.explosion_radius = 0
			end

			c.pattern_degrees = 5

			return iter_max
		end,
	},
	{
		id			= 'WORM_RAIN',
		related_projectiles	= { 'data/entities/projectiles/deck/worm_rain.xml' },
	},
}

for i, _ in ipairs( new_actions ) do
	if ( _.info and _.info ~= '' ) then
		local info = string.lower( _.info )
		local e_info = 'empty_' .. info

		_.id					= string.upper( e_info )
		_.name					= '$action_' .. e_info
		_.description			= '$actiondesc_' .. e_info
		_.sprite				= sprite_url .. info .. '.png'
		_.sprite_unidentified	= img_unident
	end
end

replace_table( actions, changed_actions, true )
add_table( actions, new_actions, false, false )

if ( ModSettingGet( 'empty_the_blackhole_catgirl.SPELL_ALL_EQUAL' ) ) then
	for _, action in pairs( actions ) do
		action.spawn_requires_flag = nil
		action.spawn_level = '0,1,2,3,4,5,6,7,8,9,10'
		action.spawn_probability = '4,4,4,4,4,4,4,4,4,4,4'
	end
else
	for _, action in pairs( actions ) do
		action.spawn_requires_flag = nil
	end
end


triphase_reincarnation_check = false

extra_iter = 0

inherit_attr = {
	'extra_entities',
	'game_effect_entities',

	'lifetime_add',
	'speed_multiplier',
	'gravity',
	'bounces',

	'spread_degrees',
	'pattern_degrees',

	'damage_melee_add',
	'damage_projectile_add',
	'damage_explosion_add',
	'damage_explosion',
	'explosion_radius',
	'damage_electricity_add',
	'damage_fire_add',
	'damage_ice_add',
	'damage_drill_add',
	'damage_slice_add',
	'damage_curse_add',
	'damage_healing_add',
	'damage_null_all',
	'damage_critical_chance',

	'knockback_force',

	'trail_material',
	'trail_material_amount',

	'gore_particles',
}

---<<<<<<<<<<<<<<<<<<<<<<<< 原版函数替换 >>>>>>>>>>>>>>>>>>>>>>>>---

local old_clone_action = clone_action

function clone_action( source, target )
	old_clone_action( source, target )

	target.series			= source.series
	target.price			= source.price
	target.max_uses			= source.max_uses
	target.command_type		= source.command_type
	target.command_value	= source.command_value
end

local old__start_shot = _start_shot

function _start_shot( ... )
	triphase_reincarnation_check = false

	old__start_shot( ... )
end

local old_set_current_action = set_current_action

function set_current_action( ... )
	if ( reflecting ) then
		old_set_current_action( ... )
	else
		local desc = c.action_description

		old_set_current_action( ... )

		c.action_description = desc
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 新增函数 >>>>>>>>>>>>>>>>>>>>>>>>---

---递归形态, 递归上限 +2
---@param act boolean
function rec_form( act )
	if ( act ) then
		recursion_limit = 4
	else
		recursion_limit = 2
	end
end

---迭代形态, 迭代上限 +1
---@param act boolean
function iter_form( act )
	if ( act ) then
		extra_iter = 1
	else
		extra_iter = 0
	end
end

---继承属性地发射投射物
---@param _ table
---@param copy_c table
function inherit_shot( _, copy_c )
	local shot = create_shot( _.draw_count )

	for j, v in ipairs( inherit_attr ) do
		shot.state[ v ] = copy_c[ v ]
	end

	shot_structure = { }

	local old_c = c
	c = shot.state

	draw_actions( shot.num_of_cards_to_draw, _.reload )
	register_action( shot.state )

	SetProjectileConfigs( )

	c = old_c
end

---发射复合型触发投射物
---@param entity_filename string
---@param trigger_table table<string, any>
function add_projectile_trigger_complex( entity_filename, trigger_table )
	if ( reflecting ) then
		Reflection_RegisterProjectile( entity_filename )
		return
	end

	BeginProjectile( entity_filename )

	local copy_c = c

	for i, _ in ipairs( trigger_table or { } ) do
		_.trigger_type = _.trigger_type or 'trigger'
		_.draw_count = _.draw_count or 1
		_.reload = _.reload or true

		if ( _.trigger_type == 'trigger' ) then
			BeginTriggerHitWorld( )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload or true )
			end
		elseif ( _.trigger_type == 'timer' ) then
			BeginTriggerTimer( _.timer or 0 )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload )
			end
		else
			BeginTriggerDeath( )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload )
			end
		end

		EndTrigger( )
	end

	EndProjectile( )
end

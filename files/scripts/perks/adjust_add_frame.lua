dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local shooter, tag = get_root_entity( ), 'adjust'
local frames, level = get_comp_info( shooter, 'VariableStorageComponent', tag, {
	{ 'value_int', 0 },
	{ 'value_float', 1 },
} )

frames = math.min( frames + level, max_adjust )

set_comp_value( shooter, 'VariableStorageComponent', tag, {
	value_int = frames,
} )

local aims = { }
local aim1, aim2 = get_all_child( shooter, 'adjust_aim_1' ), get_all_child( shooter, 'adjust_aim_2' )

add_table( aims, aim1, false, false )
add_table( aims, aim2, false, false )

local color = 'spark_red_bright'

if ( frames >= max_adjust ) then
	color = 'spark_teal'
end

set_comp_obj_value( aims, 'LaserEmitterComponent', nil, {
	{ 'laser', 'beam_particle_type', CellFactory_GetType( color ) },
} )

local wand = tonumber( find_the_wand_held( shooter ) )

if ( is_not_0_num( wand ) ) then
	set_comp_value( aims, 'LaserEmitterComponent', nil, {
		is_emitting = true,
	} )

	local wx, wy, wdir = EntityGetTransform( wand )

	local max_dev_deg = max_adjust / 2

	local dev_rad = math.rad( max_dev_deg * ( max_adjust - frames ) / max_adjust )
	local ox, oy = wx + math.cos( wdir ), wy - math.sin( wdir )

	for i, _ in ipairs( aim1 ) do
		EntitySetTransform( _, ox, oy, wdir + dev_rad )
	end

	for i, _ in ipairs( aim2 ) do
		EntitySetTransform( _, ox, oy, wdir - dev_rad )
	end
else
	set_comp_value( aims, 'LaserEmitterComponent', nil, {
		is_emitting = false,
	} )
end

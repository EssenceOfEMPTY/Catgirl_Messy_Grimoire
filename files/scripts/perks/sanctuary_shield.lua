dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
local entity_id = GetUpdatedEntityID( )

local data_comp = EntityGetFirstComponent( entity_id, 'VariableStorageComponent', 'empty_sanctuary_shield_data' )
if not ( data_comp ) then
	return
end

local stationary_frames = ComponentGetValue2( data_comp, 'value_int' )
local shield_entity_id = ComponentGetValue2( data_comp, 'value_string' )
shield_entity_id = tonumber( shield_entity_id ) or 0

if not ( EntityGetIsAlive( entity_id ) ) then
	if ( shield_entity_id ~= 0 and EntityGetIsAlive( shield_entity_id ) ) then
		EntityKill( shield_entity_id )
	end
	return
end

local current_x, current_y = EntityGetTransform( entity_id )
if not ( current_x and current_y ) then
	return
end

local pos_tracker_comp = EntityGetFirstComponent( entity_id, 'VariableStorageComponent', 'empty_sanctuary_shield_position' )
if not ( pos_tracker_comp ) then
	pos_tracker_comp = EntityAddComponent2( entity_id, 'VariableStorageComponent', {
		_tags = 'empty_sanctuary_shield_position,perk_component',
		value_float = current_x,
		value_string = tostring(current_y)
	})
end

local last_x = ComponentGetValue2( pos_tracker_comp, 'value_float' )
local last_y = tonumber( ComponentGetValue2( pos_tracker_comp, 'value_string' ) )

local delta_x = current_x - last_x
local delta_y = current_y - last_y
local distance_moved = delta_x * delta_x + delta_y * delta_y

ComponentSetValue2( pos_tracker_comp, 'value_float', current_x )
ComponentSetValue2( pos_tracker_comp, 'value_string', tostring( current_y ) )

local is_moving = distance_moved > 0.03

if not ( is_moving ) then
	stationary_frames = stationary_frames + 1

	if ( stationary_frames >= 150 and ( shield_entity_id == 0 or not EntityGetIsAlive( shield_entity_id ) ) ) then
		local max_hp = 4
		local damagemodel = EntityGetFirstComponent(entity_id, 'DamageModelComponent')
		if damagemodel then
			max_hp = math.max( ComponentGetValue2(damagemodel, 'max_hp') or max_hp, 20 )
		end
		local shield_hp = max_hp * 5

		local shield_entity = EntityLoad( empty_path .. 'entities/misc/perks/sanctuary_shield.xml', current_x, current_y )
		if ( shield_entity ) then
			local shield_damagemodel = EntityGetFirstComponent(shield_entity, 'DamageModelComponent')
			if shield_damagemodel then
				ComponentSetValue2( shield_damagemodel, 'max_hp', shield_hp )
				ComponentSetValue2( shield_damagemodel, 'hp', shield_hp )
			end

			EntityAddChild( entity_id, shield_entity )

			ComponentSetValue2( data_comp, 'value_string', tostring( shield_entity ) )
		end
	end
else
	stationary_frames = 0
	if ( shield_entity_id ~= 0 and EntityGetIsAlive( shield_entity_id ) ) then
		EntityKill( shield_entity_id )
		ComponentSetValue2( data_comp, 'value_string', '0' )
	end
end

ComponentSetValue2(data_comp, 'value_int', stationary_frames)

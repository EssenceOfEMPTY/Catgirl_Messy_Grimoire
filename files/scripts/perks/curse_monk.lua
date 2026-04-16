dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local x, y = EntityGetTransform( entity )

if EntityGetIsAlive( entity ) then
	local storage_comp = EntityGetFirstComponent( entity, 'VariableStorageComponent', 'empty_curse_monk' )

	if not ( storage_comp ) then
		storage_comp = EntityAddComponent2( entity, 'VariableStorageComponent', {
			_tags = 'empty_curse_monk',
			value_int = get_money( entity ),
		} )
	else
		local last_money = ComponentGetValue2( storage_comp, 'value_int' )
		local current_money = get_money( entity )
		local gold_gained = current_money - last_money

		if ( gold_gained > 0 ) then
			EntityInflictDamage( entity, 2 * math.floor( gold_gained ) / ( 3 * get_scale( ) ), 'DAMAGE_CURSE', '$empty_death_msg_curse_monk', 'DISINTEGRATED', 0, 0, entity )
			GamePlaySound( 'data/audio/Desktop/event_cues.bank', 'event_cue/curse_apply', x, y )
		end

		if ( gold_gained < 0 ) then
			EntityInflictDamage( entity, math.floor( gold_gained ) / get_scale( ), 'DAMAGE_HEALING', '', 'DISINTEGRATED', 0, 0, entity )
			EntityLoad( 'data/entities/particles/heal.xml', x, y )
		end

		ComponentSetValue2( storage_comp, 'value_int', current_money )
	end
end

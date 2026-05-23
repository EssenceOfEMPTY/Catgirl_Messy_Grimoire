dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local curse = 'curse_death_trail'

if ( is_alive( entity ) ) then
	local x, y = EntityGetTransform( entity )

	local e = EntityLoad( empty_path .. 'entities/misc/curse/' .. curse .. '.xml', x, y )

	if ( GlobalsGetValue( 'EMPTY_CURSE_GRAVITY_FREE', '0' ) == '1' ) then
		local max = 1800

		if ( not is_has_comp( entity, 'VariableStorageComponent', curse ) ) then
			add_comp_remove_dupli( entity, 'VariableStorageComponent', curse, {
				_tags = curse,
				value_int = 0,
			} )

			set_comp_value( e, 'LifetimeComponent', nil, {
				lifetime = max + 1,
			}, nil, nil )

			set_comp_value( e, 'ParticleEmitterComponent', curse, {
				delay_frames = max,
			}, nil, nil )
		else
			local count = get_comp_info( entity, 'VariableStorageComponent', curse, {
				{ 'value_int', 0 },
			}, nil )

			if ( count < max - 180 ) then
				set_comp_value( entity, 'VariableStorageComponent', curse, {
					value_int = count + 1,
				}, nil, nil )

				set_comp_value( e, 'LifetimeComponent', nil, {
					lifetime = max - count + 1,
				}, nil, nil )

				set_comp_value( e, 'ParticleEmitterComponent', curse, {
					delay_frames = max - count,
				}, nil, nil )
			end
		end
	end
end

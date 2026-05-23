dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

if ( is_has_comp( entity, 'ProjectileComponent', nil ) ) then
	set_comp_value( entity, 'ProjectileComponent', nil, {
		friendly_fire = false,
		collide_with_shooter_frames = -1,
	}, nil, nil )

	local shooter = get_comp_info( entity, 'ProjectileComponent', nil, {
		{ 'mWhoShot', nil },
	}, nil )

	if ( is_not_0_num( shooter ) ) then
		set_comp_obj_value( entity, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'dont_damage_this', shooter },
		}, nil, nil )

		if ( is_has_comp( entity, 'AreaDamageComponent', nil ) ) then
			if ( is_player( entity ) ) then
				set_comp_value( entity, 'AreaDamageComponent', nil, {
					entities_with_tag = all_tag.enemy,
				}, nil, nil )
			else
				set_comp_value( entity, 'AreaDamageComponent', nil, {
					entities_with_tag = all_tag.player,
				}, nil, nil )
			end
		end

		if ( is_has_comp( entity, 'LightningComponent', nil ) ) then
			set_comp_obj_value( entity, 'LightningComponent', nil, {
				{ 'config_explosion', 'dont_damage_this', shooter },
			}, nil, nil )
		end
	end
end

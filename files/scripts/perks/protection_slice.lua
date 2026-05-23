dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function shot( proj )
	if ( EntityHasTag( proj, 'disc_bullet' ) or EntityHasTag( proj, 'disc_bullet_big' ) ) then
		local count = set_comp_value( proj, 'ProjectileComponent', nil, {
			friendly_fire = false,
			collide_with_shooter_frames = -1,
		}, nil, nil )

		if ( count > 0 ) then
			local shooter = get_comp_info( proj, 'ProjectileComponent', nil, {
				{ 'mWhoShot', nil },
			}, nil )

			if ( is_not_0_num( shooter ) ) then
				if ( is_player( shooter ) ) then
					set_comp_value( proj, 'AreaDamageComponent', nil, {
						entity_with_tag = all_tag.enemy,
					}, nil, nil )
				else
					set_comp_value( proj, 'AreaDamageComponent', nil, {
						entity_with_tag = all_tag.player,
					}, nil, nil )
				end
			end
		end
	end
end


function shot( projectile )
	local p_comps = EntityGetComponent( projectile, 'ProjectileComponent' );
	for _, p_comp in ipairs( p_comps or { } ) do
		if EntityHasTag( projectile, 'disc_bullet' ) or EntityHasTag( projectile, 'disc_bullet_big' ) then
			ComponentSetValue2( p_comp, 'friendly_fire', false );

			local a_comps = EntityGetComponent( projectile, 'AreaDamageComponent' );
			for k, a_comp in ipairs( a_comps or { } ) do
				ComponentSetValue2( a_comp, 'damage_type', 'DAMAGE_SLICE' );
			end
		end
	end
end

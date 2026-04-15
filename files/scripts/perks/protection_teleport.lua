
function shot( projectile )
	local t_comp = EntityGetComponent( projectile, 'TeleportComponent' );
	for _, comp in ipairs( t_comp or { } ) do
		EntityRemoveComponent( projectile, comp )
	end
end

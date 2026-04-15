dofile_once( 'data/scripts/game_helpers.lua' )
dofile_once( 'data/scripts/lib/utilities.lua' )

local damagemodel = EntityGetFirstComponent( GetUpdatedEntityID( ), 'DamageModelComponent' )
if ( damagemodel ) then
	local current_hp = tonumber( ComponentGetValue2( damagemodel, 'hp' ) ) or 4
	local max_hp = tonumber( ComponentGetValue2( damagemodel, 'max_hp' ) ) or 4

	if ( current_hp < max_hp ) then
		local target_hp = math.min( current_hp + ( max_hp * 0.015 ), max_hp )
		ComponentSetValue2( damagemodel, 'hp', tostring( target_hp ) )
	end
end

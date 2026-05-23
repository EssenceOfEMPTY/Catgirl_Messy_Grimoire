dofile_once( 'data/scripts/perks/perk_list.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
-- dofile_once( empty_path .. 'scripts/perks/removable_perks/get_perks.lua' )

unremovable = { }
local perks_info = { }

function init_perks_table( )
	if ( not is_not_nil_table( unremovable ) ) then
		unremovable = { }

		for i, _ in ipairs( perk_list ) do
			if ( _.func and not _.func_remove ) then
				unremovable[ _.id ] = true
			end
		end
	end

	if ( not is_not_nil_table( perks_info ) ) then
		perks_info = dofile_once( empty_path .. '_virtual/perks_info.lua' )
	end
end

function get_act_perks( player )
	init_perks_table( )

	local perks = { }

	if ( is_not_0_num( player ) ) then
		for i, child in ipairs( get_all_child( player ) ) do
			local perk = { }

			perk.ui_name, perk.ui_description, perk.icon_sprite_file =
			get_comp_info( child, 'UIIconComponent', nil, {
				{ 'name', '' },
				{ 'description', '' },
				{ 'icon_sprite_file', '' },
			}, nil )

			perk.id = perks_info[ perk.ui_name ]

			if ( perk.id and not unremovable[ perk.id ] ) then
				table.insert( perks, perk )
			end
		end
	end
end


function spawn_ocarina( x, y )
	local ocarina_cards = { 'KANTELE_A', 'KANTELE_D', 'KANTELE_DIS', 'KANTELE_E', 'KANTELE_G' }
	local distance = 20

	for i, v in ipairs( ocarina_cards ) do
		local x_ = x - #ocarina_cards * distance * 0.5 + i * distance

		CreateItemActionEntity( v, x_, y )
	end

	for i, v in ipairs( ocarina_cards ) do
		local x_ = x - #ocarina_cards * distance * 0.5 + i * distance

		CreateItemActionEntity( v, x_, y + distance )
	end

	EntityLoad( 'data/entities/items/kantele.xml', x, y - 32 )

	EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )
end

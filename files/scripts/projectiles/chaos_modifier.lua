dofile_once('data/scripts/lib/utilities.lua')

local entity_id = GetUpdatedEntityID( )

local parent_id = EntityGetParent( entity_id )
local target_id = 0

if ( parent_id ~= NULL_ENTITY ) then
	target_id = parent_id
else
	target_id = entity_id
end

if ( target_id ~= NULL_ENTITY ) then
	local r = Random( 1, 2 )
	if ( r == 1 ) then
		c.extra_entities = c.extra_entities .. 'data/entities/misc/orbit_discs.xml,'
	elseif ( r == 2 ) then
		c.extra_entities = c.extra_entities .. 'data/entities/misc/orbit_fireballs.xml,'--[[
	elseif ( r == 3 ) then
		c.extra_entities = c.extra_entities .. 'data/entities/misc/orbit_nukes.xml,'
	elseif ( r == 4 ) then
		c.extra_entities = c.extra_entities .. 'data/entities/misc/orbit_lasers.xml,'
	elseif ( r == 5 ) then
		c.extra_entities = c.extra_entities .. 'data/entities/misc/orbit_larpa.xml,'
	elseif ( r == 6 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 7 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 8 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 9 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 10 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 11 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 12 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 13 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 14 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 15 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 16 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 17 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 18 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 19 ) then
		c.extra_entities = c.extra_entities ..
	elseif ( r == 20 ) then
		c.extra_entities = c.extra_entities .. ]]--
	end
end

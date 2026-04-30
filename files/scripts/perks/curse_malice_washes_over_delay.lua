local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	LoadGameEffectEntityTo( entity, 'data/entities/misc/effect_curse_cloud_02.xml' )
end

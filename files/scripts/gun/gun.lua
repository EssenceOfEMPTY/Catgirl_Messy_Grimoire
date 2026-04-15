
triphase_reincarnation_check = false

local old_clone_action = clone_action

function clone_action( source, target )
	old_clone_action( source, target )

	target.series			= source.series
	target.price			= source.price
	target.max_uses			= source.max_uses
	target.command_type		= source.command_type
	target.command_value	= source.command_value
end

local old__start_shot = _start_shot

function _start_shot( ... )
	triphase_reincarnation_check = false

	old__start_shot( ... )
end

local old_set_current_action = set_current_action

function set_current_action( ... )
	if ( reflecting ) then
		old_set_current_action( ... )
	else
		local desc = c.action_description

		old_set_current_action( ... )

		c.action_description = desc
	end
end

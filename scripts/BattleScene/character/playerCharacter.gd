extends "res://scripts/BattleScene/character/character.gd"

func ProcessTurn(step : int) -> void:
	if(!selected):
		return;
	if(IsMoving()):
		return;
	match step:
		0:
			# move
			_PlayerMove();
		1:
			# end
			_PlayerEndTurn();
		_:
			return;

func _PlayerMove() -> void:
	if Input.is_action_just_pressed("select"):
		print("pressed");
		var mousePos = get_global_mouse_position()
		if (!playGrid.IsPointWalkable(get_global_mouse_position())) :
			return;
		_OnMoveStart(mousePos);
		
	pass;
	
func _PlayerEndTurn() -> void:
	#if Input.is_action_just_pressed("1"):
	turnManager.AddTurn(charId, 3);
	turnManager.EndCharStep(charId);
	SetSelected(false);
	pass;

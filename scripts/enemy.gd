extends "res://scripts/character.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ProcessTurn(step : int) -> void:
	_AiTurnEnemy(step);
	pass;
	
func _AiTurnEnemy(step : int) -> void:
	match step:
		0:
			_AiMove();
		1:
			_AiEndTurn();
	pass;
func _AiMove() -> void:
	if(IsMoving()):
		return;
	var randGridPos = playGrid.GetRandomGridPosInGrid();
	MoveTo(playGrid.GetGridPosViaGridCoord(randGridPos));
	TurnManager.EndCharStep(charId);
	pass;
func _AiEndTurn() -> void:
	if(IsMoving()):
		return;
	TurnManager.AddTurn(charId, 2);
	TurnManager.EndCharStep(charId);
	pass;

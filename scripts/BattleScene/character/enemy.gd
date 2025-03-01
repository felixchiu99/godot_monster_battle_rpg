extends "res://scripts/BattleScene/character/character.gd"

var moveTargetGrid : Vector2i;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready();
	moveTargetGrid = Vector2i(-1,-1);
	pass # Replace with function body.

func ProcessTurn(step : int) -> void:
	_AiTurnEnemy(step);
	pass;
	
func _AiTurnEnemy(step : int) -> void:
	match step:
		0:
			_AiMove();
	pass;
	
func HasMoveTarget() -> bool:
	return moveTargetGrid != Vector2i(-1,-1);

func GetMoveTarget() -> Vector2:
	if(HasMoveTarget()):
		return Vector2();
	var randGridPos = playGrid.GetRandomGridPosInGrid();
	moveTargetGrid = randGridPos;
	if (!playGrid.IsPointWalkable(playGrid.GetGridPosViaGridCoord(randGridPos))):
		moveTargetGrid = Vector2i(-1,-1);
	return randGridPos;
	
func _AiMove() -> void:
	var randGridPos = GetMoveTarget();
	if(!HasMoveTarget()):
		return;
	if(HasNoTarget()):
		_OnMoveStart(playGrid.GetGridPosViaGridCoord(randGridPos));
	pass;
	
func _AiEndTurn() -> void:
	if(IsMoving()):
		return;
	print("endturn")
	turnManager.AddTurn(charId, 2);
	turnManager.EndCharStep(charId);
	pass;
	
func _OnMoveComplete():
	super._OnMoveComplete();
	moveTargetGrid = Vector2i(-1,-1);
	_AiEndTurn();

extends Node2D

@onready var PlayGrid = $PlayGrid;
@onready var TurnTimer = $turn_timer;
@onready var Player = $Character;
@onready var Enemy = $Enemy;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_SetPlayGridOffset();
	_CharacterInit();
	pass # Replace with function body.

func _CharacterInit() -> void:
	var characterId = 0;
	
	#player
	print(Player.GetDetail());
	var targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		Vector2( 1 , 1 )
	);
	Player.Init(characterId, targetGridWorldPos);
	TurnTimer.AddActor(characterId, Player.GetDetail());
	TurnTimer.AddTurn(characterId, 5);
	characterId += 1;
	
	#enemy
	print(Enemy.GetDetail());
	targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		Vector2( 5 , 5 )
	);
	Enemy.Init(characterId, targetGridWorldPos);
	TurnTimer.AddActor(characterId, Enemy.GetDetail());
	TurnTimer.AddTurn(characterId, 1);
	characterId += 1;
	
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_TurnLoop();

func _SetPlayGridOffset() -> void:
	PlayGrid.position = -PlayGrid.GetGridCenter()/2;

# basic flow of game	
func _TurnLoop() -> void:
	TurnTimer.ProcessTurn();
	#ask turn timer for turn detail
	match TurnTimer.GetCurrentStep():
		#switch for player
		0, 1:
			_PlayerTurn();
		#switch for ai (enemy)
		2, 3:
			_AiTurnEnemy();
		#end turn if turn overflow
		_:
			TurnTimer.EndTurn();
	#switch for player
	
	#switch for ai (enemy)
	#switch for ai (ally)
	pass;


func _PlayerTurn() -> void:
	match TurnTimer.GetCurrentStep():
		0:
			_PlayerMove();
		1:
			_PlayerEndTurn();
	pass;
func _PlayerMove() -> void:
	if(Player.IsMoving()):
		return;
	if Input.is_action_just_pressed("select"):
		# skip if destination is not in grid
		if (!PlayGrid.IsInGrid(get_global_mouse_position())) :
			return;
		var targetGridWorldPos = PlayGrid.GetGridWorldPos(get_global_mouse_position());
		Player.MoveTo(targetGridWorldPos);
		TurnTimer.EndStep(0);
func _PlayerEndTurn() -> void:
	if(Player.IsMoving()):
		return;
	if Input.is_action_just_pressed("1"):
		TurnTimer.AddTurn(0, 3);
		TurnTimer.EndStep(0);
	pass;
	
func _AiTurnEnemy() -> void:
	match TurnTimer.GetCurrentStep():
		2:
			_AiMove();
		3:
			_AiEndTurn();
	pass;
func _AiMove() -> void:
	if(Enemy.IsMoving()):
		return;
	var randGridPos = PlayGrid.GetRandomGridPosInGrid();
	Enemy.MoveTo(PlayGrid.GetGridPosViaGridCoord(randGridPos));
	TurnTimer.EndStep(1);
	pass;
func _AiEndTurn() -> void:
	if(!Enemy.IsMoving()):
		return;
	TurnTimer.AddTurn(1, 2);
	TurnTimer.EndStep(1);
	pass;
	
func _AiTurnAlly() -> void:
	pass;

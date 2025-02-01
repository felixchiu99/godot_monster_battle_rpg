extends Node2D

@onready var PlayGrid = $PlayGrid;
@onready var TurnTimer = $turn_timer;
@onready var Player = $Character;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_CharacterInit();
	pass # Replace with function body.

func _CharacterInit() -> void:
	var characterId = 0;
	
	print(Player.GetDetail());
	#TurnTimer.AddActor(characterId, Player.GetDetail()["type"]);
	characterId += 1;
	
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select") && TurnTimer.GetCurrentStep() == 0:
		# skip if destination is not in grid
		if (!PlayGrid.IsInGrid(get_global_mouse_position())) :
			pass;
		var targetGridPos = PlayGrid.getGridPos(get_global_mouse_position());
		Player.MoveTo(targetGridPos);
		TurnTimer.EndStep();
	if Input.is_action_just_pressed("1"):
		TurnTimer.EndTurn();
		print("done");
	
func _TurnLoop() -> void:
	#ask turn timer for turn detail
	#switch for player
	#switch for ai (enemy)
	#switch for ai (ally)
	pass;
func _PlayerTurn() -> void:
	if Input.is_action_just_pressed("select") && TurnTimer.GetCurrentStep() == 0:
		# skip if destination is not in grid
		if (!PlayGrid.IsInGrid(get_global_mouse_position())) :
			pass;
		var targetGridPos = PlayGrid.getGridPos(get_global_mouse_position());
		Player.MoveTo(targetGridPos);
		TurnTimer.EndStep();
	if Input.is_action_just_pressed("1"):
		TurnTimer.EndTurn();
		print("done");
	pass;
func _AiTurnEnemy() -> void:
	pass;
func _AiTurnAlly() -> void:
	pass;

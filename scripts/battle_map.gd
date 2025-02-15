extends Node2D

@onready var PlayGrid = $PlayGrid;
@onready var TurnTimer = $turn_timer;
@onready var Player = $Character;
@onready var Enemy = $Enemy;

@onready var char = preload("res://objects/character.tscn");
var charList = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_SetPlayGridOffset();
	_CharacterInit();
	pass # Replace with function body.

func _CharacterInit() -> void:
	var characterId = 0;
	
	#player
	var targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		Vector2( 1 , 1 )
	);
	Player.Init(self, characterId, targetGridWorldPos);
	TurnTimer.AddActor(characterId, Player);
	TurnTimer.AddTurn(characterId, 5);
	characterId += 1;
	print(Player.GetDetail());
	
	#enemy
	targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		Vector2( 5 , 5 )
	);
	Enemy.Init(self, characterId, targetGridWorldPos);
	TurnTimer.AddActor(characterId, Enemy);
	TurnTimer.AddTurn(characterId, 1);
	characterId += 1;
	print(Enemy.GetDetail());
	
	#new player
	#var newPlayer = char.instantiate();
	#add_child(newPlayer);
	#targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		#Vector2( 6 , 6 )
	#);
	#Player.Init(characterId, targetGridWorldPos);
	#characterId += 1;
	#char.append(newPlayer);
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_TurnLoop();

func GetPlayGrid() -> Variant:
	return PlayGrid;
func GetTurnTimer() -> Variant:
	return TurnTimer;

func _SetPlayGridOffset() -> void:
	PlayGrid.position = -PlayGrid.GetGridCenter()/2;

# basic flow of game	
func _TurnLoop() -> void:
	TurnTimer.ProcessTurn();
	return;

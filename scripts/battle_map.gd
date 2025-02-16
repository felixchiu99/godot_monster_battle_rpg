extends Node2D

# temp
@onready var Player = $Character;
@onready var Enemy = $Enemy;

#manager
@onready var PlayGrid = $PlayGrid;
@onready var TurnManager = $turnManager;
@onready var HudManager = $CanvasLayer/HUD;

#ui
@onready var hudController = $CanvasLayer/HUD;

@onready var char = preload("res://objects/character.tscn");
var charList = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HudManager.Init(self);
	TurnManager.Init(self);
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
	TurnManager.AddActor(characterId, Player);
	TurnManager.AddTurn(characterId, 5);
	characterId += 1;
	print(Player.GetDetail());
	
	#enemy
	targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
		Vector2( 5 , 5 )
	);
	Enemy.Init(self, characterId, targetGridWorldPos);
	TurnManager.AddActor(characterId, Enemy);
	TurnManager.AddTurn(characterId, 1);
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
	UiUpdateTurn(TurnManager.GetCurrentTurn());

func GetPlayGrid() -> Variant:
	return PlayGrid;
func GetTurnManager() -> Variant:
	return TurnManager;
func GetHudManager() -> Variant:
	return HudManager;

func _SetPlayGridOffset() -> void:
	PlayGrid.position = -PlayGrid.GetGridCenter()/2;

# basic flow of game	
func _TurnLoop() -> void:
	TurnManager.ProcessTurn();
	return;
	
# ui 
func UiUpdateTurn(turn) -> void:
	hudController.UpdateTurn(turn);

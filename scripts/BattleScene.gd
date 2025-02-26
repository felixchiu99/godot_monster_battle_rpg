extends Node2D

#manager
@onready var PlayGrid = $PlayGrid;
@onready var TurnManager = $turnManager;
@onready var PlayerManager = $BattleCharManager;

#ui
@onready var HudManager = $Camera2D/CanvasLayer/HUD;

@onready var char = preload("res://objects/character.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HudManager.Init(self);
	TurnManager.Init(self);
	PlayerManager.Init(self);
	_SetPlayGridOffset();
	_CharacterInit();
	pass # Replace with function body.

func _CharacterInit() -> void:
	var characterId = 0;
	var targetGridWorldPos;
	
	#new enemy
	for n in 1:
		targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
			Vector2( 2 , n )
		);
		var char = PlayerManager.AddEnemy(self, characterId, targetGridWorldPos);
		TurnManager.AddActor(characterId, char);
		TurnManager.AddTurn(characterId, 1);
		characterId += 1;
	
	#new player
	for n in 2:
		targetGridWorldPos = PlayGrid.GetGridPosViaGridCoord(
			Vector2( 6 , n )
		);
		var char = PlayerManager.AddChar(self, characterId, targetGridWorldPos);
		TurnManager.AddActor(characterId, char);
		TurnManager.AddTurn(characterId, 2 + n);
		characterId += 1;
	
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
func GetPlayerManager() -> Variant:
	return PlayerManager;

func _SetPlayGridOffset() -> void:
	PlayGrid.position = -PlayGrid.GetGridCenter()/2;

# basic flow of game	
func _TurnLoop() -> void:
	TurnManager.ProcessTurn();
	return;
	
# ui 
func UiUpdateTurn(turn) -> void:
	HudManager.UpdateTurn(turn);

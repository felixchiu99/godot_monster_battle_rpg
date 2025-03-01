extends Control

@onready var turnLabel = $TurnDisplay/TurnLabel;
@onready var endTurnBtn = $EndTurn;
@onready var charIconParent = $CharIcon;

@onready var charIconPrefab = preload("res://objects/BattleScene/UI/char_icon.tscn");

# manager
var MapManager;
var TurnManager;

# 
var charList = [];
var charIcon = {};

# variables
@onready var offsetCharIcon : int;


func Init(MapManager : Variant) -> void:
	self.MapManager = MapManager;
	self.TurnManager = MapManager.GetTurnManager();
	SetEndTurnVisibility(false);
	return;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offsetCharIcon = $CharIcon.get_meta("charIconOffset");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func UpdateTurn (turn : int) -> void:
	turnLabel.ChangeText(turn);

func AddChar( charId : int , charRef : Variant):
	charIcon[charId] = charIconPrefab.instantiate();
	charIconParent.add_child(charIcon[charId]);
	charIcon[charId].Init(MapManager, charId, charRef);
	charIcon[charId].position = Vector2(0, offsetCharIcon * charIcon.size());
	charIcon[charId].SetVisable(false);
	return;
	
func SetActivate( charId : int, isVisable : bool):
	charIcon[charId].SetVisable(isVisable);


#end turn
func SetEndTurnVisibility(isVisible : bool) -> void:
	endTurnBtn.visible = isVisible;
	return;

func _on_end_turn_pressed() -> void:
	print("endTurn");
	TurnManager.OnEndTurnBtnPressed();
	pass # Replace with function body.

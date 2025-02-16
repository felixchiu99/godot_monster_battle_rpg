extends Control

@onready var turnLabel = $TurnDisplay/TurnLabel;
@onready var charIconParent = $CharIcon;

@onready var charIconPrefab = preload("res://objects/UI/char_icon.tscn");

# manager
var MapManager;

# 
var charList = [];
var charIcon = {};

# variables
@onready var offsetCharIcon : int;


func Init(MapManager : Variant) -> void:
	self.MapManager = MapManager;
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

func AddChar(  charId : int , charRef : Variant):
	charIcon[charId] = charIconPrefab.instantiate();
	charIconParent.add_child(charIcon[charId]);
	charIcon[charId].Init(MapManager.GetTurnManager(), charId, charRef);
	charIcon[charId].position = Vector2(0, offsetCharIcon * charIcon.size());
	return;
	
func SetActivate( charId : int, isVisable : bool):
	charIcon[charId].SetVisable(isVisable);

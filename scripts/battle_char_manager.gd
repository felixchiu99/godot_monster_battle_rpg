extends Node

@onready var charPrefab = preload("res://objects/character.tscn");
@onready var enemyPrefab = preload("res://objects/enemy.tscn");

# manager
var MapManager;

var charactorList : Dictionary = {};

func Init(MapManager : Variant) -> void:
	self.MapManager = MapManager;
	return;
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AddChar( parent: Variant, charId : int, pos : Vector2 ) -> Variant:
	# create child
	var newPlayer
	newPlayer = charPrefab.instantiate();
	parent.add_child(newPlayer);
	newPlayer.Init(parent, charId, pos);
	charactorList[charId] = newPlayer;
	# create hud element
	
	
	# 
	return newPlayer;

func ResetChar():
	for charId in charactorList:
		charactorList[charId].SetSelected(false);

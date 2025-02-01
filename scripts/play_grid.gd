extends Node2D

var horizontial = 10;
var vertical = 10;
@onready var grid = $TileMap;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.InitTile(vertical, horizontial);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func IsInGrid(worldCoord : Vector2) -> bool :
	return grid.IsInGrid(worldCoord);

func getGridPos(worldPos : Vector2) -> Vector2:
	var gridWorldPos = grid.getGridPos(worldPos);
	return grid.getGridPos(worldPos);
	

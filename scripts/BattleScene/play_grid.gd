extends Node2D

var horizontial = 10;
var vertical = 10;
@onready var grid = $TileMap;

var playerRef = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.InitTile(horizontial, vertical)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func GetGridCenter() -> Vector2:
	return GetGridPosViaGridCoord(Vector2(vertical/2+1, horizontial/2+1));

func IsInGrid(worldCoord : Vector2) -> bool :
	return grid.IsInGrid(worldCoord);

func GetGridWorldPos(worldPos : Vector2) -> Vector2:
	var gridWorldPos = grid.GetGridWorldPosViaWorldCoord(worldPos);
	return gridWorldPos;
	
func GetGridPosViaGridCoord(gridCoord : Vector2) -> Vector2:
	return grid.GetGridPosViaGridCoord(gridCoord);

func GetRandomGridPosInGrid() -> Vector2:
	var randGrid = Vector2(randi() % vertical,randi() % horizontial);
	if !grid.IsValidCell(grid.GetGridPosViaGridCoord(randGrid)) :
		randGrid = GetRandomGridPosInGrid();
	return randGrid;

# char position
func SetCharLocationOnGrid(worldCoord : Vector2, char : Variant):
	grid.SetCharLocationOnGrid( worldCoord, char);
func RemoveCharLocationOnGrid(worldCoord : Vector2, char : Variant):
	grid.RemoveCharLocationOnGrid( worldCoord, char);


#pathfind
func IsPointWalkable(worldCoord : Vector2) -> bool :
	return grid.IsPointWalkable(worldCoord);
func GetPath(fromWorldCoord : Vector2, toWorldCoord: Vector2) -> Array[Vector2]:
	return grid.GetPath(fromWorldCoord,toWorldCoord);

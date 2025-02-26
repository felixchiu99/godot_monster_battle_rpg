extends Node2D

enum actorType {
	player,
	ai_enemy,
	ai_ally
}

#ref to "master"
var battleMapRef;
var playGrid;
var turnManager;
var playerManager;
var hudManager;

#ref to CharIcon
var charIcon : Variant;

# private variable
var tween;
var charId;
var selected = false;
var currentPath : Array[Vector2];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Init(battleMapRef : Variant, charId : int, coord: Vector2) -> void:
	self.battleMapRef = battleMapRef;
	self.playGrid = battleMapRef.GetPlayGrid();
	self.turnManager = battleMapRef.GetTurnManager();
	self.playerManager = battleMapRef.GetPlayerManager();
	
	self.charId = charId;
	
	set_position(coord);
	playGrid.SetCharLocationOnGrid( self.position, self );
	#SetSelected(false);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	MoveViaGrid();
	pass

func SetHudManager() -> void:
	self.hudManager = battleMapRef.GetHudManager();
	print("set")
	
func SetSelected(isSelected : bool) -> void:
	self.selected = isSelected;
	$ColorRect.visible = self.selected;
	if(get_meta("characterType") == 0):
		self.hudManager.SetActivate( charId, isSelected );

func GetDetail() -> Dictionary:
	return {
		"id" : charId,
		"type" : get_meta("characterType")
	}

func ProcessTurn(step : int) -> void:
	if(!selected):
		return;
	if(IsMoving()):
		return;
	
	match step:
		0:
			# move
			_PlayerMove();
		1:
			# end
			_PlayerEndTurn();
		_:
			return;
	
func _PlayerMove() -> void:
	if Input.is_action_just_pressed("select"):
		print("pressed");
		var mousePos = get_global_mouse_position()
		if (!playGrid.IsPointWalkable(get_global_mouse_position())) :
			return;
		_OnMoveStart(mousePos);
		
	pass;
	
func _PlayerEndTurn() -> void:
	#if Input.is_action_just_pressed("1"):
	turnManager.AddTurn(charId, 3);
	turnManager.EndCharStep(charId);
	SetSelected(false);
	pass;

# Move 
func MoveTo(worldCoord: Vector2):
	var path = playGrid.GetPath(self.global_position, worldCoord);
	currentPath = path;

func MoveToAnimation(coord: Vector2)-> void:
	if not tween or not tween.is_valid():
		tween = create_tween();
		tween.tween_property(self, "position", coord, 0.3);
		tween.tween_callback(_OnMoveToGridComplete);

func _OnMoveStart(mousePos : Vector2):
	# remove char on Grid
	playGrid.RemoveCharLocationOnGrid( self.position, self );
	# move
	MoveTo(mousePos);
	pass;
func _OnMoveComplete():
	# update char position on grid
	playGrid.SetCharLocationOnGrid( self.position, self );
	# end turn
	turnManager.EndCharStep(charId);
	
	pass;
func IsMoving() -> bool:
	return tween and tween.is_valid();
func HasNoTarget() -> bool:
	return currentPath.size() == 0;

func _OnMoveToGridComplete():
	currentPath.pop_front();
	if(currentPath.size() == 0):
		_OnMoveComplete();
	pass;
	
#  pathfind
func MoveViaGrid():
	if currentPath.size() == 0:
		return;
	elif !IsMoving():
		MoveToNextGrid();
	pass;
	
func MoveToNextGrid():
	MoveToAnimation(currentPath.front());
	pass;

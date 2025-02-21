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
	#SetSelected(false);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SetHudManager() -> void:
	self.hudManager = battleMapRef.GetHudManager();
	print("set")
	print(hudManager)

func MoveTo(coord: Vector2)-> void:
	if not tween or not tween.is_valid():
		tween = create_tween();
		tween.tween_property(self, "position", coord, 1);

func IsMoving() -> bool:
	return tween and tween.is_valid();
	
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
		# skip if destination is not in grid
		if (!playGrid.IsInGrid(get_global_mouse_position())) :
			return;
		var targetGridWorldPos = playGrid.GetGridWorldPos(get_global_mouse_position());
		MoveTo(targetGridWorldPos);
		turnManager.EndCharStep(charId);
	pass;
	
func _PlayerEndTurn() -> void:
	#if Input.is_action_just_pressed("1"):
	turnManager.AddTurn(charId, 3);
	turnManager.EndCharStep(charId);
	SetSelected(false);
	pass;

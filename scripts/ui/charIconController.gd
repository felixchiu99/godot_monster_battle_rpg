extends Control

@onready var charIdLabel = $TextureRect/charIdLabel;

var charId;
var charRef;

# manager
var battleMapRef;
var turnManager;
var playerManager;

func Init(battleMapRef : Variant, charId : int, charRef : Variant) -> void:
	self.playerManager = battleMapRef.GetPlayerManager();
	self.turnManager = battleMapRef.GetTurnManager();
	self.charRef = charRef;
	SetId(charId);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SetId(charId : int) -> void:
	self.charId = charId;
	charIdLabel.text = str(charId);

func SetVisable (isVisable : bool) -> void:
	self.visible = isVisable;

# on Click
func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("left Click ", charId);
			playerManager.ResetChar();
			charRef.SetSelected(true);

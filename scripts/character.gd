extends Node2D

enum actorType {
	player,
	ai_enemy,
	ai_ally
}

var tween;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Init(charId : int, coord: Vector2) -> void:
	set_meta("charId", charId);
	set_position(coord);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func MoveTo(coord: Vector2)-> void:
	if not tween or not tween.is_valid():
		tween = create_tween();
		tween.tween_property(self, "position", coord, 1);

func IsMoving() -> bool:
	return tween and tween.is_valid();

func GetDetail() -> Dictionary:
	return {
		"id" : get_meta("charId"),
		"type" : get_meta("characterType")
	}

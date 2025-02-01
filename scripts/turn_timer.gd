extends Node

enum turnActor {
	player,
	ai_enemy,
	ai_ally
}

enum turnStep {
	move,
	atk
}

var turn = 0;
var currentStep = turnStep.move;

var charactorList = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(charactorList);
	pass

func EndTurn() -> void:
	turn += 1;
	currentStep = turnStep.move;

func EndStep() -> void:
	if(currentStep < turnStep.size()):
		currentStep += 1;

func GetCurrentStep() -> int:
	print(currentStep);
	return currentStep;

func GetCurrentTurn() -> int:
	print(turn);
	return turn;

func AddActor(id: int, type: int) -> void:
	charactorList.add({
		"id" : id,
		"type": type
	})
	pass;

extends Node

enum turnActor {
	player,
	ai_enemy,
	ai_ally
}

enum turnStep {
	move,
	atk,
	ai_move,
	ai_atk,
	end
}

var turn = 0;
var currentStep = turnStep.move;

var charactorList = {};

var	futureTurn = {};

var currentTurnDetail = {};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func EndTurn() -> void:
	# remove old future turn
	futureTurn.erase(turn);
	
	# New Turn
	turn += 1;
	currentStep = turnStep.move;
	
	# form step
	currentTurnDetail = {
		"player" = [],
		"ai_enemy" = [],
		"ai_ally" = []
	};
	FormTurnDetail();
	print("currentTurn ", GetCurrentTurn());
	print("currentTurnDetail ", currentTurnDetail);
	print("future ", futureTurn);

func _SetToNextStep() -> void:
	var keys = currentTurnDetail.keys();
	for i in range(GetCurrentStep()/2 + 1, currentTurnDetail.size()):
		if(currentTurnDetail[keys[i]].size() != 0):
			currentStep = i * 2;
			return;
	currentStep = turnStep.end;
	
func EndStep(charType = 0) -> void:
	if(GetCurrentStep() % 2 == 0): 
		currentStep += 1;
	else:
		_SetToNextStep();	
	if(GetCurrentStep() == turnStep.end):
		EndTurn;

func GetCurrentStep() -> int:
	return currentStep;

func GetCurrentTurn() -> int:
	return turn;

func AddActor(id: int, type: Dictionary) -> void:
	charactorList[id] = {
		"id" : id,
		"type" : type["type"]
	}
	pass;

func AddTurn( charId : int, speed = 1) -> void:	
	var targetTurn = GetCurrentTurn() + speed;
	var charType = "Player " if charId==0 else "Ai ";
	print(charType, "at ", targetTurn, " with ", speed);
	if futureTurn.has(targetTurn):
		futureTurn[targetTurn].push_back(charId);
	else:
		futureTurn[targetTurn] = [charId];

func ProcessTurn() -> void:
	SkipEmptyTurn();
	ProcessValidTurn();

func SkipEmptyTurn() -> void:
	if(	!futureTurn.has(GetCurrentTurn()) ):
		EndTurn();

func ProcessValidTurn() -> void:
	match currentStep:
		turnStep.move, turnStep.atk:
			if(currentTurnDetail["player"].size() == 0):
				EndStep();
		turnStep.ai_move, turnStep.ai_move:
			if(currentTurnDetail["ai_enemy"].size() == 0):
				EndStep();

func GetTurn() -> void:
	#print("current : ", GetCurrentTurn());
	#print("future : ", futureTurn);
	pass;

func FormTurnDetail() -> void:
	if(	!futureTurn.has(GetCurrentTurn()) ):
		return;
	for charId in futureTurn[GetCurrentTurn()]:
		match charactorList[charId].type:
			turnActor.player:
				currentTurnDetail["player"].push_back(charId);
			turnActor.ai_enemy:
				currentTurnDetail["ai_enemy"].push_back(charId);

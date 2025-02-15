extends Node

enum turnActor {
	player,
	ai_enemy,
	ai_ally
}

enum turnStep {
	move,
	atk,
	end
}

var turn = 0;
var currentStep = turnStep.move;

var charactorList = {};

var	futureTurn = {};

var currentTurnDetail = {};
var currentCharStep = {};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FormTurnDetail();
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


func _removeFromCharList(charId : int) -> void:
	charactorList[charId]["ref"].SetSelected(false);
	currentTurnDetail["player"].erase(charId);
	currentTurnDetail["ai_enemy"].erase(charId);
	currentTurnDetail["ai_ally"].erase(charId);
	
func EndCharStep(charId : int) -> void:
	if currentCharStep[charId] < turnStep.size():
		currentCharStep[charId] += 1;
	if currentCharStep[charId] == turnStep.end:
		_removeFromCharList( charId );


func GetCurrentStep( charId : int ) -> int:
	return currentCharStep[charId];

func GetCurrentTurn() -> int:
	return turn;

func AddActor(id: int, ref: Variant) -> void:
	charactorList[id] = {
		"id" : id,
		"type" : ref.GetDetail()["type"],
		"ref": ref
	}
	pass;

func AddTurn( charId : int, speed = 1) -> void:	
	var targetTurn = GetCurrentTurn() + speed;
	var charType = "Player " if charId == 0 else "Ai ";
	print(charType, "at ", targetTurn, " with ", speed);
	if futureTurn.has(targetTurn):
		futureTurn[targetTurn].push_back(charId);
	else:
		futureTurn[targetTurn] = [charId];

func ProcessTurn() -> void:
	SkipEmptyTurn();
	ProcessValidTurn();
	ProcessCharTurn();

func SkipEmptyTurn() -> void:
	if(	!futureTurn.has(GetCurrentTurn()) ):
		EndTurn();

func ProcessValidTurn() -> void:
	var count = 0;
	for charType in currentTurnDetail:
		if currentTurnDetail[charType].size() <= 0:
			count += 1;
	if(count >= 3 ):
		EndTurn();

func FormTurnDetail() -> void:
	if(	!futureTurn.has(GetCurrentTurn()) ):
		return;
	for charId in futureTurn[GetCurrentTurn()]:
		match charactorList[charId].type:
			turnActor.player:
				currentTurnDetail["player"].push_back(charId);
				currentCharStep[charId] = turnStep.move;
			turnActor.ai_enemy:
				currentTurnDetail["ai_enemy"].push_back(charId);
				currentCharStep[charId] = turnStep.move;

func ProcessCharTurn() -> void:
	#check which chars can move
	if currentTurnDetail["player"].size() > 0:
		ProcessPlayerTurn();
	if currentTurnDetail["ai_enemy"].size() > 0:
		#print("ai_enemy turn");
		ProcessAiEnemyTurn();
	#if currentTurnDetail["ai_ally"].size() > 0:
		#print("ai_ally turn");
	pass;

func ProcessPlayerTurn() -> void:
	for charIndex in currentTurnDetail["player"]:
		var char = charactorList[charIndex]["ref"];
		char.SetSelected(true);
		char.ProcessTurn(GetCurrentStep(charactorList[charIndex]["id"]));

func ProcessAiEnemyTurn() -> void:
	for enemyIndex in currentTurnDetail["ai_enemy"]:
		charactorList[enemyIndex]["ref"].ProcessTurn(GetCurrentStep(charactorList[enemyIndex]["id"]));
			

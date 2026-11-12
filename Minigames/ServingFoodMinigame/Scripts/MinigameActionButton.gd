extends Node
class_name MinigameActionButton
@export var playerButtonPosition : Array[Node2D]
@export var buttonFoodSprites : Array[Sprite2D]
@export var playerPlates : Array[Node2D]
@export var buttonRedCross : Array[Sprite2D]
@export var playerNickNamesLabels : Array[Label]

@export var playerEliminatedColor : Color


func SetButtonSprites(playerFoods: Dictionary[int,String], foodIndex: Dictionary[String,int]) -> void:
	
	for index in foodIndex.size():
		if playerFoods.has(index):
			var foodSpriteIndex = foodIndex[playerFoods[index]]
			playerPlates[index].show()
			playerNickNamesLabels[index].text = PlayersController.GetPlayerNickName(index)
			buttonFoodSprites[foodSpriteIndex].show()
			var position = playerButtonPosition[index].global_position
			buttonRedCross[index].hide()
			playerPlates[index].global_position = position
			buttonRedCross[index].global_position = position
			buttonFoodSprites[foodSpriteIndex].global_position = position
			

func DeletePlayer(playerId : int, foodId: int) -> void:
	TweenAnimator.ShakeNode2D(playerPlates[playerId])
	buttonRedCross[playerId].show()
	buttonFoodSprites[foodId].hide()

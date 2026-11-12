extends Node
@onready var roundController = get_node("../RoundController")
@export var pressSpaceToStartText: Label 
var startTextShow: bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	CheckStartGame()
	CheckMinimunPlayersToStart()

func CheckMinimunPlayersToStart() -> void:
	if not startTextShow:
		if PlayersController.GetPlayersCount() > 1:
			pressSpaceToStartText.show()
			startTextShow = true


func CheckStartGame() -> void:
	if(!InputController.GameInitialized and  Input.is_action_just_pressed("start_button") and (PlayersController.GetPlayersCount() > 1)):
		roundController.CreateRound()
		ScoreManager.InitializeScores(PlayersController.GetCurrentPlayersIds())
		#Añadir espera para la transición
		
		InputController.GameInitialized = true
		
		TransitionController.MakeTransition(1,.3)
		await get_tree().create_timer(.4).timeout
		
		MinigamesController.StartMinigames()
		SceneManager.LoadCurrentMinigame()
		PlayersController.SetPlayerButtonsState(false)

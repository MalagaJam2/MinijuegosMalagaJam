extends Node

signal PlayerSelectionChangeState(state: bool)
var activePlayers: Array[bool] = [false, false, false, false]
var playersNickName: Dictionary[int,String]
var activePlayerCount: int = 0


func Initialize() -> void:
	activePlayers = [false, false, false, false]
	activePlayerCount = 0
	SetPlayerButtonsState(true)

func PlayerSelect(playerId: int) -> void:
	
	#Para evitar que le lleguen jugadores que no son validos
	if(playerId < 0 or playerId >= activePlayers.size()):
		return
	
	#En caso de que ya se haya seleccionado este jugador, return
	if(activePlayers[playerId]):
		return
		
	activePlayers[playerId] = true;
	var temporalNickName: String = "Player %s" % (playerId + 1)
	playersNickName.set(playerId,temporalNickName)
	activePlayerCount+=1
	print("Jugador %d se ha unido" % playerId)

func SetPlayerButtonsState(state:bool) -> void:
	PlayerSelectionChangeState.emit(state)

func GetPlayersCount() -> int:
	return activePlayerCount

func GetCurrentPlayersIds() -> Array[int]:
#Preparamos un array con el id de los jugadores
	var playerIds: Array[int] = []
	for playerId in activePlayers.size():
		if(activePlayers[playerId]):
			playerIds.append(playerId)
	
	return playerIds;

func GetPlayerNickName(playerId:int) -> String:
	if playersNickName.has(playerId):
		return playersNickName[playerId]
	else:
		return ""

extends Node

signal moved
signal message(info, msg)
signal moveBot(dir)
signal attackBot(dir)

var aID = 0

enum{
	MELEE,
	RANGED,
	PLAYER,
	WALL
}

func _playerMoved():
	moved.emit()
	
func move(dir:Vector2):
	moveBot.emit(dir)

func attack(dir:Vector2):
	attackBot.emit(dir)

func messageBot(info:Info, msg):
	message.emit(info, msg)

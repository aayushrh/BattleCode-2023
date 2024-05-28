extends Node
class_name BotInfo

var id = 0
var position = Vector2.ZERO
var messages = []
var vision = []
var type = 0
var canMove = []

func fillInfo(nId, nPosition : Vector2, nMessages, nvision, ntype, ncanMove):
	id = nId
	position = nPosition
	messages = nMessages
	vision = nvision
	type = ntype
	canMove = ncanMove

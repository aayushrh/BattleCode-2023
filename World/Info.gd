extends Node
class_name Info

var position = Vector2.ZERO
var id = 0
var type = 0

func fillInfo(nId, nPosition, ntype):
	id = nId
	position = Vector2(nPosition.x/32, nPosition.y/32)
	type = ntype

extends Node
var directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]

enum {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

func isDirection(dir:Vector2):
	return directions.find(dir) != -1

func convertToDirection(dir:Vector2):
	if(isDirection(dir)):
		if(dir == Vector2(0, -1)):
			return UP
		if(dir == Vector2(0, 1)):
			return DOWN
		if(dir == Vector2(-1, 0)):
			return LEFT
		if(dir == Vector2(1, 0)):
			return RIGHT

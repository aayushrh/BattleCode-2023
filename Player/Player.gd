extends CharacterBody2D
class_name Player

enum{
	INENEMYANIMATION,
	INPLAYERANIMATION,
	CANMOVE
}

@export var movingTimer : Timer
@export var up : RayCast2D
@export var down : RayCast2D
@export var left : RayCast2D
@export var right : RayCast2D


var state = CANMOVE
var input = Vector2.ZERO
var moved = false
var start = Vector2.ZERO
var end = Vector2.ZERO
var time = 0.0

func _ready():
	movingTimer.timeout.connect(animDone)

func _process(delta):
	if(state == CANMOVE):
		tick(delta)
	elif(state == INPLAYERANIMATION):
		move(delta)
	
		
func tick(delta):
	input = Vector2.ZERO
	if(Input.is_action_just_pressed("ui_up") and !up.is_colliding()):
		input = Vector2.UP
	if(Input.is_action_just_pressed("ui_down") and !down.is_colliding()):
		input = Vector2.DOWN
	if(Input.is_action_just_pressed("ui_left") and !left.is_colliding()):
		input = Vector2.LEFT
	if(Input.is_action_just_pressed("ui_right") and !right.is_colliding()):
		input = Vector2.RIGHT
	
	if(input != Vector2.ZERO):
		Global._playerMoved()
		state = INPLAYERANIMATION
		start = global_position
		end = global_position + input*32
		movingTimer.start(0.1)
		time = 0.0

func move(delta):
	global_position = Vector2((end.x-start.x)*(time) + start.x, (end.y-start.y)*(time) + start.y)
	time += delta * 10
	
func animDone():
	if(state == INPLAYERANIMATION):
		global_position = end
		movingTimer.start(0.1)
		state = INENEMYANIMATION
	else:
		state = CANMOVE

func damage():
	print("darn")

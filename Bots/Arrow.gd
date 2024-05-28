extends CharacterBody2D
class_name Arrow

@export var timer : Timer

var direction = Vector2(0, 0)
var speed = 2

var start = Vector2(0, 0)
var end = Vector2(0, 0)

var time = 0
var d = 0
var moving = false

func _ready():
	timer.timeout.connect(_fly)
	start = global_position
	end = global_position + direction * 32 * speed
	time = 0
	_fly()
	
func _process(delta):
	if(moving):
		global_position = Vector2((end.x-start.x)*(time) + start.x, (end.y-start.y)*(time) + start.y)
		time += delta * 10

func _startFly():
	timer.start(0.1)
	start = global_position
	end = global_position + direction * 32 * speed
	time = 0

func _fly():
	moving = !moving
	if(moving):
		timer.start(0.1)

func _on_area_2d_body_entered(body):
	if(body is Player and body.global_position.distance_to(start) > 16):
		body.damage()
		queue_free()
	if(body is Wall and body.global_position.distance_to(start) < 16):
		queue_free()

extends CharacterBody2D
class_name Bot

@export var movementTimer : Timer
@export var visionArea : Area2D
@export var up : RayCast2D
@export var down : RayCast2D
@export var left : RayCast2D
@export var right : RayCast2D

var id = 0
var messages = []
var vision = []
var canMove = []
var type = 0
var movementDirection = Vector2.ZERO
var start = Vector2.ZERO
var end = Vector2.ZERO
var moving = false
var time = 0.0
var actualVision = []

func _ready():
	id = Global.aID
	Global.aID += 1
	canMove = [true, true, true, true]
	movementTimer.timeout.connect(_moveTimeout)
	visionArea.body_entered.connect(_on_vision_body_entered)
	visionArea.body_exited.connect(_on_vision_body_exited)

func move(dir:Vector2):
	if(Direction.isDirection(dir)):
		movementDirection = Direction.convertToDirection(dir)
		movementTimer.start(0.1)

func _process(delta):
	canMove = [!up.is_colliding(), !down.is_colliding(), !left.is_colliding(), !right.is_colliding()]
	if(moving):
		global_position = Vector2((end.x-start.x)*(time) + start.x, (end.y-start.y)*(time) + start.y)
		time += delta * 10

func _moveTimeout():
	updateVision()
	if !moving:
		var blocked = !canMove[movementDirection]
		if(!blocked):
			moving = true
			start = global_position
			end = global_position + Direction.directions[movementDirection] * 32
			time = 0.0
			movementTimer.start(0.1)
	else:
		moving = false

func informatize(body):
	var i = Info.new()
	if(body is Player):
		i.fillInfo(0, body.global_position, Global.PLAYER)
	elif(body is Bot):
		i.fillInfo(body.id, body.global_position, body.type)
	elif(body is Wall):
		i.fillInfo(0, body.global_position, Global.WALL)
	return i

func updateVision():
	vision = []
	for v in actualVision:
		vision.append(informatize(v))

func _on_vision_body_entered(body):
	vision.append(informatize(body))
	actualVision.append(body)

func _on_vision_body_exited(body):
	var i = actualVision.find(body)
	vision.remove_at(i)
	actualVision.remove_at(i)

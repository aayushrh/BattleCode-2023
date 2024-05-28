extends Bot
class_name Melee

@export var attackTimer : Timer

var attackDirection

func _ready():
	super._ready()
	type = Global.MELEE
	attackTimer.timeout.connect(_attackTimeout)

func attack(dir):
	if(Direction.isDirection(dir)):
		attackDirection = Direction.convertToDirection(dir)
		attackTimer.start(0.14)

func _attackTimeout():
	var raycasts = [up, down, left, right]
	if(raycasts[attackDirection].is_colliding()):
		var collider = raycasts[attackDirection].get_collider()
		if(collider is Player):
			collider.damage()

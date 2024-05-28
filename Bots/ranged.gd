extends Bot
class_name Ranged

@onready var arrow = preload("res://Bots/arrow.tscn")

var attackDirection

func _ready():
	super._ready()
	type = Global.RANGED

func attack(dir):
	if(Direction.isDirection(dir)):
		var a = arrow.instantiate()
		a.global_position = global_position
		a.direction = dir
		get_tree().current_scene.add_child(a)

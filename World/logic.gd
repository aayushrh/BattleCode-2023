extends Node2D
class_name Logic

var current = 0

func _ready():
	Global.moved.connect(callingAllBots)
	Global.moveBot.connect(move)
	Global.attackBot.connect(attack)
	Global.message.connect(message)

func callingAllBots():
	for i in range(0, get_child_count()):
		if(get_child(i) is Bot):
			current = i
			var info = BotInfo.new()
			var type = Global.MELEE
			info.fillInfo(get_child(i).id, get_child(i).global_position, get_child(i).messages, get_child(i).vision, type, get_child(i).canMove)
			UserScript.botTick(info)
		if(get_child(i) is Arrow):
			get_child(i)._startFly()
	
func move(dir:Vector2):
	var b = get_child(current)
	b.move(dir)
	
func message(bot:Info, msg):
	for b in get_children():
		if(b is Bot and bot.id == b.id):
			b.messages.add(msg)
	
func attack(dir:Vector2):
	var b = get_child(current)
	b.attack(dir)


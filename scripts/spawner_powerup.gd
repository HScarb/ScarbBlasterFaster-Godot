# spawner_powerup.gd
extends Node

const powerups = [
	preload("res://scenes/powerup_armor.tscn"),
	preload("res://scenes/powerup_laser.tscn")
]

func _ready():
	yield(utils.create_timer(rand_range(10, 15)), "timeout")
	spawn()
	pass

func spawn():
	while true:
		var powerup = utils.choose(powerups).instance()
		var pos = Vector2()
		pos.x = rand_range(7, utils.view_size.width - 7)
		pos.y = -7
		powerup.set_pos(pos)
		get_node("container").add_child(powerup)
		
		yield(utils.create_timer(rand_range(10, 15)), "timeout")
	pass
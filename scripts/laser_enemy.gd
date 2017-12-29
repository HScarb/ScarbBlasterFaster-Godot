# laser_enemy.gd
extends "res://scripts/laser.gd"

func _ready():
	connect("area_enter", self, "_on_area_enter")
	pass

func _on_area_enter(other_area):
	if other_area.is_in_group(game.GROUP_SHIPS):
		other_area.armor -= 1
		create_flare()
		utils.remote_call("shaker", "shake", 1, 0.13)
		queue_free()
	pass
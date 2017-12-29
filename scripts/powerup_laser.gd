# powerup_laser.gd
extends "res://scripts/powerup.gd"

func _ready():
	connect("area_enter", self, "_on_area_enter")
	pass

func _on_area_enter(other_area):
	if other_area.is_in_group(game.GROUP_SHIPS):
		other_area.is_double_shooting = true
		audio_player.play_sample("powerup")
		queue_free()
	pass
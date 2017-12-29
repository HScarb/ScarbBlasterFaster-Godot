# powerup_armor.gd
extends "res://scripts/powerup.gd"

func _ready():
	connect("area_enter", self, "_on_area_enter")
	pass

func _on_area_enter(other_area):
	if other_area.is_in_group(game.GROUP_SHIPS):
		other_area.armor += 1
		audio_player.play_sample("powerup")
		queue_free()
	pass
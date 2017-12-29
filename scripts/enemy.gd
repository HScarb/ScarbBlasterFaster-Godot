# enemys.gd
extends Area2D

export var speed = Vector2()
export var armor = 1 setget _set_armor

const scn_explosion = preload("res://scenes/explosion.tscn")

func _ready():
	add_to_group(game.GROUP_ENEMIES)
	set_process(true)
	connect("area_enter", self, "_on_area_enter")
	pass

func _process(delta):
	translate(speed * delta)
	
	# 超出屏幕则移除
	if get_pos().y >= utils.view_size.height + 16:
		queue_free()
	pass

func _on_area_enter(other_area):
	if other_area.is_in_group(game.GROUP_SHIPS):
		other_area.armor -= 1
		create_explosion()
		queue_free()
	pass

func _set_armor(new_value):
	if is_queued_for_deletion(): return
	
	if new_value < armor:
		audio_player.play_sample("hit_enemy")
	
	armor = new_value
	
	if armor <= 0:
		game.score_current += 5
		create_explosion()
		queue_free()
	pass

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.set_pos(get_pos())
	utils.main_node.add_child(explosion)
	pass
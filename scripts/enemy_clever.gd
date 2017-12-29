# enemy_clever.gd
extends "res://scripts/enemy.gd"

const scn_laser = preload("res://scenes/laser_enemy.tscn")

const TIME_SHOOT_INTERVAL = 1.5

func _ready():
	speed.x = utils.choose([speed.x, -speed.x])
	
	yield(utils.create_timer(1), "timeout")
	shoot()
	pass

func _process(delta):
	# 左右循环移动
	if get_pos().x <= 16:
		speed.x = abs(speed.x)
	elif get_pos().x >= utils.view_size.width - 16:
		speed.x = -abs(speed.x)
	pass
	
func shoot():
	while true:
		var laser = scn_laser.instance()
		laser.set_global_pos(get_node("cannon").get_global_pos())
		utils.main_node.add_child(laser)
		
		yield(utils.create_timer(TIME_SHOOT_INTERVAL), "timeout")
	pass
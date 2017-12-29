# ship.gd
extends Area2D

export var speed = Vector2(0.2, 0.2)

var armor = 4 setget _set_armor
var is_double_shooting = false setget _set_is_double_shooting	# 双重子弹

const scn_laser = preload("res://scenes/laser_ship.tscn")
const scn_explosion = preload("res://scenes/explosion.tscn")
const scn_flash = preload("res://scenes/flash.tscn")

const TIME_DOUBLE_SHOOT = 5
const TIME_SHOOT_INTERVAL = 0.25

signal armor_changed

func _ready():
	add_to_group(game.GROUP_SHIPS)
	set_process(true)
	
	yield(get_node("anim"), "finished")		# 等待动画结束
	shoot()
	pass

func _process(delta):
	# 让飞机跟着鼠标位置移动
	var offset_x = (utils.mouse_pos.x - get_pos().x) * speed.x
	var offset_y = (utils.mouse_pos.y - get_pos().y) * speed.y
	translate(Vector2(offset_x, offset_y))
	#translate(Vector2(offset_x, 0))
	
	# 限制飞机不飞出屏幕
	var x = clamp(get_pos().x, 16, utils.view_size.width - 16)
	var y = clamp(get_pos().y, 16, utils.view_size.height - 16)
	set_pos(Vector2(x, y))
	#set_pos(Vector2(x, get_pos().y))
	pass

func shoot():
	while true:
		var pos_left = get_node("cannons/left").get_global_pos()
		var pos_right = get_node("cannons/right").get_global_pos()
		create_laser(pos_left)
		create_laser(pos_right)
		
		if is_double_shooting:
			var laser_left = create_laser(pos_left)
			var laser_right = create_laser(pos_right)
			laser_left.speed.x = -25
			laser_right.speed.x = 25
		
		yield(utils.create_timer(0.25), "timeout")
	pass

func create_laser(pos):
	var laser = scn_laser.instance()
	laser.set_global_pos(pos)
	utils.main_node.add_child(laser)
	return laser
	pass

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.set_pos(get_pos())
	utils.main_node.add_child(explosion)
	pass

func _set_armor(new_value):
	if new_value > 4: return
	
	if new_value < armor:
		audio_player.play_sample("hit_ship")
		utils.main_node.add_child(scn_flash.instance())
	
	armor = new_value
	emit_signal("armor_changed", armor)
	
	if armor <= 0:
		create_explosion()
		queue_free()
	pass

func _set_is_double_shooting(new_value):
	if new_value == true:
		is_double_shooting = true
		yield(utils.create_timer(TIME_DOUBLE_SHOOT), "timeout")		# 等待5秒
		is_double_shooting = false
	else:
		is_double_shooting = false
	pass
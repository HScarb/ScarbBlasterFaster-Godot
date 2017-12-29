# laser.gd
extends Area2D

export var speed = Vector2()
const scn_flare = preload("res://scenes/flare.tscn")

func _ready():
	set_process(true)
	get_node("vis_notifier").connect("exit_screen", self, "_on_exit_screen")
	
	create_flare()
	pass

func _process(delta):
	translate(speed * delta)
	pass

func _on_exit_screen():
	queue_free()	# remove
	pass

func create_flare():
	var flare = scn_flare.instance()
	flare.set_global_pos(get_global_pos())
	# print(get_global_pos())
	utils.main_node.add_child(flare)
	pass
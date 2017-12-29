# powerup.gd
extends Area2D

export var speed = Vector2(0, 200)

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(speed * delta)
	
	if get_pos().y >= utils.view_size.height + 7:
		queue_free()
	pass
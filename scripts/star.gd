# star.gd
extends Sprite

export var speed = Vector2()		# 可以在编辑器中设置的变量，星星移动速度

func _ready():
	set_process(true)
	pass
	
# 背景星星移动
func _process(delta):
	translate(speed * delta)	# Apply a local translation of 'offset' to the 2D node, starting from its current local position.
	
	if get_pos().y >= utils.view_size.height:
		set_pos(Vector2(0, -180))
	pass
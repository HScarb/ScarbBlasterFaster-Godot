# flare.gd
extends Sprite

func _ready():
	fade_out()
	pass

func fade_out():
	var lerp_time = 0
	var lerp_duration = 0.08
	
	while lerp_time < lerp_duration:
		lerp_time += get_process_delta_time()
		lerp_time = min(lerp_time, lerp_duration)
		
		var percent = lerp_time / lerp_duration
		set_opacity(lerp(1, 0, percent))
		
		yield(get_tree(), "idle_frame")
		
	queue_free()
	pass
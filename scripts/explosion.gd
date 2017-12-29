# explosion.gd
extends Sprite

func _ready():
	get_node("p_smoke").set_emitting(true)
	get_node("p_smoke/p_flare").set_emitting(true)
	
	utils.remote_call("shaker", "shake", 8, 0.2)
	audio_player.play_sample("explosion")
	
	randomize()
	set_rot(rand_range(0, 360))		# 随机旋转角度
	fade_out()
	pass

func fade_out():
	var lerp_time = 0
	var lerp_duration = 0.7
	
	while lerp_time < lerp_duration:
		lerp_time += get_process_delta_time()
		lerp_time = min(lerp_time, lerp_duration)
		
		var percent = lerp_time / lerp_duration
		set_opacity(lerp(1, 0, percent))
		
		yield(get_tree(), "idle_frame")
	
	queue_free()
	pass
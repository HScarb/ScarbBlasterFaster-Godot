# audio_player.gd
extends Node

onready var sample_player = get_node("sample_player")
onready var stream_player = get_node("stream_player")

func _ready():
	pass

func play_sample(name):
	sample_player.play(name)
	pass
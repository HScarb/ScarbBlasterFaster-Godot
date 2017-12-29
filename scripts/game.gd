# game.gd (pre-load)
extends Node

const STAGE_MENU = "res://stages/stage_menu.tscn"
const STAGE_GAME = "res://stages/stage_game.tscn"

const GROUP_SHIPS = "ships"
const GROUP_ENEMIES = "enemies"

const FILE_PATH = "user://score_best"

var score_best = 0 setget _set_score_best
var score_current = 0 setget _set_score_current

signal score_best_changed
signal score_current_changed

func _ready():
	load_score_best()
	pass

func save_score_best():
	var file = File.new()
	file.open(FILE_PATH, File.WRITE)
	file.store_var(score_best)
	file.close()
	pass

func load_score_best():
	var file = File.new()
	if not file.file_exists(FILE_PATH): return
	file.open(FILE_PATH, File.READ)
	score_best = file.get_var()
	file.close()
	pass

func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
	
	if score_current > score_best:
		self.score_best = score_current		###
	pass
	
func _set_score_best(new_value):
	score_best = new_value
	emit_signal("score_best_changed")
	pass
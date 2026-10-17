extends Level

@export var soul_scenes : Array[PackedScene]

@onready var dock: Dock = $Dock
@onready var soul_generation_timer: Timer = $SoulGenerationTimer
@onready var play_grid: PlayGrid = $Boat/PlayGrid

func _level_ready():	
	while dock.add_soul(generate_new_soul()):
		print("New soul added to dock")

func generate_new_soul() -> Soul:
	var new_soul = soul_scenes.pick_random().instantiate()
	return new_soul

func _on_soul_generation_timer_timeout() -> void:
	dock.add_soul(generate_new_soul())


func _on_next_button_pressed() -> void:
	play_grid.clear_souls()

extends Level

@export var soul_scenes : Array[PackedScene]

@onready var dock: Dock = $Dock
@onready var soul_generation_timer: Timer = $SoulGenerationTimer
@onready var play_grid: PlayGrid = $Boat/PlayGrid
@onready var soul_pickup: Marker2D = $SoulPickup
@onready var boat: Boat = $Boat
@onready var next_button: Button = $NextButton

func _level_ready():
	while dock.add_soul(generate_new_soul()):
		print("New soul added to dock")

func generate_new_soul() -> Soul:
	var new_soul = soul_scenes.pick_random().instantiate()
	return new_soul

func _on_soul_generation_timer_timeout() -> void:
	dock.add_soul(generate_new_soul())

func _on_next_button_pressed() -> void:
	next_button.hide()
	boat.stop_point = null

func _on_play_grid_soul_added() -> void:
	next_button.show()

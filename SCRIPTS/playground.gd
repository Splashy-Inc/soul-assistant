extends Level

@export var soul_scenes : Array[PackedScene]

@onready var dock: Dock = $Dock
@onready var soul_generation_timer: Timer = $SoulGenerationTimer
@onready var play_grid: PlayGrid = $Boat/PlayGrid
@onready var soul_pickup: Marker2D = $SoulPickup
@onready var boat: Boat = $Boat
@onready var next_button: Button = $Boat/NextButton

var money := 0

func _level_ready():
	pass

func generate_new_soul() -> Soul:
	var new_soul := soul_scenes.pick_random().instantiate() as Soul
	new_soul.rotation_degrees = snapped(randi_range(0, 270), 90)
	return new_soul

func _on_soul_generation_timer_timeout() -> void:
	dock.add_soul(generate_new_soul())

func _on_next_button_pressed() -> void:
	next_button.hide()
	if boat.stop_point is SoulDropoff:
		boat.stop_point = soul_pickup
		boat.travel_to_stop_point()
	else:
		boat.stop_point = null

func _on_play_grid_soul_added() -> void:
	next_button.show()

func _on_boat_stopped() -> void:
	if boat.stop_point is SoulDropoff:
		soul_generation_timer.stop()
		dock.clear_souls()
		next_button.show()
	else:
		soul_generation_timer.start()

func _on_river_bank_money_generated(amount: int) -> void:
	money += amount
	Globals.info_updated.emit(money)
	

extends Level

@export var soul_scenes : Array[PackedScene]

@onready var dock: Dock = $Dock
@onready var soul_generation_timer: Timer = $SoulGenerationTimer
@onready var play_grid: PlayGrid = $Boat/PlayGrid
@onready var soul_pickup: Marker2D = $SoulPickup
@onready var boat: Boat = $Boat
@onready var next_button: Button = $Boat/NextButton

var money := 0
@export var money_goal := 100

func _level_ready():
	Globals.game_over.connect(_on_game_over)

func generate_new_soul() -> Soul:
	var new_soul := soul_scenes.pick_random().instantiate() as Soul
	new_soul.rotation_degrees = snapped(randi_range(0, 270), 90)
	return new_soul

func _on_soul_generation_timer_timeout() -> void:
	dock.add_soul(generate_new_soul())

func _on_next_button_pressed() -> void:
	next_button.hide()
	if boat.stop_point is SoulDropoff:
		boat.change_helper_text("pickup")
		boat.stop_point = soul_pickup
		boat.travel_to_stop_point()
	else:
		boat.change_helper_text("rowing")
		boat.stop_point = null

func _on_play_grid_soul_added() -> void:
	next_button.text = "Cross the River Styx"
	next_button.show()

func _on_boat_stopped() -> void:
	if boat.stop_point is SoulDropoff:
		soul_generation_timer.stop()
		dock.clear_souls()
	else:
		soul_generation_timer.start()

func _on_river_bank_money_generated(amount: int) -> void:
	money += amount
	Globals.info_updated.emit(money)

func _on_game_over():
	Globals.money = money
	Globals.money_goal = money_goal
	if money >= money_goal:
		won.emit()
	else:
		lost.emit()

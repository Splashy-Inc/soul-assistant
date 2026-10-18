extends Label

@export var remaining_seconds := 180
@onready var tick: Timer = $Tick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tick.timeout.connect(_on_timer_timeout)
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	_update_time()
	tick.start()

func stop():
	tick.stop()
	Globals.game_over.emit()

func _on_timer_timeout() -> void:
	remaining_seconds = clamp(remaining_seconds - 1, 0, remaining_seconds)
	_update_time()
	if remaining_seconds <= 0:
		stop()

func _update_time():
	text = time_string_from_seconds(remaining_seconds)
	
static func time_string_from_seconds(new_seconds: int):
	var minutes = int(new_seconds / 60)
	var seconds = new_seconds % 60
	
	var min_str = str(minutes)
	var sec_str = str(seconds)
	
	if minutes < 10:
		min_str = "0" + str(minutes)
	if seconds < 10:
		sec_str = "0" + str(seconds)

	return min_str + ":" + sec_str

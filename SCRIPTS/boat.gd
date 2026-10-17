extends RigidBody2D

class_name Boat

@export var speed := 0.0
@export var deceleration := 100.0
@export var max_speed := 500.0
@export var presses_to_max_speed := 4

var acceleration := max_speed/presses_to_max_speed

var row_left := false
@export var stop_point : StopPoint
@onready var camera: Camera2D = $Camera2D
@onready var speed_meter: TextureProgressBar = $SpeedMeter
@onready var mobile_controls: MobileControls = $MobileControls
@onready var row_indicators: Node2D = $RowIndicators
@onready var left: Sprite2D = $RowIndicators/Left
@onready var right: Sprite2D = $RowIndicators/Right

# TODO: Add mobile control check to only show on mobile devices
func _process(delta: float) -> void:
	if row_left:
		left.modulate.a = 1
		right.modulate.a = .25
	else:
		left.modulate.a = .25
		right.modulate.a = 1
	
	if is_instance_valid(stop_point):
		row_indicators.hide()
		speed_meter.hide()
		#mobile_controls.hide()
		var distance_to_stop = global_position.distance_to(stop_point.global_position)
		if distance_to_stop > 10:
			speed = clampf(lerpf(speed, 0, .1 * delta), min(256, distance_to_stop), lerpf(speed, distance_to_stop, .1))
			print(speed, distance_to_stop)
		else:
			global_position = stop_point.global_position
			speed = 0
		camera.offset.x = lerpf(camera.offset.x, stop_point.camera_offset.x, .1)
	else:
		row_indicators.show()
		speed_meter.show()
		#mobile_controls.show()
		camera.offset.x = lerpf(camera.offset.x, 0, .1)
		speed = clampf(speed - deceleration * delta, 0, max_speed)
	
	linear_velocity.x = speed
	speed_meter.value = speed/max_speed * 100.0

func _unhandled_input(event: InputEvent) -> void:
	if not is_instance_valid(stop_point):
		if event.is_action_pressed("row_left") and row_left:
			speed += acceleration
			row_left = false
		elif event.is_action_pressed("row_right") and not row_left:
			speed += acceleration
			row_left = true

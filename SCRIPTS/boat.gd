extends RigidBody2D

class_name Boat

@export var speed := 0.0
@export var deceleration := 100.0
@export var max_speed := 500.0
@export var presses_to_max_speed := 2

var acceleration := max_speed/presses_to_max_speed

var row_left := false
var stop_point : Marker2D

func _process(delta: float) -> void:
	if is_instance_valid(stop_point):
		if global_position.distance_to(stop_point.global_position) < 10:
			global_position = stop_point.global_position
			speed = 0
	else:
		speed = clamp(speed - deceleration * delta, 0, max_speed)
	
	linear_velocity.x = speed

func _unhandled_input(event: InputEvent) -> void:
	if not is_instance_valid(stop_point):
		if event.is_action_pressed("row_left") and row_left:
			speed += acceleration
		elif event.is_action_pressed("row_right") and not row_left:
			speed += acceleration

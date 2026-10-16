extends Area2D

class_name Soul

var dragging := false
var offset : Vector2
var boat : Node2D
var boat_offset : Vector2

func _process(delta: float) -> void:
	if dragging:
		if Input.is_action_pressed("click"):
			global_position = get_viewport().get_mouse_position() - offset
			if is_instance_valid(boat):
				global_position = Vector2(snappedf(global_position.x, 128), snapped(global_position.y, 128)) + boat_offset
		else:
			dragging = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		offset = to_local(get_viewport().get_mouse_position())
		dragging = true

func _on_body_entered(body: Node2D) -> void:
	boat = body
	boat_offset = Vector2(boat.global_position.x - snappedf(boat.global_position.x, 128), boat.global_position.y - snappedf(boat.global_position.y, 128))
	print(boat_offset)
func _on_body_exited(body: Node2D) -> void:
	boat = null

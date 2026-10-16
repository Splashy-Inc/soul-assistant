extends Area2D

var dragging := false
var offset : Vector2
var boat : Node2D

func _process(delta: float) -> void:
	if dragging:
		if Input.is_action_pressed("click"):
			global_position = get_viewport().get_mouse_position() - offset
		else:
			dragging = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		offset = to_local(get_viewport().get_mouse_position())
		dragging = true

func _on_body_entered(body: Node2D) -> void:
	boat = body


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

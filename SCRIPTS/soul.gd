extends Area2D

class_name Soul

signal clicked

var dragging := false
var boat : Node2D
var boat_offset : Vector2
@export var starting_slot : Marker2D
var blocking_boundaries : Array[Node2D]
var blocking_souls : Array[Soul]
var invalid_modulate := Color(0.322, 0.322, 0.322, 1.0)
@onready var center: Marker2D = $Center
@onready var pickup_sound: AudioStreamPlayer = $PickupSound
@onready var dropoff_sound: AudioStreamPlayer = $DropoffSound
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $Center/VisibleOnScreenNotifier2D
var offloading := false
var speed := 200.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_body_entered)
	area_exited.connect(_on_body_exited)
	input_event.connect(_on_input_event)
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)

func _process(delta: float) -> void:
	if dragging:
		if Input.is_action_pressed("click"):
			if is_instance_valid(starting_slot):
				global_position = get_viewport().get_mouse_position() - center.position * scale.x
				if is_instance_valid(boat) and blocking_boundaries.is_empty():
					global_position = Vector2(snappedf(global_position.x, 128), snapped(global_position.y, 128)) + boat_offset
					if not blocking_souls.is_empty():
						modulate = invalid_modulate
					else:
						modulate = Color(1.0, 1.0, 1.0, 1.0)
		else:
			dragging = false
			modulate = Color(1.0, 1.0, 1.0, 1.0)
			if not is_instance_valid(boat) or not blocking_souls.is_empty() or not blocking_boundaries.is_empty():
				position = Vector2.ZERO
			else:
				boat.add_soul(self)
				modulate.a = .75
				starting_slot = null
	elif offloading:
		global_position.x += speed * delta

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not offloading:
		if event.is_action_pressed("click"):
			if get_parent() is PlayGrid:
				clicked.emit(self)
			else:
				dragging = true
				pickup_sound.play()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayGrid:
		boat = body
		boat_offset = Vector2(boat.global_position.x - snappedf(boat.global_position.x, 128), boat.global_position.y - snappedf(boat.global_position.y, 128))
	elif body is Soul:
		blocking_souls.append(body)
	else:
		blocking_boundaries.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body in blocking_boundaries:
		blocking_boundaries.erase(body)
	if body is Soul and body in blocking_souls:
		blocking_souls.erase(body)
	if body is PlayGrid:
		boat = null

func _on_area_entered(area: Area2D) -> void:
	_on_body_entered(area)

func _on_area_exited(area: Area2D) -> void:
	_on_body_exited(area)

func offload():
	offloading = true
	dropoff_sound.play()

func _on_screen_exited() -> void:
	if offloading:
		queue_free()

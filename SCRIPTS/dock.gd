extends Node2D

class_name Dock

@export var slots : Array[Marker2D]

func _ready() -> void:
	for slot in slots:
		for child in slot.get_children():
			child.free()

func add_soul(new_soul: Soul) -> bool:
	for slot in slots:
		if slot.get_children().is_empty():
			if is_instance_valid(new_soul.get_parent()):
				new_soul.reparent(slot)
			else:
				slot.add_child(new_soul)
			
			new_soul.starting_slot = slot
			return true
	return false

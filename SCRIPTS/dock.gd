extends Node2D

class_name Dock

@export var slots : Array[Marker2D]
@onready var soul_preview: Marker2D = $SoulPreview

func _ready() -> void:
	for slot in slots:
		for child in slot.get_children():
			child.free()

func add_soul(new_soul: Soul) -> bool:
	for slot in slots:
		if slot.get_children().is_empty():
			if not soul_preview.get_children().is_empty() and  soul_preview.get_child(0) is Soul:
				var preview_child = soul_preview.get_child(0)
				preview_child.reparent(slot, false)
				preview_child.starting_slot = slot
			else:
				if is_instance_valid(new_soul.get_parent()):
					new_soul.reparent(slot)
				else:
					slot.add_child(new_soul)
				new_soul.starting_slot = slot
				return true
		
		if soul_preview.get_children().is_empty():
			if is_instance_valid(new_soul.get_parent()):
				new_soul.reparent(soul_preview)
			else:
				soul_preview.add_child(new_soul)
			return true
	return false

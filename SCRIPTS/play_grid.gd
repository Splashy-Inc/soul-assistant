extends TileMapLayer

class_name PlayGrid

signal soul_added

func clear_souls():
	for child in get_children():
		child.free()

func add_soul(new_soul: Soul):
	new_soul.reparent(self)
	soul_added.emit()

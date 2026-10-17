extends TileMapLayer

class_name PlayGrid

signal soul_added
signal soul_clicked(soul: Soul)

func clear_souls():
	for child in get_children():
		child.free()

func add_soul(new_soul: Soul):
	new_soul.reparent(self)
	new_soul.clicked.connect(_on_soul_clicked)
	soul_added.emit()

func _on_soul_clicked(soul: Soul):
	soul_clicked.emit(soul)

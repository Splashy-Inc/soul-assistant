extends TileMapLayer

class_name PlayGrid

func clear_souls():
	for child in get_children():
		child.free()

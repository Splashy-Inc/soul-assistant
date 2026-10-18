extends Marker2D

class_name DropoffStart

@export var money_scene : PackedScene
@onready var money_spawn: Marker2D = $MoneySpawn

func get_money(amount: int):
	var new_money = money_scene.instantiate() as Money
	money_spawn.add_child(new_money)
	new_money.initialize(amount)

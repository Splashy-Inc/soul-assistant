extends Sprite2D

class_name Money

@export var amount: Label
@export var animation_player: AnimationPlayer

func _ready() -> void:
	hide()

func initialize(new_amount: int):
	amount.text = str(new_amount)
	show()
	animation_player.play("get")

func die():
	queue_free()

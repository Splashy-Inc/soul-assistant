extends Area2D

class_name RiverBank

signal money_generated(amount: int)

@onready var soul_dropoff: StopPoint = $SoulDropoff
@onready var dropoff_start: DropoffStart = $DropoffStart

func _on_body_entered(body: Node2D) -> void:
	if body is Boat:
		body.change_helper_text("dropoff")
		body.stop_point = soul_dropoff

func offload_soul(soul: Soul):
	soul.reparent(dropoff_start, false)
	soul.position = -soul.center.position
	soul.offload()
	dropoff_start.get_money(soul.money)
	money_generated.emit(soul.money)

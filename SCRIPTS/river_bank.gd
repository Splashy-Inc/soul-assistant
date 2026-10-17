extends Area2D

class_name RiverBank

@onready var soul_dropoff: StopPoint = $SoulDropoff

func _on_body_entered(body: Node2D) -> void:
	if body is Boat:
		body.stop_point = soul_dropoff

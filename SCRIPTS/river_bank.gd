extends Area2D

class_name RiverBank

@onready var marker_2d: Marker2D = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body is Boat:
		body.stop_point = marker_2d

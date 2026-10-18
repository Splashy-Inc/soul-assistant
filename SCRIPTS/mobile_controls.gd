extends Control

class_name MobileControls

@onready var button_left: TouchScreenButton = $Button1
@onready var button_right: TouchScreenButton = $Button2
@onready var left_animation: AnimationPlayer = $Button1/AnimationPlayer
@onready var right_animation: AnimationPlayer = $Button2/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

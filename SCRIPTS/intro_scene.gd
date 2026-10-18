extends Control

class_name IntroScene

signal intro_ended

@export var part_1_dialog_data : DialogData
@export var part_2_dialog_data : DialogData

var scene := 1

@onready var dialog_box: DialogBox = $DialogBox
@onready var part_2: TextureRect = $Part2

func start_dialog():
	scene = 1
	part_2.hide()
	dialog_box.dialog_data = part_1_dialog_data
	dialog_box.initialize()

func _on_dialog_box_dialog_ended() -> void:
	if scene <= 1:
		part_2.show()
		scene += 1
		dialog_box.dialog_data = part_2_dialog_data
		dialog_box.initialize()
	else:
		dialog_box.hide()
		intro_ended.emit()

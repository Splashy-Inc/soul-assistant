extends UIButton

class_name DialogButton

@export var action_type := Dialog_button_action_type.ADVANCE

enum Dialog_button_action_type {
	ADVANCE,
	SKIP,
	CUSTOM,
}

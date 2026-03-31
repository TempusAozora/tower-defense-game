extends Camera2D

@export var min_zoom := 1.0
@export var max_zoom := 2.0
@export var smoothing_speed := 5

var is_pressed := false
var current_zoom := 1.0

func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = smoothing_speed
 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_pressed:
		global_position += -event.get_screen_relative() / current_zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_MIDDLE:
			is_pressed = event.pressed
		
		print(is_pressed)
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			current_zoom += 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			current_zoom -= 0.1
			
		current_zoom = clamp(current_zoom, min_zoom, max_zoom)
		zoom = Vector2.ONE * current_zoom
		
		

extends Node2D

@export var tile_size: int = 50
@export var grid_size: PackedInt32Array = [10, 10]
@onready var preview: Sprite2D = $Preview

var dragged_item
@onready var on_drag_mode = false :
	set(state):
		on_drag_mode = state
		dragged_item = get_viewport().gui_get_drag_data()

func _ready() -> void:
	z_index = 10 + floor(global_position.y/100)

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		
		on_drag_mode = true
	elif what == Node.NOTIFICATION_DRAG_END:
		on_drag_mode = false
		
func _process(delta: float) -> void:
	if on_drag_mode:
		if !preview.texture:
			preview.texture = dragged_item.icon.texture
		var pos = get_global_mouse_position()
		preview.global_position = Vector2(floor(pos.x / tile_size) * tile_size, floor(pos.y / tile_size) * tile_size)
		print(pos)
	else:
		preview.texture = null
	

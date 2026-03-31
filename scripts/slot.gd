extends Panel

@onready var icon: TextureRect = $icon
@onready var qnty: Label = $quantity
var tower: Tower :
	set(t):
		tower = t
		update_ui()

func _ready() -> void:
	var ingame_data = JsonData.ingame_data
	var slot_data: Dictionary = ingame_data["hotbar"][get_index()]
	if slot_data.has("tower_id"):
		var tower_data = JsonData.get_tower_by_id(int(slot_data["tower_id"])).duplicate()
		tower_data.quantity = slot_data.quantity
		tower = tower_data
		
func update_ui() -> void:
	if tower:
		icon.texture = tower.tower_texture
		qnty.text = str(tower.quantity)
		tooltip_text = tower.tower_name + "\n\n" + tower.description
		icon.show()
		qnty.show()
	else:
		icon.texture = null
		tooltip_text = ""
		qnty.text = "0"
		qnty.hide()
	
func _get_drag_data(at_position: Vector2) -> Variant:
	if icon.texture == null:
		return
	
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	
	preview.position -= size / 2.0
	preview.modulate = Color(preview.modulate, 0.5)
	preview.self_modulate = Color.TRANSPARENT
	preview.get_node("quantity").hide()
	
	icon.hide()
	qnty.hide()
	
	set_drag_preview(c)
	return self
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var tmp = tower
	tower = data.tower
	data.tower = tmp

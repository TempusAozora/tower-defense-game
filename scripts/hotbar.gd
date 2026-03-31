extends Control

var dragged_item = null

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		dragged_item = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if dragged_item:
				dragged_item.icon.show()
				dragged_item.qnty.show()
				dragged_item = null

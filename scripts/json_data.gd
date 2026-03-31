extends Node

var ingame_data: Dictionary
var tower_dictionary: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ingame_data = load_ingame_data("res://data/ingame_data.json")
	tower_dictionary = load_tower_dictionary()

func load_tower_dictionary() -> Dictionary:
	var dictionary = {}
	var towers_directory = "res://towers/"
	var dir = DirAccess.open(towers_directory)
	if !dir:
		push_error('"towers" directory not found')
		
	for file_name in dir.get_files():
		if !file_name.ends_with(".tres"):
			continue
		var path = towers_directory + file_name
		var resource: Tower = ResourceLoader.load(path)
		dictionary[resource.tower_id] = resource
		
	return dictionary

func load_ingame_data(path) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)
	
func get_tower_by_id(id) -> Tower:
	return tower_dictionary[id]

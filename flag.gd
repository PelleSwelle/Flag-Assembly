extends Node

var flagPieceNode
var flagPieces = []
var parser = XMLParser.new()

func _ready() -> void:
	flagPieceNode = load("res://flagPiece.tscn")
	# load_pieces('saintKittsAndNevis')
	readFlagAsXML('saintKittsAndNevis')	

	# instantiate_flag()
	
func load_pieces(countryName: String):
	var path = "res://Flags/" + countryName
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		
		while fileName != '':
			if dir.current_is_dir():
				pass
			else:
				var current_dir = dir.get_current_dir()
				var fullPath = current_dir +'/' + fileName
				
				if !fullPath.contains('.import'):
					var baseName = fileName.trim_suffix('.svg')
					
					flagPieces.append(load(fullPath))
				
			fileName = dir.get_next()
			
	else:
		printerr("an error occured trying to access the path")


func readFlagAsXML(flag: String):
	parser.open("res://Flags/saintKittsAndNevis/Sami_flag.svg")

	var inc = 0
	while parser.read() != ERR_FILE_EOF:
		inc += 1
		if parser.get_node_type() == XMLParser.NODE_ELEMENT:
			var node_name = parser.get_node_name()
			var attributes_dict = {}
			
			for idx in range(parser.get_attribute_count()):
				var attribute_name = parser.get_attribute_name(idx)
				attributes_dict[attribute_name] = parser.get_attribute_value(idx)
			
			if node_name == "rect" or node_name == "circle" or node_name == "path":
				var position = Vector2()
				var rotation = 0.0
				
				if attributes_dict.has("x") and attributes_dict.has("y"):
					position = Vector2(attributes_dict["x"].to_float(), attributes_dict["y"].to_float())
				elif attributes_dict.has("cx") and attributes_dict.has("cy"):
					position = Vector2(attributes_dict["cx"].to_float(), attributes_dict["cy"].to_float())
				
				if attributes_dict.has("transform"):
					var transform_str = attributes_dict["transform"]
					var transform_data = parse_transform(transform_str)
					position += transform_data.position
					rotation = transform_data.rotation
				
				print("Element: ", node_name, " Position: ", position, " Rotation: ", rotation)

func parse_transform(transform_str: String) -> Dictionary:
	var transform_data = {"position": Vector2(), "rotation": 0.0}
	var regex_translate = RegEx.new()
	regex_translate.compile("translate\\(([^\\)]+)\\)")
	var regex_rotate = RegEx.new()
	regex_rotate.compile("rotate\\(([^\\)]+)\\)")
	
	var translate_match = regex_translate.search(transform_str)
	if translate_match:
		var translate_values = translate_match.get_string(1).split(",")
		transform_data["position"] = Vector2(translate_values[0].to_float(), translate_values[1].to_float())
	
	var rotate_match = regex_rotate.search(transform_str)
	if rotate_match:
		transform_data["rotation"] = deg_to_rad(rotate_match.get_string(1).to_float())
	
	return transform_data

func instantiate_flag():
	for piece in flagPieces:
		var node = flagPieceNode.instantiate()
		node.get_node('Sprite2D').texture = piece
		
		add_child(node)

func _process(delta: float) -> void:
	pass

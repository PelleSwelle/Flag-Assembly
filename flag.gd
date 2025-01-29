extends Node

var flagPieceNode
var flagPieces = []
var parser = XMLParser.new()

func _ready() -> void:
	flagPieceNode = load("res://flagPiece.tscn")
	# load_pieces('saintKittsAndNevis')
	parser.open("res://Flags/saintKittsAndNevis/Flag_of_Saint_Kitts_and_Nevis.svg")

	while parser.read() != ERR_FILE_EOF:
		if parser.get_node_type() == XMLParser.NODE_ELEMENT:
			var node_name = parser.get_node_name()
			var attributes_dict = {}
			for idx in range(parser.get_attribute_count()):
				attributes_dict[parser.get_attribute_name(idx)] = parser.get_attribute_value(idx)
			print("The ", node_name, " element has the following attributes: ", attributes_dict)
			

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

func instantiate_flag():
	for piece in flagPieces:
		var node = flagPieceNode.instantiate()
		node.get_node('Sprite2D').texture = piece
		
		add_child(node)

func _process(delta: float) -> void:
	pass
extends Node2D

var flagPieces = []

var flagNode

var flag

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flagNode = load("res://flag.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("loadFlag"):
		flag = flagNode.instantiate()
		add_child(flag)
		
		# instantiate_flag()
		

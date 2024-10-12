extends Node

var held_object = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)

func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('left_click'):
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_screen_velocity())
			held_object = null

# this is a comment
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("i am hovering")

signal clicked

var held = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		clicked.emit(self)

func _physics_process(delta: float) -> void:
	if (held):
		global_transform.origin = get_global_mouse_position()

func pickup():
	print('pick up')
	if held:
		return
	freeze = true
	held = true

func drop(impulse=Vector2.ZERO):
	if (held):
		freeze = false
		apply_central_impulse(impulse)
		held = false

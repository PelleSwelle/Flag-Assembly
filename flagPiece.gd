extends RigidBody2D

var lifted = false;
var position_label
var rotation_label
var goalArea
var isGrabbed = false

const SPRING_CONSTANT := 30.0
var position_string = "X: %s Y: %s"
var rotation_string = "rotation: %s"

func _ready() -> void:
#	load sprites
#	generate collision shapes
	position_label = Label.new()
	rotation_label = Label.new()
	goalArea = get_node("goalArea");
	self.gravity_scale = 0
	self.add_child(position_label)
	
func _process(delta: float) -> void:
	position_label.text = position_string % [position.x, position.y]
	rotation_label.text = rotation_string % [rotation]
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_action_pressed("select"):
				if self.get_global_mouse_position().distance_to(self.position) < 40:  # Adjust the distance threshold as needed
					isGrabbed = true
			elif event.is_action_released("select"):
				isGrabbed = false

func _physics_process(delta):
	if isGrabbed:
		self.position = get_global_mouse_position()

func _on_goal_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	self.gravity_scale = 0

func _on_goal_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	self.gravity_scale = 1

# func _physics_process(delta):
# 	for piece in flagPieces:
# 		var pieceScript = piece.get_node('flagPiece')
# 		if (Input.is_action_just_pressed("select")):
# 			pieceScript.isGrabbed = true
# 		if (Input.is_action_just_released("select")):
# 			pieceScript.isGrabbed = false
extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		offset.y -= 1
	elif Input.is_action_pressed("move_down"):
		offset.y += 1
	
	if Input.is_action_pressed("move_left"):
		offset.x -= 1
	elif Input.is_action_pressed("move_right"):
		offset.x += 1
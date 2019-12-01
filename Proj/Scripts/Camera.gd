extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 4

var motion = Vector2(0,0)
signal on_camera_move(motion)

# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		motion.y = -speed
	elif Input.is_action_pressed("move_down"):
		motion.y = speed
	else:
		motion.y = 0
		
	if Input.is_action_pressed("move_left"):
		motion.x = -speed
	elif Input.is_action_pressed("move_right"):
		motion.x = speed
	else:
		motion.x = 0
	
	if motion != Vector2.ZERO:
		offset += motion
		emit_signal("on_camera_move", motion)

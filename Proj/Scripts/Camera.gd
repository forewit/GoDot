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
		motion.y -= 0 if (motion.y < -5) else 0.1
	elif Input.is_action_pressed("move_down"):
		motion.y += 0 if (motion.y > 5) else 0.1
	else:
		motion.y = 0
	
	if Input.is_action_pressed("move_left"):
		motion.x -= 0 if (motion.x < -5) else 0.1
	elif Input.is_action_pressed("move_right"):
		motion.x += 0 if (motion.x > 5) else 0.1
	else:
		motion.x = 0
	
	offset += motion
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
		position.x += motion.x
		position.y += motion.y
		emit_signal("on_camera_move", motion)
		

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCREMENT = 0.05

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

func _input(event):
	if event.is_action_pressed("cam_drag"):
		_drag = true
	elif event.is_action_released("cam_drag"):
		_drag = false
	elif event.is_action("cam_zoom_in"):
		_update_zoom(-ZOOM_INCREMENT, get_local_mouse_position())
	elif event.is_action("cam_zoom_out"):
		_update_zoom(ZOOM_INCREMENT, get_local_mouse_position())
	elif event is InputEventMouseMotion && _drag:
		set_position(get_position() - event.relative*_current_zoom_level)
		emit_signal("moved")

func _update_zoom(incr, zoom_anchor):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	if _current_zoom_level < MAX_ZOOM_LEVEL:
		_current_zoom_level = MAX_ZOOM_LEVEL
	elif _current_zoom_level > MIN_ZOOM_LEVEL:
		_current_zoom_level = MIN_ZOOM_LEVEL
	if old_zoom == _current_zoom_level:
		return
	
	var zoom_center = zoom_anchor - get_position()
	var ratio = 1-_current_zoom_level/old_zoom
	set_position(get_position() + zoom_center*ratio)
	
	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")
	print("zoomed")

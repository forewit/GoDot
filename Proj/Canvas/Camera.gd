extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_zoom = 0.5
export var min_zoom = 4.0
export var zoom_increment = 0.05
export var speed = 4

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

func _physics_process(delta):
	var motion = Vector2(0, 0)
	if Input.is_action_pressed("ui_up"):
		motion.y = -speed
	elif Input.is_action_pressed("ui_down"):
		motion.y = speed
	else:
		motion.y = 0
		
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed
	else:
		motion.x = 0
	
	if motion != Vector2.ZERO:
		position.x += motion.x
		position.y += motion.y
		emit_signal("moved")

func _input(event):
	if event.is_action_pressed("cam_drag"):
		_drag = true
	elif event.is_action_released("cam_drag"):
		_drag = false
	elif event.is_action("cam_zoom_in"):
		_update_zoom(-zoom_increment, get_local_mouse_position())
	elif event.is_action("cam_zoom_out"):
		_update_zoom(zoom_increment, get_local_mouse_position())
	elif event is InputEventMouseMotion && _drag:
		set_offset(get_offset() - event.relative*_current_zoom_level)
		emit_signal("moved")

func _update_zoom(incr, zoom_anchor):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	if _current_zoom_level < max_zoom:
		_current_zoom_level = max_zoom
	elif _current_zoom_level > min_zoom:
		_current_zoom_level = min_zoom
	if old_zoom == _current_zoom_level:
		return
	
	var zoom_center = zoom_anchor - get_offset()
	var ratio = 1-_current_zoom_level/old_zoom
	set_offset(get_offset() + zoom_center*ratio)
	
	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")

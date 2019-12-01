extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var grid_size = 100
export var color = Color(100, 100, 100, 100)

onready var camera = get_node("../../Camera")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.connect("on_camera_move", self, "_on_camera_move")
	set_process(true)

func _draw():
	var screen_size = get_viewport().size
	var x = 0
	var y = 0
	
	for i in range(-1, 3 + (screen_size.x / grid_size)):
		x = (i * grid_size) + position.x
		draw_line(Vector2(x, -grid_size), Vector2(x, screen_size.y + grid_size), color)
	
	for i in range(-1, 3 + (screen_size.y / grid_size)):
		y = i * grid_size + position.y
		draw_line(Vector2(-grid_size, y), Vector2(screen_size.x + grid_size, y), color)

func _on_camera_move(motion):
	if motion.x != 0:
		position.x = int(position.x - motion.x) % grid_size
	if motion.y != 0:
		position.y = int(position.y - motion.y) % grid_size
	update()
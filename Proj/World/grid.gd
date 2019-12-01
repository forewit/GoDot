extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cell_size = 100
export var color = Color(100, 100, 100, 100)

onready var camera = get_node("../../Camera")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.connect("on_camera_move", self, "_on_camera_move")
	set_process(true)

func _draw():
	var screen_size = get_viewport().size * camera.zoom
	var quad_size = Vector2(screen_size.x/2, screen_size.y/2)
	var x = 0
	var y = 0
	
	for i in range(-1, 3 + (screen_size.x / cell_size)):
		x = (i * cell_size) + position.x - quad_size.x
		draw_line(Vector2(x, - cell_size - quad_size.y), Vector2(x, quad_size.y + cell_size), color)
	
	for i in range(-1, 3 + (screen_size.y / cell_size)):
		y = (i * cell_size) + position.y - quad_size.y
		draw_line(Vector2(- cell_size - quad_size.x, y), Vector2(screen_size.x + cell_size, y), color)

func _on_camera_move(motion):
	if motion.x != 0:
		position.x = int(position.x - motion.x) % cell_size
	if motion.y != 0:
		position.y = int(position.y - motion.y) % cell_size
	update()
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
	# number of grid lines per quadrant
	var screen_quad = get_viewport().size * camera.zoom / 2.0
	var grid_quad = (screen_quad / cell_size).round()
	var x = 0.0
	var y = 0.0
	
	y = screen_quad.y + cell_size
	draw_line(Vector2(0, y), Vector2(0, -y), Color(255,0,0))
	for i in range(1, grid_quad.x + 2):
		x = i * cell_size
		draw_line(Vector2(x, y), Vector2(x, -y), color)
		draw_line(Vector2(-x, y), Vector2(-x, -y), color)
	
	x = screen_quad.x + cell_size
	draw_line(Vector2(x, 0), Vector2(-x, 0), Color(255,0,0))
	for i in range(1, grid_quad.y + 2):
		y = i * cell_size
		draw_line(Vector2(x, y), Vector2(-x, y), color)
		draw_line(Vector2(x, -y), Vector2(-x, -y), color)

func _on_camera_move(motion):
	if motion.x != 0:
		position.x = fmod(position.x - motion.x, cell_size)
	if motion.y != 0:
		position.y = fmod(position.y - motion.y, cell_size)
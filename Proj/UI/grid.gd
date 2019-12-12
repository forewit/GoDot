extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cell_size = 100
export var color = Color(100, 100, 100, 100)

onready var camera = get_node("../Camera")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.connect("moved", self, "_on_camera_move")
	camera.connect("zoomed", self, "_on_camera_zoom")
	set_process(true)

func _draw():
	# number of grid lines per quadrant
	var screen_quad = get_viewport().size * camera.get_zoom() / 2.0
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

func _on_camera_move():
	var x_offset = camera.get_position().x  + camera.get_offset().x
	var y_offset = camera.get_position().y  + camera.get_offset().y
	
	position.x = x_offset - fmod(x_offset, cell_size)
	position.y = y_offset - fmod(y_offset, cell_size)

func _on_camera_zoom():
	_on_camera_move()
	update()
extends Node2D

@export_category("Honeycomb Properties")
@export var honeycomb_size: int
@export var honeycomb_array: Array[Array]

# Import Cell scene
const CELL_SCENE: Object = preload("res://models/Cell.tscn")

# Set up board position
const TOP_CELL_POSITION: Vector2 = Vector2(1176, 330.75)

# Cell dimensions in pixels
const CELL_WIDTH = 186 # 196 is the total width including black border
const CELL_HEIGHT = 158 # 168 is the total height including black border


# Honeycomb methods
func set_honeycomb_size(size: int) -> void:
	self.honeycomb_size = size

func get_honeycomb_size() -> int:
	return self.honeycomb_size

func generate_honeycomb_array() -> void:
	var cell_array: Array[Array] = []
	var board_size: int = self.honeycomb_size
	for i in range(board_size):
		cell_array.append([])
		for j in range(board_size):
			var cell_properties: Dictionary = {
				"cell_value": randi_range(0,3),
				"cell_color": randi_range(0,1) # 0: Yellow, 1: Orange
			} 
			cell_array[i].append(cell_properties)
	self.honeycomb_array = cell_array


func display_honeycomb(top_cell_position: Vector2) -> void:
	var current_cell_position: Vector2 = top_cell_position
	for i in range(self.honeycomb_size):
		for j in range(self.honeycomb_size):
			var current_cell_properties: Dictionary = self.honeycomb_array[i][j]
			var current_cell: Cell = create_cell(
				current_cell_properties["cell_value"],
				current_cell_properties["cell_color"],
				current_cell_position
			)
			add_child(current_cell)
			current_cell_position += Vector2(self.CELL_WIDTH * 0.75, self.CELL_HEIGHT * 0.5)
		current_cell_position = top_cell_position + ((i+1) * Vector2( -self.CELL_WIDTH * 0.75, self.CELL_HEIGHT * 0.5))


func create_cell(cell_value: int, cell_color: int, cell_position: Vector2) -> Cell:
	var cell: Cell =  CELL_SCENE.instantiate()
	cell.set_cell_value(cell_value)
	match cell_color:
		0 : cell.set_cell_color(cell.CellColor.YELLOW)
		1 : cell.set_cell_color(cell.CellColor.ORANGE)
	cell.set_cell_position(cell_position)
	cell.set_cell_controller(cell.CellController.COMPUTER)
	return cell


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	set_honeycomb_size(2)
#	generate_honeycomb_array()
#	display_honeycomb(self.TOP_CELL_POSITION)
	
	set_honeycomb_size(3)
	generate_board_array()
	print_rich(honeycomb_array)


# ********************************Experimental Section********************************
func generate_2D_array(size: int) -> Array[Array]:
	var arr: Array[Array] = []
	for i in range(size):
		arr.append([])
		for j in range(size):
			arr[i].append(null)
	return arr

func has_top_neighbor(cell_index: Vector2) -> bool:
	var i: int = int(cell_index.x) - 1
	var j: int = int(cell_index.y) - 1
	if (i < 0 or j < 0):
		return false
	return true


# Correct traversal set up [DO NOT DELETE]
func generate_board_array() -> void:
	var board_size: int = self.honeycomb_size
	var cell_array: Array[Array] = generate_2D_array(board_size)
	var vertical_rows: int = 2*board_size - 1
	var center_row: int = int(vertical_rows * 0.5)
	# Top half of the honeycomb
	for row in range(center_row + 1):
		print("row: "+str(row))
		for k in range(row + 1):
			var i: int = row - k
			var j: int = k
			cell_array[i][j] = 1
			print("i: "+str(i))
			print("j: "+str(j))
			print("------------")
	# Bottom half of the honeycomb
	for row in range(center_row + 1, vertical_rows):
		print("row: "+str(row))
	self.honeycomb_array = cell_array


#func generate_solved_board() -> void :
#	var board_size: int = honeycomb_size
#	var cell_array: Array[Array] = generate_2D_array(board_size)
#	for row in range(board_size*2 - 1):
#		for i in range(board_size):
#			for j in range(board_size):
#				if (i+j==row):
#					match row:
#						0:
#							var cell_properties: Dictionary = {
#								"cell_value": randi_range(0,3),
#								"cell_color": randi_range(0,1) # 0: Yellow, 1: Orange
#							}
#					pass

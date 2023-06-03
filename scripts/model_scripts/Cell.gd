extends Node2D

enum CellColor { YELLOW, ORANGE, GRAY }
enum CellController { COMPUTER, PLAYER }

# Properties
@export var cell_value: int
@export var cell_color: CellColor
@export var cell_position: Vector2
@export var cell_controller: CellController


# Set Methods
func set_cell_value(value: int):
	if value >= 0 and value <= 3:
		cell_value = value
		$BrownNumbers.frame = cell_value
		$WhiteNumbers.frame = cell_value
	else:
		print("Invalid cell value. Only 0, 1, 2, or 3 are allowed.")

func set_cell_color(selected_color: CellColor):
	cell_color = selected_color
	match cell_color:
		CellColor.YELLOW: $CellBackground.frame = 0
		CellColor.ORANGE: $CellBackground.frame = 1
		CellColor.GRAY: $CellBackground.frame = 2

func set_cell_position(pos: Vector2):
	cell_position = pos
	position = cell_position

func set_cell_controller(controller: CellController):
	cell_controller = controller
	match cell_controller:
		CellController.COMPUTER: $BrownNumbers.visible = false
		CellController.PLAYER: $WhiteNumbers.visible = false


# Get Methods
func get_cell_value() -> int:
	return cell_value

func get_cell_color() -> CellColor:
	return cell_color

func get_cell_position() -> Vector2:
	return cell_position

func get_cell_controller() -> CellController:
	return cell_controller


# Called when the node enters the scene tree for the first time.
func _ready():
	set_cell_value(0)
	set_cell_color(CellColor.YELLOW)
	set_cell_controller(CellController.COMPUTER)

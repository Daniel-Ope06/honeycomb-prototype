extends Node2D
class_name Cell

enum CellColor { YELLOW, ORANGE, GRAY }
enum CellController { COMPUTER, PLAYER }

@export_category("Cell Properties")
@export var cell_value: int
@export var cell_color: CellColor
@export var cell_position: Vector2
@export var cell_controller: CellController


func hide_cell_value() -> void:
	$BrownNumbers.visible = false
	$WhiteNumbers.visible = false


# Set Methods
func set_cell_value(value: int) -> void:
	if value >= 0 and value <= 3:
		cell_value = value
		$BrownNumbers.frame = cell_value
		$WhiteNumbers.frame = cell_value
	else:
		print("Invalid cell value. Only 0, 1, 2, or 3 are allowed.")

func set_cell_color(selected_color: CellColor) -> void:
	cell_color = selected_color
	match cell_color:
		CellColor.YELLOW: $CellBackground.frame = 0
		CellColor.ORANGE: $CellBackground.frame = 1
		CellColor.GRAY: $CellBackground.frame = 2

func set_cell_position(pos: Vector2) -> void:
	cell_position = pos
	position = cell_position

func set_cell_controller(controller: CellController) -> void:
	cell_controller = controller
	match cell_controller:
		CellController.COMPUTER: $BrownNumbers.visible = false; $WhiteNumbers.visible = true
		CellController.PLAYER: $BrownNumbers.visible = true; $WhiteNumbers.visible = false 


# Get Methods
func get_cell_value() -> int:
	return cell_value

func get_cell_color() -> CellColor:
	return cell_color

func get_cell_position() -> Vector2:
	return cell_position

func get_cell_controller() -> CellController:
	return cell_controller

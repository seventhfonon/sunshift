extends Node2D

@export var is_selected: bool = false
@onready var _animated_sprite = $ActionBoxArea/AnimatedSprite2D
@onready var description_lbl = $DescriptionBox/DescriptionLabel
@onready var move_lbl = $ActionBoxArea/MoveLabel

@export var move_data: MoveData
@export var move_name: String = "Default Name"
@export var move_cost: int = 1
@export var move_description: String = "Default Text"

@onready var MoveLabel = $ActionBoxArea/MoveLabel

func _on_action_box_area_mouse_entered() -> void:
	_animated_sprite.play("selected")
	is_selected = true


func _on_action_box_area_mouse_exited() -> void:
	_animated_sprite.play("not_selected")
	is_selected = false

func _ready():
	load_move_data(move_data)
	set_move_values(move_cost, move_name, move_description)


func set_move_values(_cost: int, _name: String, _description: String):
	move_name = _name
	move_description = _description
	move_cost = _cost

func _update_graphics():
	if is_selected:
		$DescriptionBox.visible = true
	else:
		$DescriptionBox.visible = false
	if move_lbl.get_text() != move_name:
		move_lbl.set_text(move_name)
	if description_lbl.get_text() != move_description:
		description_lbl.set_text(move_description)

func _process(delta):
	_update_graphics()

func load_move_data(move_data: MoveData):
	self.set_move_values(move_data.cost, move_data.name, move_data.description)

#func _update_graphics():
	#if cost_lbl.get_text() != str(card_cost):
		#cost_lbl.set_text(str(card_cost))
	#if name_lbl.get_text() != card_name:
		#name_lbl.set_text(card_name)
	#if description_lbl.get_text() != card_description:
		#description_lbl.set_text(card_description)	
	#if range_lbl.get_text() != str(card_range):
		#range_lbl.set_text(str(card_range))

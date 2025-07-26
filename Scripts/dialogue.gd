class_name Dialogue
extends Node2D

@export var player: CharacterBody2D
@export var character: StaticBody2D

@onready var _content = $CanvasLayer/RichTextLabel
@onready var _type_timer = $TypeTimer
@onready var _pause_timer = $PauseTimer

func update_message(message):
	_content.bbcode_text = message
	_content.visible_characters = _content.text.length()
	#_content.visible_characters = 0
	#_type_timer.start()

func _on_TypeTimer_timeout():
	if _content.visible_characters < _content.text.length():
		_content.visible_characters += 1
	else:
		_type_timer.stop()
		
func message_fully_visible() -> bool:
	return _content.visible_characters == _content.text.length()
	

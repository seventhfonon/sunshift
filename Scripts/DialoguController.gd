class_name Dialogue
extends Control

@export var player: CharacterBody2D
@export var character: StaticBody2D

@onready var content = $DialogueBox
@onready var type_timer = $TypeTimer
@onready var pause_timer = $PauseTimer
	
func _process(delta):
	if player.get_last_slide_collision():
		if player.get_last_slide_collision().get_collider() == character:
			visible = true
			player.in_dialogue = true
	else:
		visible = false
		player.in_dialogue = false
		
func update_message(message):
	content.bbcode_text = message
	content.visible_characters = 0
	type_timer.start()

func _on_TypeTimer_timeout():
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()

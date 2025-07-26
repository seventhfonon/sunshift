class_name DialogueManager
extends Node

const DIALOGUE_SCENE = preload("res://Scenes/dialogue.tscn")

var _messages := []
var _active_dialogue_offset := 0;
var _is_active := false
var _can_activate:= true
var current_dialogue_instance: Dialogue

@onready var _input_buffer = $InteractionTimer

func _ready() -> void:
	_input_buffer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	_can_activate = true

func _show_messages(message_list: Array) -> void:
	if _is_active or not _can_activate:
		return
		
	_is_active = true
	_messages = message_list
	_active_dialogue_offset = 0
	
	var _dialogue = DIALOGUE_SCENE.instantiate()
	get_tree().get_root().add_child(_dialogue)
	current_dialogue_instance = _dialogue
	_show_current()
	
func _show_current() -> void:
	var _message = _messages[_active_dialogue_offset]
	current_dialogue_instance.update_message(_message)

func _hide() -> void:
	current_dialogue_instance.queue_free()
	current_dialogue_instance = null
	_is_active = false
	_can_activate = false
	_input_buffer.start()
	
func _input(event: InputEvent) -> void:
	if not _is_active:
		return

	if event.is_action_pressed("accept") :
		if current_dialogue_instance.message_fully_visible():
			if _active_dialogue_offset < _messages.size() - 1:
				_active_dialogue_offset += 1
				_show_current()
			else:
				_hide()

func _on_player_show_dialogue(messages: Array) -> void:
	_show_messages(messages)

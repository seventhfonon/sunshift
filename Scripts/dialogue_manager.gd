class_name DialogueManager
extends Node

signal message_requested()
signal message_completed()
signal finished()

var messages = []
var active_dialogue_offset = 0;
var is_active = false
var current_dialogue_instance: Dialogue

func show_messages(message_list, position):
	if is_active:
		return
	is_active = true
	
	messages = message_list
	active_dialogue_offset = 0
	

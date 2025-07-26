class_name NPC
extends StaticBody2D

@export var _dialogue_manager: DialogueManager
@onready var _collision_shape = $CollisionShape2D

var messages = [
	"I'm just a guy!", 
	"I'm totally normal.", 
	"I don't have any problems."
]

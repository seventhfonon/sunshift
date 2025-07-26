extends Node2D

@export var player_character: PlayerCharacter

func _on_bloom_button_pressed() -> void:
	player_character.increase_bloom(1)


func _on_flame_button_pressed() -> void:
		player_character.increase_flame(1)


func _on_take_damage_button_pressed() -> void:
	player_character.take_damage(10)

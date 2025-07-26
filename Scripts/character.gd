class_name PlayerCharacter extends Node2D
@onready var _animated_sprite = $AnimatedSprite2D

@export var max_health: int = 100
@export var max_flame: int = 10
@export var max_bloom: int = 10
@export var max_alignment: int = 10


var health: int = 50
var flame: int = 0
var bloom: int = 0
var alignment: int = 0
var is_alive: bool = 1
#@onready var alignment_bar = $AlignmentBar

func _process(_delta):
		_animated_sprite.play("fly")
		update_stat_bars()


func set_character_stats(_health: int, _max_health: int):
	max_health = _max_health
	health = _max_health
	
func update_stat_bars():
	set_progress_bar($FlameBar, max_flame, flame)
	set_progress_bar($BloomBar, max_bloom, bloom)
	set_progress_bar($HealthBar, max_health, health)
	var text:String = "%s/%s HP"%[health,max_health]
	$HealthBar/HealthLabel.text = text

func set_progress_bar(bar: TextureProgressBar, max: int, val: int):
	if (bar as TextureProgressBar).max_value != max:
		(bar as TextureProgressBar).max_value = max
	if (bar as TextureProgressBar).value != val:
		(bar as TextureProgressBar).value = val
		
func increase_flame(amount: int):
	alignment += amount
	if alignment > max_alignment:
		alignment = max_alignment
	if alignment > 0:
		bloom = 0
		flame = alignment
	else:
		bloom = abs(alignment)
	#flame += amount
		
func increase_bloom(amount: int):
	alignment -= amount
	if alignment < -max_alignment:
		alignment = -max_alignment
	if alignment < 0:
		flame = 0
		bloom = abs(alignment)
	else:
		flame = abs(alignment)
	#bloom += amount
	
func take_damage(amount: int):
	health = max(health - amount, 0)

class_name Player
extends CharacterBody2D

signal request_dialogue(messages: Array[String])

@export var speed = 200
@export var camera: Camera2D 

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _camera_transform = $RemoteTransform2D
@onready var _camera_timer = $PanTimer

var _last_movement = Vector2.ZERO
var _input_direction: Vector2
var _accept_input = true
var _panning = false

@export var _walk_sprites: Dictionary[Vector2, String]
const WALK_TAG = "walk_"
const STAND_TAG = "stand_"

func _ready() -> void:
	_camera_timer.timeout.connect(_on_camera_timer_timeout)
	
func get_input():
	_input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = _input_direction * speed
	
	if _input_direction.length_squared() > 0:
		_animated_sprite.play(WALK_TAG + _walk_sprites[_input_direction.sign()])
		_last_movement = _input_direction
	elif _last_movement:
		_animated_sprite.play(STAND_TAG + _walk_sprites[_last_movement.sign()])

func _physics_process(delta):
	if _accept_input:
		get_input()
		move_and_slide()
	if not _input_direction:
		pan_camera()
	else:
		_panning = false
		_camera_timer.stop()
		_camera_transform.update_position = true
		
func _input(event: InputEvent) -> void:
	if not _accept_input:
		return

	for i in get_slide_collision_count():
		var current_collision = get_slide_collision(i)
		if current_collision.get_collider().is_in_group("NPC"):
			_handle_npc_input(current_collision.get_collider(), event)

func _handle_npc_input(npc: NPC, event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		request_dialogue.emit(npc.messages)

func pan_camera():
	if _panning:
		if _last_movement.y < 0:
			camera.position.y = clamp(camera.position.y - 2, position.y - 200, position.y + 200)
	elif _last_movement and _camera_timer.is_stopped():
		_camera_transform.update_position = false
		_camera_timer.start()

func _on_camera_timer_timeout():
	_panning = true

func _on_dialogue_manager_message_started() -> void:
	_accept_input = false
	
func _on_dialogue_manager_message_finished() -> void:
	_accept_input = true

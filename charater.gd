extends CharacterBody2D

@export var speed = 200
@export var camera: Camera2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var camera_transform = $RemoteTransform2D

var lastMovement = Vector2.ZERO
var input_direction: Vector2
var camera_buffer = 0
var in_dialogue = false

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction.length_squared() > 0:
		if input_direction.x > 0:
			animated_sprite.play("walkright")
		elif input_direction.x < 0:
			animated_sprite.play("walkleft")
		elif input_direction.y > 0:
			animated_sprite.play("walkdown")
		elif input_direction.y < 0:
			animated_sprite.play("walkup")
		lastMovement = input_direction
	else:
		if lastMovement.x > 0:
			animated_sprite.play("standright")
		elif lastMovement.x < 0:
			animated_sprite.play("standleft")
		elif lastMovement.y > 0:
			animated_sprite.play("standdown")
		elif lastMovement.y < 0:
			animated_sprite.play("standup")
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	if not in_dialogue:
		pan_camera(delta)
	


func pan_camera(delta):
	if get_slide_collision_count():
		camera_buffer = clamp(camera_buffer + delta, 0, 5)
	else:
		camera_buffer = 0
	
	if camera_buffer > 2.5:
		if lastMovement.y < 0:
			camera_transform.update_position = false
			camera.position.y = clamp(camera.position.y - 2, position.y - 200, position.y + 200)
			print_debug(camera.position.y)
			print_debug(position.y)
	else:
		camera_transform.update_position = true

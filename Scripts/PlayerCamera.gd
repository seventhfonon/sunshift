extends Camera2D

func _process(delta):
	# Ensure camera limits are respected, especially when using RemoteTransform2D
	position.x = clamp(position.x, limit_left, limit_right)
	position.y = clamp(position.y, limit_top, limit_bottom)

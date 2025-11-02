extends RigidBody2D

@export var player : StaticBody2D

@export var speed := 3.0
@onready var eye_center := position

func _process(delta):
	var direction = (player.global_position - global_position).normalized()
	var target_angle = direction.angle()
	rotation = rotate_toward(rotation, target_angle, delta * speed)

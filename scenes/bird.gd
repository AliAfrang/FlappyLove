extends CharacterBody2D

var GRAVITY : int = 800
var FLAP_SPEED : int = -340
var X : int = 210
var u = 0
var havekey = false
var levels = ["res://scenes/l_1.tscn", "res://scenes/l_2.tscn", "res://scenes/l_3.tscn", "res://scenes/l_4.tscn"]
var canmove = false
var haveb = false

func _input(event):
	if event:
		if event.is_action_pressed("ui_accept"):
			flap()
			canmove = true
				
func _physics_process(delta):
	if canmove:
		velocity.y += GRAVITY * delta
		
		move_and_collide(velocity * delta)
		if havekey:
			$"../key/CollisionShape2D".disabled = true
			$"../key".position = Vector2(position.x+40,position.y)
		elif haveb:
			$"../oof".position = Vector2(position.x+30, position.y-35)
			
func flap():
	$s.play()
	velocity.y = FLAP_SPEED
	if X < 0:
		
		$sright.hide()
		$sleft.show()
	else:
		$sright.show()
		$sleft.hide()
		
	velocity.x = X
	X *= -1


func _on_area_2d_body_entered(body):
	if body.is_in_group("jiz") and canmove:
		rotation = 90
		canmove = false
		modulate.a = 0.3
		gameoveran()
		await get_tree().create_timer(0.9).timeout
		
		get_tree().call_deferred("change_scene_to_file", levels[$"../..".inlevel-1])
		
	elif body.is_in_group("key"):
		havekey = true
	
	
	




func _on_area_2d_area_entered(area):
	if area.is_in_group("girl"):
		canmove = false
		if havekey:
			$"../girl/Sprite2D2".hide()
			
			$"../key".hide()
			await  rotateanim()
			gameoveran()
			$"../..".win()
		else:
			rotation = 90
			modulate.a = 0.3
			await gameoveran()
			get_tree().call_deferred("change_scene_to_file", levels[$"../..".inlevel-1])
	elif area.is_in_group("blade"):
		haveb = true
		GRAVITY = 1100
		
func gameoveran():
	$"../gameover".show()
	for i in range(20):
		await get_tree().create_timer(0.02).timeout
		$"../gameover".modulate.a += 0.05

func rotateanim():
	for i in range(3):
		rotation_degrees = 20.0
		$"../girl/Sprite2D".rotation_degrees = 16
		await get_tree().create_timer(0.25).timeout
		rotation_degrees = -20
		$"../girl//Sprite2D".rotation_degrees = -16
		await get_tree().create_timer(0.25).timeout

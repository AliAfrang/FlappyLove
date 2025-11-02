extends CharacterBody2D


const GRAVITY : int = 800
const FLAP_SPEED : int = -340
var X : int = -210
var u = 0

var canmove = true

func _input(event):
	if event:
		if event.is_action_pressed("ui_right"):
			flap()
			#canmove = true
				
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if canmove:
		velocity.y += GRAVITY * delta
		
		move_and_collide(velocity * delta)
		
func flap():
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
		#rotation = 90
		#canmove = false
		#modulate.a = 0.3
		#$"../gameover".show()
		#for i in range(20):
			#await get_tree().create_timer(0.02).timeout
			#$"../gameover".modulate.a += 0.05
		#
		#get_tree().reload_current_scene()
		canmove = false
		await  get_tree().create_timer(4).timeout
		canmove = true
	elif body.is_in_group("point"):
		$"../point".position.x = randf_range(-500,500)
		$"../point".position.y = randf_range(-230,230)
		$"../r".text = str(int($"../r".text)+1)
		   
		


func _on_area_2d_area_entered(area):
	if area.is_in_group("girl"):
		print(1)

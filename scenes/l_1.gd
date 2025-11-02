extends Node2D

@export var inlevel := 0
var move := false
var direc = -60

#
#func _input(event):
	#if event:
		#if event.is_action_pressed("ui_accept"):
			#afterwin()

func _ready():
	for i in range(20):
		$intro.modulate.a -= 0.05
		await get_tree().create_timer(0.02).timeout
	$intro.hide()
	$ingame.show()
	if inlevel == 4:
		while true:
			await get_tree().create_timer(3).timeout
			scalor(0.05)
			move = true
			dir()
			await get_tree().create_timer(7).timeout
			scalor(-0.05)
			move = false

func scalor(n):
	for i in range(20):
		$ingame/div/rotater.scale.x += n
		$ingame/div/rotater.scale.y += n
		await get_tree().create_timer(0.01).timeout

func dir():
	direc *= -1
func win():
	autl.setlv(inlevel)
	get_tree().call_deferred("change_scene_to_file","res://scenes/main_scene.tscn")

func _process(delta):
	if inlevel == 4:
		if move:
			$ingame/div/rotater.rotation_degrees += 100 * delta
			$ingame/div/rotater.show()
			$ingame/div/rotater.process_mode = Node.PROCESS_MODE_INHERIT
			$ingame/div.position.x += direc * delta
		else:
			$ingame/div/rotater.hide()
			$ingame/div/rotater.process_mode = Node.PROCESS_MODE_DISABLED


func _on_oof_body_entered(body):
	if body.is_in_group("div"):
		$ingame/div/ColorRect/health.size.x -= 20
		if $ingame/div/ColorRect/health.size.x == 0:
			afterwin()
			
func afterwin():
	$ingame/Bird.canmove = false
	$ingame/div.hide()
	$ingame/girl/Sprite2D2.hide()
	$ingame/oof.hide()
	$ingame/gameover.show()
	$ingame/Bird.remove_child($ingame/Bird/Area2D)
	
	for i in range(20):
		await get_tree().create_timer(0.07).timeout
		music8.get_child(0).volume_db -= 1
		$ingame/gameover.modulate.a += 0.05
	
	$ingame/Bird/sright.show()
	$ingame/Bird/sleft.hide()
	$ingame/Bird.position = Vector2(353,-176)
	
	for i in range(20):
		await get_tree().create_timer(0.03).timeout
		$ingame/gameover.modulate.a -= 0.05
	
	await get_tree().create_timer(1).timeout
	get_tree().call_deferred("change_scene_to_file", "res://scenes/curtain.tscn")
	

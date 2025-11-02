extends StaticBody2D

@export var firstdelay = 0.0
@export var delay = 0.03
@export var timesof = 2.5
@export var timeson = 1.5
@export var movement = 6.5


func _ready():
	await get_tree().create_timer(firstdelay).timeout
	anim()
	
func anim():
	while true:
		await get_tree().create_timer(timesof).timeout
		for i in range(20):
			await get_tree().create_timer(delay).timeout
			position.y -= movement
		await get_tree().create_timer(timeson).timeout
		for i in range(20):
			await get_tree().create_timer(delay).timeout
			position.y += movement

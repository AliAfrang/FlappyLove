extends Node2D

#
func _ready():
	music8.get_child(0).volume_db += 20
	for i in range(20):
		await get_tree().create_timer(0.05).timeout
		$Label.modulate.a += 0.05
		$pointer.modulate.a += 0.05

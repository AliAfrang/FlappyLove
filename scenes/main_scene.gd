extends  Node2D

@onready var lineedit : LineEdit = $LineEdit
@export var btns : Array[Node2D]
var btnsp = [-198,-108,-18,72, -198]
var btnsp2 = [72,-18,-108,-198, 72]

var minmod = 0.4
var scl = Vector2(1.1, 1.1)
var ind = 0

func _ready():
	ind = autl.getlv()
	$pointer.position.y = btnsp[ind]
	btns[ind].modulate.a = 1
	btns[ind].scale = scl
	btns[ind].position.x = 134

func _input(event):
	if event:
		if event.is_action_released("ui_down"):
			$pointer.modulate.a = 1
			if $pointer.position.y != btnsp[autl.getlv()]:
				$pointer.position.y += 90.0
				ind += 1
				btns[ind-1].scale = Vector2(0.9, 0.9)
				btns[ind-1].position.x = 0
				btns[ind-1].modulate.a = minmod
				btns[ind].modulate.a = 1
				btns[ind].scale = scl
				btns[ind].position.x = 134
			else:
				$pointer.position.y = -198
				ind = 0
				btns[autl.getlv()].scale = Vector2(0.9, 0.9)
				btns[autl.getlv()].position.x = 0
				btns[autl.getlv()].modulate.a = minmod
				btns[ind].modulate.a = 1
				btns[ind].scale = scl
				btns[ind].position.x = 134
				
		elif event.is_action_released("ui_up"):
			$pointer.modulate.a = 1
			if $pointer.position.y != -198:
				$pointer.position.y -= 90.0
				ind -= 1
				btns[ind+1].scale = Vector2(0.9, 0.9)
				btns[ind+1].position.x = 0
				btns[ind+1].modulate.a = minmod
				btns[ind].modulate.a = 1
				btns[ind].scale = scl
				btns[ind].position.x = 134
			else:
				$pointer.position.y = btnsp[autl.getlv()]
				ind = autl.getlv()
				btns[0].scale = Vector2(0.9, 0.9)
				btns[0].position.x = 0
				btns[0].modulate.a = minmod
				btns[ind].modulate.a = 1
				btns[ind].scale = scl
				btns[ind].position.x = 134
		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			$pointer.modulate.a = 0.5
		elif event.is_action_pressed("ui_accept") :
			$pointer.modulate.a = 0.5
			if ind == 0:
				get_tree().change_scene_to_file("res://scenes/l_1.tscn")
			elif ind == 1:
				get_tree().change_scene_to_file("res://scenes/l_2.tscn")
			elif ind == 2:
				get_tree().change_scene_to_file("res://scenes/l_3.tscn")
			elif ind == 3:
				get_tree().change_scene_to_file("res://scenes/l_4.tscn")

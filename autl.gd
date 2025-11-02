extends Node

var bestlv = 0

func setlv(n):
	if n > bestlv:
		bestlv = n
func getlv():
	return bestlv

func _input(event):
	if event and event.is_action_pressed("ui_cancel"):
		get_tree().quit()

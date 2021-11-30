extends Node2D

func _on_Timer_timeout():
	var _return = get_tree().change_scene("res://scenes/start_screen.tscn")

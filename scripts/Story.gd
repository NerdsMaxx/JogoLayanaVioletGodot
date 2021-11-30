extends Control

func _ready():
	$Start.grab_focus()

func _on_Start_pressed():
	if get_tree().change_scene("res://scenes/nvl-1.tscn") != OK:
		print("Erro")

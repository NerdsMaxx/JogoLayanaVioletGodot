extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	#if get_tree().change_scene("res://scenes/nvl-1.tscn") != OK:
	if get_tree().change_scene("res://scenes/Story.tscn") != OK:
		print("Erro ao iniciar o jogo")

func _on_Controls_pressed():
	if get_tree().change_scene("res://scenes/Control.tscn") != OK:
		print("Erro ao iniciar o jogo")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Credits_pressed():
	if get_tree().change_scene("res://scenes/Credits.tscn") != OK:
		print("Erro ao iniciar o jogo")

extends Control

var counter = 0


func _ready():
	$Start.grab_focus()

func _on_Start_pressed():
	if get_tree().change_scene("res://scenes/start_screen.tscn") != OK:
		print("Erro")


func _on_Start2_pressed():
	$Label.align = Label.ALIGN_FILL
	if counter == 0:
		$Label.align = Label.ALIGN_CENTER
		$Label.text = "Credito aos artistas"
		
	elif counter == 1:
		$Label.text = "Layana Violet: WHTDRAGON e\nmodificado por Watyson Soares\n"
		$Label.text += "Golens: CraftPix\n"
		$Label.text += "Plant e Blue Bird: Pixel Frog\n"
		$Label.text += "Galen: Kronovi-"
		
	elif counter == 2:
		$Label.text = "Fase da floresta: aamatniekss\n"
		$Label.text += "Fase da caverna: Szadi art.\n"
		$Label.text += "Serra e Armadilha de fogo: Pixel Frog\n"
		$Label.text += "Lava: Open Pixel Project"
		
	elif counter == 3:
		$Label.text = "Trampolin: Pixel Frog\n"
		$Label.text += "Musicas: Florian Stracker"
	
	counter += 1 	

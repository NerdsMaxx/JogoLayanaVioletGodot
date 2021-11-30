extends Control

func _on_btn_pressed():
	queue_free()

func set_text(text):
	$Label.text = text

extends CanvasLayer

func focus():
	$try_again.grab_focus()

func _on_TextureButton_pressed():
	Global.life = 5
	var path = "res://scenes/nvl-1.tscn"
	if Global.nvl == 2:
		path = "res://scenes/nvl-2.tscn"
	var _return = get_tree().change_scene(path)

func _on_giveup_pressed():
	Global.checkpoint_pos = Vector2.ZERO
	Global.life = 5
	Global.nvl = 1
	var path = "res://scenes/start_screen.tscn"
	var _return = get_tree().change_scene(path)

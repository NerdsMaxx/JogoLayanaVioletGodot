extends Area2D

func _on_Fallzone_body_entered(body):
	if body.name == "player":
		var _return = get_tree().change_scene("res://scenes/game_over.tscn")
	return

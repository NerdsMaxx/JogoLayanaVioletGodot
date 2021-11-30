extends Area2D

onready var changer = get_parent().get_node("transition_in")

export var path : String

func _on_portal_nextNvl_body_entered(body):
	if body.name == "player":	
		if path == "res://scenes/nvl-1.tscn":
			Global.checkpoint_pos.x = 32
			Global.checkpoint_pos.y = 232
		else:
			Global.checkpoint_pos.x = 40
			Global.checkpoint_pos.y = 278
		changer.change_scene(path)

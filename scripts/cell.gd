extends Area2D

onready var changer = get_parent().get_node("transition_in")

export var path : String
export var disable : bool

var player

func _on_goal_body_entered(body):
	player = body
	end_game()

func _on_boss_bossDead():
	disable = false
	end_game()

func end_game():
	if player.name == "player" and !disable:
		$effects.emitting = true
		
		if path == "res://scenes/nvl-1.tscn":
			Global.checkpoint_pos.x = 32
			Global.checkpoint_pos.y = 232
		else:
			Global.checkpoint_pos.x = 40
			Global.checkpoint_pos.y = 278
		$music.play()
		changer.change_scene(path)

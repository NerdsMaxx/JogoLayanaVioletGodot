extends Area2D

var player = null
export var time = 0.5

func _on_lava_body_entered(body):
	if body.name == "player" and !body.is_death:
		body.set_damage(1)
		body.set_dead()
		player = body
		$Timer.start(time)

func _on_lava_body_exited(body):
	if body.name == "player":
		$Timer.stop()
		player = null

func _on_Timer_timeout():
	if player and !player.is_death:
		player.set_damage(1)
		player.set_dead()

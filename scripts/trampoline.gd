extends Area2D

func _on_trampoline_body_entered(body):
	if body.name == "player":
		body.movement.y += body.JUMP_FORCE * 2
		$animation.play("jump")

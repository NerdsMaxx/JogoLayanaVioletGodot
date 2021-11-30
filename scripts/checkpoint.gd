extends Area2D

func _on_checkpoint_body_entered(body):
	if body.name == "player":
		body.set_checkpoint()
		$animation.play("checkpoint")
		$collision_shape.queue_free()


func _on_animation_animation_finished(anim_name):
	if anim_name == "checkpoint":
		$animation.play("idle")

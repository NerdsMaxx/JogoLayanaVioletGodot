extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$animation.play("on")

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$timer/start.autostart = true

func _on_start_timeout():
	$animation.play("off")

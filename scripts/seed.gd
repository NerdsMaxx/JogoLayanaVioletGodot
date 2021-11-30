extends Area2D

var movement = Vector2.ZERO
var speed = -200
var direction = 1

func _physics_process(delta):
	movement.x = (speed * direction) * delta
	translate(movement)

func _on_clear_screen_exited():
	queue_free()

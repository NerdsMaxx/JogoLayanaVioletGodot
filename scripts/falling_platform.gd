extends KinematicBody2D

export var latency_down = 0.4

const GRAVITY = 720

var movement = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	set_gravity(delta)
	set_movement()

func set_gravity(delta):
	movement.y += GRAVITY * delta
	
func set_movement():
	movement = move_and_slide(movement)

func _on_area_collision_body_entered(body):
	if body.name == "player":
		$animation.play("shake")
		$timer/timer_latency.start(latency_down)

func _on_timer_latency_timeout():
	$animation.play("idle")
	set_physics_process(true)

extends Node2D

export var speed = 3
export var horizontal = true
export var distance = 192

const WAIT_DURATION = 1

var follow = Vector2.ZERO

func _ready():
	_start_tween()

func _physics_process(_delta):
	$platform.position = $platform.position.linear_interpolate(follow, 0.005)

func _start_tween():
	var movement_direction = Vector2.RIGHT
	if !horizontal:
		movement_direction = Vector2.UP
	movement_direction *= distance

	var duration = movement_direction.length() / float(speed * 16)
	$tween.interpolate_property(
		self, "follow", Vector2.ZERO,
		movement_direction, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, WAIT_DURATION
	)
	
	$tween.interpolate_property(
		self, "follow", movement_direction,
		Vector2.ZERO, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)

	$tween.start()

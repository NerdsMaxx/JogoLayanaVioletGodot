extends KinematicBody2D

export var life = 3
export var movement_direction = 1
export var speed = 80

const GRAVITY = 600

var movement = Vector2.ZERO

var is_attacked = false
var is_stop_move = false
var is_hitted = false
var is_death = false
var max_life = 0

signal bossDead

func _ready():
	max_life = life
	$hitbox/collision_shape.disabled = true
	set_physics_process(false)

func _physics_process(delta):
	set_gravity(delta)
	set_states()
	set_movement()
	set_animation()

# =========================== Set ===========================
func set_movement():
	if !is_stop_move and !is_death:
		movement.x = speed * movement_direction
		movement = move_and_slide(movement)

func set_states():
	if !is_stop_move:
		is_stop_move = check_hole()
		if is_stop_move:
			$timer/delay_idle.start()

func set_gravity(delta):
	movement.y += GRAVITY * delta
	if !is_stop_move and !is_death:
		movement.x = 0

func set_animation():
	var animation = swap_anim("walk")
	if is_death:
		animation = "dead"
	elif is_hitted:
		animation = swap_anim("hurt")
	elif is_stop_move:
		animation = swap_anim("idle")
	if $animation.current_animation != animation:
		$animation.play(animation)

func swap_anim(animation):
	if life < (max_life / 3):
		if life == 1:
			speed = 300
		else:
			speed = 240
		return animation + "_2"
	if life < (max_life / 2):
		speed = 160
		return animation + "_1"
	return animation

func set_flip():
	if movement_direction != 0:
		$sprite.flip_h = movement_direction < 0
	if movement_direction < 0:
		$raycast.scale.x *= -1

func set_damage(damage):
	is_hitted = true
	life -= damage
	$music/hit.play()
	$hitbox/collision_shape.set_deferred("disable", true)

func set_dead():
	if(life < 1):
		is_death = true
		emit_signal("bossDead")
		$collision_shape.set_deferred("disable", true)
		$hitbox/collision_shape.set_deferred("disable", true)

# =========================== Functions ===========================
func check_hole():
	return !$raycast/floor.is_colliding()

func _on_hitbox_body_entered(body):
	body.jump()
	set_damage(1)
	set_dead()

func set_hitted():
	is_hitted = false

func _on_trigged_player_entered():
	$animation.play("spawn")

func on_boss():
	$collision_shape.disabled = false
	$hitbox/collision_shape.disabled = false
	set_physics_process(true)

func _on_delay_idle_timeout():
	$sprite.flip_h = !$sprite.flip_h
	$raycast.scale.x *= -1
	movement_direction *= -1
	$animation.play("walk")
	is_stop_move = false

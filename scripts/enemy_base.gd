extends KinematicBody2D
class_name enemyBase

export var life = 3
export var movement_direction = 0
export var speed = 80
export var see_hole = true

const GRAVITY = 600

var movement = Vector2.ZERO

var is_attacked = false
var is_stop_move = false
var is_hitted = false
var is_death = false

func _ready():
	if !movement_direction:
		movement_direction = set_movement_direction()
	set_flip()

func _physics_process(_delta):
	set_states()
	set_movement()
	set_animation()

# =========================== Set ===========================
func set_movement():
	if !is_stop_move and !is_death:
		movement.x = speed * movement_direction
		movement = move_and_slide(movement)

func set_states():
	is_stop_move = check_wall() or check_hole()

func set_gravity(delta):
	movement.y += GRAVITY * delta
	if !is_stop_move and !is_death:
		movement.x = 0
	movement = move_and_slide(movement)

func set_animation():
	var animation = "walk"
	if is_death:
		animation = "dead"
	elif is_hitted:
		animation = "hurt"
	elif is_stop_move:
		animation = "idle"
	if $animated_sprite.animation != animation:
		$animated_sprite.play(animation)

func set_flip():
	if movement_direction != 0:
		$animated_sprite.flip_h = movement_direction < 0

	if movement_direction < 0:
		$raycast.scale.x *= -1

func set_damage(damage):
	is_hitted = true
	life -= damage
	$music/hit.play()
	$hitbox/collision_shape.set_deferred("disable", true)
	$timers/timer_damage.start()

func set_dead():
	if(life < 1):
		is_death = true
		$hitbox/collision_shape.set_deferred("disable", true)
		$timers/timer_dead.start()

func set_movement_direction():
	randomize()
	if(randi() % 100) > 50:
		return 1
	return -1

# =========================== Functions ===========================
func check_wall():
	return $raycast/wall.is_colliding()

func check_hole():
	return !$raycast/floor.is_colliding() and see_hole

func _on_animated_sprite_animation_finished():
	if $animated_sprite.animation == "idle":
		$animated_sprite.flip_h = !$animated_sprite.flip_h
		$raycast.scale.x *= -1
		movement_direction *= -1
		$animated_sprite.play("walk")

func _on_hitbox_body_entered(body):
	body.jump()
	set_damage(1)
	set_dead()

# =========================== Timers ===========================
func _on_timer_damage_timeout():
	if !is_death:
		$hitbox/collision_shape.set_deferred("disable", false)
		is_hitted = false

func _on_timer_dead_timeout():
	$collision_shape.set_deferred("disable", true)
	queue_free()

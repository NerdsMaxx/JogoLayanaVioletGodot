extends KinematicBody2D

export var movement = Vector2.ZERO

const SPEED = 200
const GRAVITY = 700
const JUMP_FORCE = -275
const UP = Vector2.UP

var movement_direction = 0

var is_hurt = false
var is_moving = false
var in_floor = false
var is_death = false

var max_life = 5

signal change_life(life)

func _ready():
	Global.set("player", self)
	var _return = connect("change_life", get_parent().get_node("hud/container/holder_life"), "on_change_life")
	emit_signal("change_life", Global.life)
	position = Global.checkpoint_pos

func _physics_process(delta):
	set_gravity(delta)
	set_movement()
	set_states()
	set_animation()
	set_pushable(delta)

# =========================== Set ===========================
func set_gravity(delta):
	movement.y += GRAVITY * delta

func set_movement():
	if is_death or is_hurt:
		movement.x = 0
	else:
		movement_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		movement.x = SPEED * movement_direction
		if Input.is_action_pressed("ui_up") and in_floor:
			jump()
	movement = move_and_slide(movement, UP)

func set_animation():
	set_flip()
	var animation = "idle"
	$steps.set_emitting(false)
	if is_death:	animation = "cry"
	elif is_hurt:	animation = "hurt"
	elif !in_floor:	animation = "jump"
	elif is_moving:
		animation = "run"
		$steps.set_emitting(true)
	if $animated_sprite.animation != animation:
		$animated_sprite.play(animation)

func set_states():
	is_moving = check_moving()
	in_floor = check_floor()
	$shadow.visible = in_floor
	$push/right.set_enabled(movement_direction > 0)
	$push/left.set_enabled(movement_direction < 0)

func set_knockback():
	if $knockback/right.is_colliding():
		movement.x = -2000
	if $knockback/left.is_colliding():
		movement.x = 2000
	movement = move_and_slide(movement)

func set_flip():
	if movement_direction != 0:
		$animated_sprite.flip_h = movement_direction > 0
	$steps.scale.x = movement_direction * -1

func set_damage(damage):
	if is_death:
		return
	
	is_hurt = true
	Global.life -= damage
	emit_signal("change_life", Global.life)
	set_knockback()
	$music/hit.play()
	$hurtbox/collision_shape.set_deferred("disabled", true)
	$timer/timer_invencibility.start()

func set_dead():
	if is_death:
		return
	
	if(Global.life < 1):
		is_death = true
		$music/dead.play()
		$hurtbox/collision_shape.set_deferred("disabled", true)
		$timer/timer_death.start()

func set_checkpoint():
	Global.checkpoint_pos = position

func set_pushable(delta):
	if check_push():
		if $push/right.is_colliding():
			var block = $push/right.get_collider()
			block.move_and_slide(Vector2(30, 0) * SPEED * delta)
		else:
			var block = $push/left.get_collider()
			block.move_and_slide(Vector2(-30, 0) * SPEED * delta)

# =========================== Functions ===========================
func check_moving():
	return movement.x != 0

func check_floor():
	return $raycast.is_colliding()

func check_push():
	return $push/right.is_colliding() or $push/left.is_colliding()

func jump():
	in_floor = false
	$music/jump.play()
	movement.y = JUMP_FORCE

func _on_hurtbox_area_entered(_area):
	set_damage(1)
	set_dead()
	$timer/timer_damage.start()

func _on_hurtbox_area_exited(_area):
	$timer/timer_damage.stop()

func _on_hurtbox_body_entered(_body):
	set_damage(1)
	set_dead()
	$timer/timer_damage.start()

func _on_hurtbox_body_exited(_body):
	$timer/timer_damage.stop()

func _on_animated_sprite_animation_finished():
	if $animated_sprite.animation == "hurt":
		is_hurt = false

# =========================== Timer ===========================
func _on_timer_damage_timeout():
	set_damage(1)
	set_dead()

func _on_timer_invencibility_timeout():
	if !is_death:
		$hurtbox/collision_shape.set_deferred("disabled", false)

func _on_timer_death_timeout():
	queue_free()
	var _return = get_tree().change_scene("res://scenes/game_over.tscn")

func _on_trigged_player_entered():
	$camera.current = false

func _on_boss_bossDead():
	$camera.current = true

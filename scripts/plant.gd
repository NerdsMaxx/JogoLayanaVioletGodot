extends KinematicBody2D

export var cadency = 2.7
export var shoot_speed = 200

onready var bullet_instance = preload("res://scenes/seed.tscn")
var player

var life = 2
var facing_left	= false
var see_player	= false
var attack		= false
var is_hitted	= false
var is_death	= false

func _physics_process(_delta):
	set_animation()
	if see_player:
		var distance = player.global_position.x - self.position.x
		facing_left = distance < 0

	if facing_left:
		self.scale.x = 1
	else:
		self.scale.x = -1

func shoot():
	var bullet = bullet_instance.instance()
	bullet.speed = -shoot_speed
	get_parent().add_child(bullet)
	bullet.global_position = $spawn_shoot.global_position
	bullet.direction = self.scale.x
	attack = false

func _on_player_detector_body_entered(body):
	if body.name == "player":
		player		= body
		see_player	= true
		attack		= true
		$animated_sprite.play("attack")
		$timers/timer_shoot.start(cadency)

func _on_player_detector_body_exited(body):
	if body.name == "player":
		see_player	= false
		attack		= false
		$timers/timer_shoot.stop()

func _on_hitbox_body_entered(body):
	body.jump()
	set_damage(1)
	set_dead()

func set_animation():
	var animation = "idle"
	if attack:
		animation = "attack"
	if is_hitted:
		animation = "hurt"
	elif $animated_sprite.current_animation != animation:
		$animated_sprite.play(animation)

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

# =========================== Timers ===========================
func _on_timer_damage_timeout():
	if !is_death:
		$hitbox/collision_shape.set_deferred("disable", false)
		is_hitted = false

func _on_timer_dead_timeout():
	$collision_shape.set_deferred("disable", true)
	queue_free()

func _on_timer_shoot_timeout():
	attack = true
	$animated_sprite.play("attack")

func _on_trigged_player_entered():
	$player_detector/collision_shape.disabled = false

extends Node2D

var mute = false

func _ready():
	mute = Global.mute
	mute_on()
	Global.nvl = 2
	set_position_player()

func _process(_delta):
	set_mute()

func set_position_player():
	if Global.checkpoint_pos == Vector2.ZERO:
		Global.checkpoint_pos.x = 40
		Global.checkpoint_pos.y = 278
		$player.position = Global.checkpoint_pos

func _on_trigged_player_entered():
	$boss_room/Camera2D.current = true

func _on_boss_bossDead():
	$boss_room/Camera2D.current = false

func mute_on():
	if !mute:
		$AudioStreamPlayer.play()
	else :
		$AudioStreamPlayer.stop()
		
	$hud/container/holder_timer/sound_unmute.region_enabled = mute

func set_mute():
	if Input.is_action_just_released("mute"):
		mute = !mute
		Global.mute = mute
		mute_on()

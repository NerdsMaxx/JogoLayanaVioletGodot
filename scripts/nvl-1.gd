extends Node2D

var mute = false

func _ready():
	mute = Global.mute
	mute_on()
	Global.nvl = 1
	set_position_player()

func _process(_delta):
	set_mute()

func set_position_player():
	if Global.checkpoint_pos == Vector2.ZERO:
		Global.checkpoint_pos.x = 35
		Global.checkpoint_pos.y = 230
		$map/player.position = Global.checkpoint_pos

func mute_on():
	if !mute:
		$background/AudioStreamPlayer.play()
	else :
		$background/AudioStreamPlayer.stop()
		
	$map/hud/container/holder_timer/sound_unmute.region_enabled = mute

func set_mute():
	if Input.is_action_just_released("mute"):
		mute = !mute
		Global.mute = mute
		mute_on()

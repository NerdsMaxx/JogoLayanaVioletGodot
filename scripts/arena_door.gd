extends StaticBody2D

func _on_trigged_player_entered():
	$animation.play("on")

func _on_boss_bossDead():
	$animation.play("disable")

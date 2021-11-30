extends Control

var life_size = 32

func on_change_life(life):
	if life <= 0:
		$life.visible = false
	else:
		$life.rect_size.x = life * life_size

extends Control

export var minute = 0
export var second = 0

func _ready():
	pass

func _process(_delta):
	if minute  > 0 and second < 0:
		minute -= 1
		second = 59

	$container/second.set_text(set_time(second))
	$container/minute.set_text(set_time(minute))
	
	if second < 0:
		var _return = get_tree().reload_current_scene()

func set_time(time):
	if time > 9:
		return str(time)
	return str("0" + str(time))

func _on_timer_timeout():
	second -= 1

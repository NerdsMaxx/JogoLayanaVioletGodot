extends StaticBody2D

export var history: Array

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$text.text = ""
		for i in range(history.size()):
			$text.text += history[i]
			if i < history.size()-1:
				$text.text += '\n'

func _on_clear_msg_timeout():
	$text.text = ""

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$timer/clear_msg.start()

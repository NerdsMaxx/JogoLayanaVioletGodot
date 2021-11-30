extends ColorRect

var progress = 0.0

func _process(_delta):
	material.set("shader_param/progress", progress)

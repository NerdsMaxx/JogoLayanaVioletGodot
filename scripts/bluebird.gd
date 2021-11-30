extends enemyBase

func _ready():
	life = 2
	speed = 80

func _physics_process(_delta):
	movement.y = 0

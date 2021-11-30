extends enemyBase

func _ready():
	life = 3
	speed = 80

func _physics_process(delta):
	set_gravity(delta)

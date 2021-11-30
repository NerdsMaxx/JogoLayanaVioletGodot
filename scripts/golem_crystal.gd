extends enemyBase

func _ready():
	life = 4
	speed = 120

func _physics_process(delta):
	set_gravity(delta)

extends enemyBase

func _ready():
	life = 5
	speed = 160

func _physics_process(delta):
	set_gravity(delta)

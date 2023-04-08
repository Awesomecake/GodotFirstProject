extends Sprite2D

var Animator;
# Called when the node enters the scene tree for the first time.
func _ready():
	Animator = get_child(0)
	Animator.play("Explosion")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func AnimatorFinished(name):
	queue_free()

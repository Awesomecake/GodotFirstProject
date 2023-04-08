extends Sprite2D

var iPos;
var jPos;
var UIscale;
var startX;
var startY

var moveRule = []
var attackRule = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setPosition(startX,startY,i,j,scale):
	UIscale = scale
	self.startX = startX
	self.startY = startY
	self.scale = Vector2(scale/2,scale/2)
	iPos = i;
	jPos = j;
	position.x = startX-(i-j)*128*scale
	position.y = startY+(i+j-1)*64*scale

func updatePosition(startX,startY):
	self.startX = startX
	self.startY = startY
	position.x = startX-(iPos-jPos)*128*UIscale
	position.y = startY+(iPos+jPos-1)*64*UIscale

func Move(newI,newJ):
	if MovementRule(newI,newJ):
		position.x = startX-(newI-newJ)*128*UIscale
		position.y = startY+(newI+newJ-1)*64*UIscale
		iPos = newI
		jPos = newJ
		z_index = newI + newJ+1
		return true
	return false

func Attack(posI,posJ):
	if AttackRule(posI,posJ):
		var explosion = load("res://Prefabs/Explosion.tscn").instantiate()
		explosion.scale = Vector2(1,1)
		explosion.position.x = startX-(posI-posJ)*128*UIscale
		explosion.position.y = startY+(posI+posJ-1)*64*UIscale-10
		explosion.z_index = posI + posJ+1
		get_parent().add_child(explosion)
		return true
	return false

func AttackRule(posI,posJ):
	return attackRule.has(Vector2(iPos-posI,jPos-posJ))

func MovementRule(newI,newJ):
	return moveRule.has(Vector2(iPos-newI,jPos-newJ))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

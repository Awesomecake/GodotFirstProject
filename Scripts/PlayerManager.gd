extends Sprite2D

var iPos;
var jPos;
var UIscale;
var startX;
var startY

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

func Move(newI,newJ):
	if MovementRule(newI,newJ):
		position.x = startX-(newI-newJ)*128*UIscale
		position.y = startY+(newI+newJ-1)*64*UIscale
		iPos = newI
		jPos = newJ
		z_index = newI + newJ+1

func MovementRule(newI,newJ):
	return (abs(newI-iPos) == 1 && abs(newJ-jPos) == 0) \
		|| (abs(newI-iPos) == 0 && abs(newJ-jPos) == 1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

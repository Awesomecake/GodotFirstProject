extends Sprite2D

var iPos;
var jPos;
var UIscale;
var startX;
var startY

var moveRule = [
			[2,1],
			[2,-1],
			[-2,1],
			[-2,-1],
			[1,2],
			[1,-2],
			[-1,2],
			[-1,-2],
			];

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

func MovementRule(newI,newJ):
	return moveRule.has([iPos-newI,jPos-newJ])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Area2D

var parent;
var mouseOverTile;
signal tile_clicked(newI,newJ);

var height;
var iPos
var jPos


# Called when the node enters the scene tree for the first time.
func _ready():
	self.mouse_entered.connect(mouse_enter)
	self.mouse_exited.connect(mouse_exit)
	parent = get_parent()

func mouse_enter():
	if height == 1:
		mouseOverTile = true
		parent.modulate = Color(0.8,0.8,0.8);

func mouse_exit():
	mouseOverTile = false
	parent.modulate = Color(1,1,1);
	
func setPosition(startX,startY,i,j,x,height,scale):
	iPos = i
	jPos = j
	self.height = height
	parent.scale = Vector2(scale,scale)
	parent.position.x = startX-(i-j)*128*scale
	parent.position.y = startY+(i+j-2.5*x)*64*scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouseOverTile && Input.is_action_just_pressed("Left Click"):
		emit_signal("tile_clicked",iPos,jPos)

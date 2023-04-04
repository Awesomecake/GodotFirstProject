extends Area2D

var parent
var mouseHover
var iDist
var jDist

var clicked
signal card_clicked(moveArray);

# Called when the node enters the scene tree for the first time.
func _ready():
	self.mouse_entered.connect(mouse_enter)
	self.mouse_exited.connect(mouse_exit)
	parent = get_parent()
	iDist = parent.get_meta("iDist")
	jDist = parent.get_meta("jDist")

func mouse_enter():
	mouseHover = true;
	var color = Color(1, 1, 1,1)
	color.v = 0.8
	parent.modulate = color
	parent.scale = Vector2(0.25,0.25);

func mouse_exit():
	mouseHover = false;
	parent.modulate = Color(1,1,1);
	parent.scale = Vector2(0.2,0.2);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Left Click"):
		if mouseHover && !clicked:
			clicked = true
			emit_signal("card_clicked",[[iDist,jDist],[-iDist,-jDist]])
		elif mouseHover && clicked:
			clicked = false
			displayClick(clicked)
			emit_signal("card_clicked",[])
		else:
			clicked = false
			displayClick(clicked)
	
	if clicked:
		displayClick(clicked)
		
func displayClick(isClicked):
	if isClicked:
		var color = Color(1, 1, 1,1)
		color.v = 0.5
		parent.modulate = color
		parent.scale = Vector2(0.25,0.25)
	else:
		parent.scale = Vector2(0.2,0.2);
		parent.modulate = Color(1,1,1);

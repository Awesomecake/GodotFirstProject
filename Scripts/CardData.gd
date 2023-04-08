extends Area2D

var parent
var mouseHover
var MovementArray = []
var AttackArray = []

var clicked
signal card_clicked(moveArray,sender);

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	self.mouse_entered.connect(mouse_enter)
	self.mouse_exited.connect(mouse_exit)
	if parent.has_meta("MovementArray"):
		MovementArray = parent.get_meta("MovementArray")
	if parent.has_meta("AttackArray"):
		AttackArray = parent.get_meta("AttackArray")

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
			emit_signal("card_clicked",MovementArray,parent)
			Input.action_release("Left Click")
		elif mouseHover && clicked:
			clicked = false
			displayClick(clicked)
			emit_signal("card_clicked",[],parent)
		else:
			clicked = false
			emit_signal("card_clicked",[],parent)
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

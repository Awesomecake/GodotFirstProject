extends Node

var cardFileLocations = [];

var activeCards = [];

@onready var GameManager = get_node("/root").get_child(0).get_child(0)
var player
var newHand = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = GameManager.get_child(0)
	dir_contents("res://Prefabs/CardPrefabs")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GenerateHand()
	
	var cardClicked = false;
	for item in activeCards:
		if item == null:
			activeCards.erase(item)
			UpdateCardHand()
		elif item.get_child(0).clicked && !cardClicked:
			cardClicked = true;
		elif item.get_child(0).clicked && cardClicked:
			item.get_child(0).clicked = false
			item.get_child(0).displayClick(false)

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			cardFileLocations.append(file_name);
			file_name = dir.get_next()

func GenerateHand():
	if activeCards.size() < 6 && newHand:
		var rand = randi_range(0,cardFileLocations.size()-1)
		var card = load("res://Prefabs/CardPrefabs/" + cardFileLocations[rand]).instantiate()
		activeCards.append(card)
		add_child(card);
		card.z_index = activeCards.size()+100
		card.position.y = 550 + 9*abs(3-activeCards.size())**2;
		card.position.x = activeCards.size()*120+225
		card.rotation = 2*PI - 3*PI/20 +PI/20*activeCards.size()
		card.get_child(0).card_clicked.connect(UpdatePlayerMove)
		UpdateCardHand()
		
		if activeCards.size() == 6:
			newHand = false;

func UpdatePlayerMove(moveArray,attackArray,sender):
	GameManager.selectedCard = sender
	for rule in player.moveRule:
		GameManager.HighlightMoveruleTiles(player.iPos-rule[0],player.jPos-rule[1],Color(1,1,1))
	for rule in player.attackRule:
		GameManager.HighlightMoveruleTiles(player.iPos-rule[0],player.jPos-rule[1],Color(1,1,1))
	player.moveRule = moveArray
	player.attackRule = attackArray
	
func UpdateCardHand():
	var offset = 1+(5-activeCards.size())/2.0;
	for i in range(activeCards.size()):
		activeCards[i].position.y = 550 + 9*abs(3-(i+offset))**2;
		activeCards[i].position.x = (i+offset)*120+225
		activeCards[i].rotation = 2*PI - 3*PI/20 +PI/20*(i+offset)

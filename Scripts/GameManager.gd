extends Node

#var array = [
#			[0,1,1,0,0,0],
#			[1,3,1,1,1,2,2],
#			[1,1,1,1,1,1,1,1,1,0,1,0,1],
#			[0,1,1,1,1,1],
#			[0,1,1,1,1,1],
#			[0,2,1,1,0,0],
#			[0,2,1,1,0,0],
#			]

var array = [
			[2,2,2,2,2,1,1,1,1,1,1,1],
			[2,1,1,1,1,1,1,1,1,1,1,1],
			[2,1,1,1,1,1,1,1,1,1,1,1],
			[2,1,1,1,1,1,1,1,1,1,1,1],
			[2,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			]

var TileArray = array.duplicate(true)
var UnimportantTiles = []
			
var startX = 600;
var startY = 150;
const scaleUI = 0.33

var player
var selectedCard

# Called when the node enters the scene tree for the first time.
func _ready():
	player = preload("res://Prefabs/Player.tscn").instantiate()
	add_child(player);
	player.setPosition(startX,startY,2,2,scaleUI)
	player.z_index = 2+2+1
	
	for i in range(array.size()):
		for j in range(array[i].size()):
			for x in range(array[i][j]):
				var tile = preload("res://Prefabs/Tile.tscn").instantiate()
				add_child(tile)
				tile.z_index = i+j
				tile.get_child(0).tile_clicked.connect(MovePlayer)
				tile.get_child(0).setPosition(startX,startY,i,j,x,array[i][j],scaleUI)
				if array[i][j] == 1:
					TileArray[i][j] = tile
				else:
					UnimportantTiles.append(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for rule in player.moveRule:
		HighlightMoveruleTiles(player.iPos-rule[0],player.jPos-rule[1],Color(0.5,0.5,0.5))

func MovePlayer(newI,newJ):
	var oldI = player.iPos
	var oldJ = player.jPos
	
	for i in range(TileArray.size()):
		for j in range(TileArray[i].size()):
			if !(TileArray[i][j] is int):
				HighlightMoveruleTiles(i,j,Color(1,1,1))
	if player.Move(newI,newJ):
		selectedCard.queue_free()
		OffsetMap(newI-oldI,newJ-oldJ)
		
func OffsetMap(newI,newJ):
	var move = false
	if player.position.y > 350:
		startY -= 64*scaleUI*(newI+newJ)
		move = true
	elif player.position.y < 250:
		startY -= 64*scaleUI*(newI+newJ)
		move = true
	
	if move:
		for i in range(TileArray.size()):
			for j in range(TileArray[i].size()):
				if !(TileArray[i][j] is int):
					TileArray[i][j].get_child(0).updatePosition(startX,startY)
		for i in range(UnimportantTiles.size()):
			UnimportantTiles[i].get_child(0).updatePosition(startX,startY)
		player.updatePosition(startX,startY)

func HighlightMoveruleTiles(iPos,jPos,color):
	if TileArray.size() > iPos && iPos >= 0 \
	&& TileArray[iPos].size() > jPos && jPos >= 0 \
	&& !(TileArray[iPos][jPos] is int):
		TileArray[iPos][jPos].modulate = color;

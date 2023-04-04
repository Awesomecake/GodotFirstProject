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
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1],
			]

var TileArray = array.duplicate(true)
			
var startX = 600;
var startY = 150;
const scaleUI = 0.33

var player

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
		player.moveRule = []
		OffsetMap(newI,newJ)
		
func OffsetMap(newI,newJ):
	var move = false
	if player.position.y > 300:
		startY -= 128*scaleUI 
		move = true
	elif player.position.y < 250:
		startY += 128*scaleUI
		move = true
	
	if move:
		for i in range(TileArray.size()):
			for j in range(TileArray[i].size()):
				if !(TileArray[i][j] is int):
					TileArray[i][j].get_child(0).updatePosition(startX,startY)
		player.updatePosition(startX,startY)
		print(player.position.y)

func HighlightMoveruleTiles(iPos,jPos,color):
	if TileArray.size() > iPos && iPos >= 0 \
	&& TileArray[iPos].size() > jPos && jPos >= 0 \
	&& !(TileArray[iPos][jPos] is int):
		TileArray[iPos][jPos].modulate = color;

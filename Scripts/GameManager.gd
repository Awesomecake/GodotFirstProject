extends Node2D

var array = [
			[0,1,1,0,0,0],
			[1,3,1,1,1,2,2],
			[1,1,1,1,1,1,1,1,1,0,1,0,1],
			[0,1,1,1,1,1],
			[0,1,1,1,1,1],
			[0,2,1,1,0,0],
			[0,2,1,1,0,0],
			]
			
const startX = 600;
const startY = 250;
const scaleUI = 0.33

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://Player.tscn").instantiate()
	add_child(player);
	player.setPosition(startX,startY,2,2,scaleUI)
	player.z_index = 2+2+1
	
	for i in range(array.size()):
		for j in range(array[i].size()):
			for x in range(array[i][j]):
				var tile = preload("res://Tile.tscn").instantiate()
				add_child(tile)
				tile.z_index = i+j
				tile.get_child(0).tile_clicked.connect(player.Move)
				tile.get_child(0).setPosition(startX,startY,i,j,x,array[i][j],scaleUI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node
@export var mapOrigin: Vector2 #map origin in relation to room
@export var debug_result: Variant 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func room_loaded_or_connected(coords: Vector2):
	mapOrigin = Globals.current_coords
	var coord_checking: Vector2 = Vector2(0, 0)
	coord_checking.x =  coords.x+mapOrigin.x
	coord_checking.y =  coords.y+mapOrigin.y
	var result = Globals.check_where_loaded(coord_checking)
	if(typeof(result) == TYPE_STRING):
		if result == "nothing":
			return 'nothing'
	if(typeof(result) == TYPE_ARRAY):
		if (result == [0, 0, 0, 0]):
			return 'origin'
		else:
			return result

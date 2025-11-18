class_name RoomType
extends Resource

enum RoomTypes { CROSSROADS, SHOP }
@export var current_room_type: RoomTypes

@export_category("Adjacent Rooms")
@export var room_above: String
@export var room_below: String
@export var room_left: String
@export var room_right: String
@export_category("Room entrance tiles")
@export var tile_room_above: Vector2
@export var tile_room_below: Vector2
@export var tile_room_left: Vector2
@export var tile_room_right: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#room_above = ("res://rooms/"+ RoomTypes.keys()[randi() % RoomTypes.size()])
	#room_below = ("res://rooms/"+ RoomTypes.keys()[randi() % RoomTypes.size()])
	#room_left = ("res://rooms/"+ RoomTypes.keys()[randi() % RoomTypes.size()])
	#room_right = ("res://rooms/"+ RoomTypes.keys()[randi() % RoomTypes.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

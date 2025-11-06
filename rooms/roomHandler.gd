extends Node2D
class_name RoomHandler

@export var player_loaded: bool = false
@export var player_spawn_pos: String
@export var roomResource: RoomType
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
@export var tiles_list: Array
@export var spawn_distance: int = 75
@export_category("Room_Tilemap")
@export var tileMap: TileMapLayer
@export_category("Room Dictonary")
@export var rooms_list: Array
@export_category("Enemies")
@onready var enemiesFound: Array = get_tree().get_nodes_in_group("EnemyHandler")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	room_above = ("res://rooms/"+ roomResource.RoomTypes.keys()[randi() % roomResource.RoomTypes.size()]+".tscn")
	room_below = ("res://rooms/"+ roomResource.RoomTypes.keys()[randi() % roomResource.RoomTypes.size()]+".tscn")
	room_left = ("res://rooms/"+ roomResource.RoomTypes.keys()[randi() % roomResource.RoomTypes.size()]+".tscn")
	room_right = ("res://rooms/"+ roomResource.RoomTypes.keys()[randi() % roomResource.RoomTypes.size()]+".tscn")
	
	var room_up = {
		"room_path" = room_above,
		"room_coords" = roomResource.tile_room_above,
		"side" = "top"
	}
	var room_down = {
		"room_path" = room_below,
		"room_coords" = roomResource.tile_room_below,
		"side" = "bottom"
	}
	var room_l = {
		"room_path" = room_left,
		"room_coords" = roomResource.tile_room_left,
		"side" = "left"
	}
	var room_r = {
		"room_path" = room_right,
		"room_coords" = roomResource.tile_room_right,
		"side" = "right"
	}
	
	tile_room_above = roomResource.tile_room_above
	tile_room_below = roomResource.tile_room_below
	tile_room_left = roomResource.tile_room_left
	tile_room_right = roomResource.tile_room_right
	
	
	
	tiles_list = [tile_room_above, tile_room_below, tile_room_left, tile_room_right]
	rooms_list = [room_up,room_down,room_l,room_r]
	
	
	
			
	
		
	
	var temp_player: Node2D = load("res://player/Player.tscn").instantiate()
	if(!Globals.originLoaded):
		Globals.origin(Vector2.ZERO)
	Globals.map_room_coord_dic[str(Globals.current_coords)] = 'a'
	temp_player.set_process_mode(Node.PROCESS_MODE_DISABLED)
	player_spawn_pos = Globals.spawn_side
	
		
	match player_spawn_pos:
		'': temp_player.global_position = get_tree().current_scene.get_node("PlayerSpawnPos").global_position
		'top': temp_player.global_position = tileMap.to_global(tileMap.map_to_local(room_up.room_coords))
		
		'bottom': temp_player.global_position = tileMap.to_global(tileMap.map_to_local(room_down.room_coords))
		
		'left': temp_player.global_position = tileMap.to_global(tileMap.map_to_local(room_l.room_coords))
		
		'right': temp_player.global_position = tileMap.to_global(tileMap.map_to_local(room_r.room_coords))
		
		
	
	
	match player_spawn_pos:
		'top': temp_player.global_position.y += spawn_distance
		
		'bottom': temp_player.global_position.y -= spawn_distance
		
		'left': temp_player.global_position.x += spawn_distance
		
		'right': temp_player.global_position.x -= spawn_distance
		
	#match player_spawn_pos:
		#'top': Globals.origin(Vector2(Globals.current_coords.x,Globals.current_coords.y-1))
		#'bottom': Globals.origin(Vector2(Globals.current_coords.x,Globals.current_coords.y+1))
		#'left': Globals.origin(Vector2(Globals.current_coords.x+1,Globals.current_coords.y))
		#'right': Globals.origin(Vector2(Globals.current_coords.x-1,Globals.current_coords.y))
	var temp_particles = load("res://player/particles.tscn").instantiate()
	temp_particles.set_process_mode(Node.PROCESS_MODE_DISABLED)
	add_child(temp_particles)
	add_child(temp_player)
	
	get_node("Player").set_process_mode(Node.PROCESS_MODE_INHERIT)
	get_node("particles").set_process_mode(Node.PROCESS_MODE_INHERIT)
	get_node("particles").reconnect()
	for i in enemiesFound:
		i.set_process_mode(Node.PROCESS_MODE_INHERIT)
		i.reready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawner_enemies_defeated():
	for i in rooms_list:
		var area: Node2D = load("res://rooms/door_area.tscn").instantiate()
		get_tree().current_scene.add_child(area)
		area.side = i.side
		area.scene_to_load = i.room_path
		area.global_position = tileMap.to_global(tileMap.map_to_local(i.room_coords))
		print("gotcha "+str(tileMap.to_global(tileMap.map_to_local(i.room_coords))))

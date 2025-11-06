extends Node
@export var spawn_side: String
@export var starting_scene: PackedScene
@export var room_coord_dic: Dictionary
@export var map_room_coord_dic: Dictionary
@export var current_coords: Vector2 = Vector2.ZERO
@export var saved_scene_count: int = 0
@export var originLoaded: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func save_scene():
	if(starting_scene == null):
		var scene = PackedScene.new()
		scene.pack(get_tree().current_scene)
		return scene
		
	##saving
	#var file_path = "res://map_saves/"+str(Globals.get_saved_scenes())+'.tscn'
	##
	var scene = PackedScene.new()
	print("fin"+str(get_tree().current_scene))
	var children = get_tree().current_scene.get_children()
	for child in children:
		if(!child.is_in_group("Player")):
			child.owner = get_tree().current_scene ##ownership loop (this sucked)
		
	var cool = scene.pack(get_tree().current_scene)
	if cool == OK:
		return cool
		##saving
		#var error = ResourceSaver.save(scene, file_path, 1)
		#if error != OK:
			#push_error("An error occurred while saving the scene to disk.")
		##
	
func get_saved_scenes():
	saved_scene_count += 1
	return saved_scene_count
func check_and_load(coords: Vector2):
	print("find current scene "+str(current_coords))
	var file_path = "res://map_saves/"+str(Globals.get_saved_scenes())+'.tscn'
	get_tree().current_scene.get_node("Player").queue_free()
	var scene = PackedScene.new()
	var cool = scene.pack(get_tree().current_scene)
	ResourceSaver.save(scene, file_path, 1)
	print("finding and current scene "+str(coords))
	room_coord_dic[str(current_coords)] = scene
	map_room_coord_dic[str(current_coords)] = 'a'
	current_coords = coords
	
	if(room_coord_dic.get(str(coords)) != null):
		current_coords = coords
		print("finding2")
		return room_coord_dic.get(str(coords))
func check_where_loaded(coords: Vector2):
	var coords_to_check: Vector2 = coords
	var array: Array = [0, 0, 0, 0] #top #bottom #left #right
	print("result "+ str(coords_to_check))
	if(map_room_coord_dic.get(str(coords_to_check)) == null):
		return 'nothing'
	if(map_room_coord_dic.get(str(coords_to_check)) != null):
		print("result loaded")
		coords_to_check.x = coords.x
		coords_to_check.y = coords.y + 1  #top
		if(map_room_coord_dic.get(str(coords_to_check)) != null):
			array.set(0, 1) #top is true
		coords_to_check.x = coords.x
		coords_to_check.y = coords.y - 1
		if(map_room_coord_dic.get(str(coords_to_check)) != null):
			array.set(1, 1) #bottom is true
		coords_to_check.y = coords.y
		coords_to_check.x = coords.x - 1
		if(map_room_coord_dic.get(str(coords_to_check)) != null):
			array.set(2, 1) #left is true
		coords_to_check.y = coords.y
		coords_to_check.x = coords.x + 1
		if(map_room_coord_dic.get(str(coords_to_check)) != null):
			array.set(3, 1) #right is true
		if array == [0, 0, 0, 0]:
			return array
		return array

func origin(coords: Vector2):
	if(starting_scene == null):
		originLoaded = true
		current_coords = coords
		starting_scene = save_scene()
		print("origin grabbed")
		
		
		
		room_coord_dic[str(Vector2.ZERO)] = starting_scene
		map_room_coord_dic[str(Vector2.ZERO)] = 'a'
	else:
		print("thing " + str(coords))
		add_coords(coords)
	

func add_coords(coords: Vector2):
	var cur_scene = get_tree().current_scene
	current_coords = coords
	print("debug: coords "+str(coords))
	room_coord_dic[str(coords)] = save_scene()
#	room_coord_dic.append(self.get(str(coords)))

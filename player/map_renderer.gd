extends Panel
@export var map_pos: Array[Node2D]
@export var result: Variant
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(map_pos.size()+1):
		var row
		if i >= 1 && i <= 5:
			row = 0
			var coor = Vector2(i-3-(row*5),2)
			result = Maps.room_loaded_or_connected(coor)
			#print("result "+result)
			if(typeof(result) == TYPE_STRING):
				if(result == 'origin'):
					var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
					add_child(icon_to_load)
					icon_to_load.global_position = map_pos[i-1].global_position
				if(result == "nothing"):
					pass
					#var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					#icon_to_load.mapIconResource = load("res://map_handling/map_resources/unloaded.tres")
					#add_child(icon_to_load)
					#icon_to_load.global_position = map_pos[i-1].global_position
			if(typeof(result) == TYPE_ARRAY):
				var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
				icon_to_load.mapIconResource = load("res://map_handling/map_resources/loaded.tres")
				add_child(icon_to_load)
				icon_to_load.global_position = map_pos[i-1].global_position
				print("result " + str(result))
				if(result[0] == 1):
					print("gone up")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection0.tres") #up
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[1] == 1):
					print("gone down")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection1.tres") #down
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[2] == 1):
					print("gone left")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #left
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[3] == 1):
					print("gone right")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #right
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
		if i >= 6 && i <= 10:
			row = 1
			var coor = Vector2(i-3-(row*5),1)
			result = Maps.room_loaded_or_connected(coor)
			#print("result "+str(result))
			if(typeof(result) == TYPE_STRING):
				if(result == 'origin'):
					var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
					add_child(icon_to_load)
					icon_to_load.global_position = map_pos[i-1].global_position
				if(result == "nothing"):
					pass
					#var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					#icon_to_load.mapIconResource = load("res://map_handling/map_resources/unloaded.tres")
					#add_child(icon_to_load)
					#icon_to_load.global_position = map_pos[i-1].global_position
			if(typeof(result) == TYPE_ARRAY):
				var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
				icon_to_load.mapIconResource = load("res://map_handling/map_resources/loaded.tres")
				add_child(icon_to_load)
				icon_to_load.global_position = map_pos[i-1].global_position
				print("result " + str(result))
				if(result[0] == 1):
					print("gone up")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection0.tres") #up
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[1] == 1):
					print("gone down")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection1.tres") #down
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[2] == 1):
					print("gone left")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #left
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[3] == 1):
					print("gone right")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection3.tres") #right
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
		if i >= 11 && i <= 15:
			row = 2
			var coor = Vector2(i-3-(row*5),0)
			result = Maps.room_loaded_or_connected(coor)
			#print("result "+str(result))
			if(typeof(result) == TYPE_STRING):
				if(result == 'origin'):
					var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
					add_child(icon_to_load)
					icon_to_load.global_position = map_pos[i-1].global_position
				if(result == "nothing"):
					pass
					#var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					#icon_to_load.mapIconResource = load("res://map_handling/map_resources/unloaded.tres")
					#add_child(icon_to_load)
					#icon_to_load.global_position = map_pos[i-1].global_position
			if(typeof(result) == TYPE_ARRAY):
				var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
				icon_to_load.mapIconResource = load("res://map_handling/map_resources/loaded.tres")
				if(i == 13):
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
				add_child(icon_to_load)
				icon_to_load.global_position = map_pos[i-1].global_position
				print("result " + str(result))
				if(result[0] == 1):
					print("gone up")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection0.tres") #up
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[1] == 1):
					print("gone down")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection1.tres") #down
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[2] == 1):
					print("gone left")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #left
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[3] == 1):
					print("gone right")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection3.tres") #right
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
		if i >= 16 && i <= 20:
			row = 3
			var coor = Vector2(i-3-(row*5),-1)
			result = Maps.room_loaded_or_connected(coor)
			#print("result "+str(result))
			if(typeof(result) == TYPE_STRING):
				if(result == 'origin'):
					var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
					add_child(icon_to_load)
					icon_to_load.global_position = map_pos[i-1].global_position
				if(result == "nothing"):
					pass
					#var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					#icon_to_load.mapIconResource = load("res://map_handling/map_resources/unloaded.tres")
					#add_child(icon_to_load)
					#icon_to_load.global_position = map_pos[i-1].global_position
			if(typeof(result) == TYPE_ARRAY):
				var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
				icon_to_load.mapIconResource = load("res://map_handling/map_resources/loaded.tres")
				add_child(icon_to_load)
				icon_to_load.global_position = map_pos[i-1].global_position
				print("result " + str(result))
				if(result[0] == 1):
					print("gone up")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection0.tres") #up
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[1] == 1):
					print("gone down")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection1.tres") #down
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[2] == 1):
					print("gone left")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #left
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[3] == 1):
					print("gone right")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection3.tres") #right
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
		if i >= 21 && i <= 25:
			row = 4
			var coor = Vector2(i-3-(row*5),-2)
			result = Maps.room_loaded_or_connected(coor)
			#print("result "+str(result))
			if(typeof(result) == TYPE_STRING):
				if(result == 'origin'):
					var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					icon_to_load.mapIconResource = load("res://map_handling/map_resources/origin.tres")
					add_child(icon_to_load)
					icon_to_load.global_position = map_pos[i-1].global_position
				if(result == "nothing"):
					pass
					#var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					#icon_to_load.mapIconResource = load("res://map_handling/map_resources/unloaded.tres")
					#add_child(icon_to_load)
					#icon_to_load.global_position = map_pos[i-1].global_position
			if(typeof(result) == TYPE_ARRAY):
				var icon_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
				icon_to_load.mapIconResource = load("res://map_handling/map_resources/loaded.tres")
				add_child(icon_to_load)
				icon_to_load.global_position = map_pos[i-1].global_position
				print("result " + str(result))
				if(result[0] == 1):
					print("gone up")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection0.tres") #up
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[1] == 1):
					print("gone down")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection1.tres") #down
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[2] == 1):
					print("gone left")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection2.tres") #left
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
				if(result[3] == 1):
					print("gone right")
					var layer_to_load = load("res://map_handling/map_icon_sprite.tscn").instantiate()
					layer_to_load.mapIconResource = load("res://map_handling/map_resources/connection3.tres") #right
					add_child(layer_to_load)
					layer_to_load.global_position = map_pos[i-1].global_position
		Maps.debug_result = result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

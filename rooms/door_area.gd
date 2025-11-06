extends Node2D
@export var scene_to_load: String
@export var side: String
@export var scene_found: PackedScene
@export var door_disabled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	scene_found = null
	if(body.is_in_group("Player")):
		print("yippie")
		Globals.save_scene()
		if(scene_to_load != null):
			match side:
				'top': Globals.spawn_side = 'bottom'
				'bottom': Globals.spawn_side = 'top'
				'left': Globals.spawn_side = 'right'
				'right': Globals.spawn_side = 'left'
			match side:
				'top': scene_found = Globals.check_and_load(Vector2(Globals.current_coords.x,Globals.current_coords.y+1))
				'bottom': scene_found = Globals.check_and_load(Vector2(Globals.current_coords.x,Globals.current_coords.y-1)) 
				'left': scene_found = Globals.check_and_load(Vector2(Globals.current_coords.x-1,Globals.current_coords.y))
				'right': scene_found = Globals.check_and_load(Vector2(Globals.current_coords.x+1,Globals.current_coords.y))
			door_disabled = true
			
			if(scene_found == null):
				print("finding null")
				
				get_tree().change_scene_to_file(scene_to_load)
			else:
				get_tree().change_scene_to_packed(scene_found)
				
			
			


func _on_area_2d_body_exited(body):
	pass

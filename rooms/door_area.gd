extends Node2D
@export var scene_to_load: String
@export var side: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		print("yippie")
		if(scene_to_load != null):
			match side:
				'top': Globals.spawn_side = 'bottom'
				'bottom': Globals.spawn_side = 'top'
				'left': Globals.spawn_side = 'right'
				'right': Globals.spawn_side = 'left'
			get_tree().change_scene_to_file(scene_to_load)

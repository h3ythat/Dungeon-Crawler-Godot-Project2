class_name TileArea
extends Area2D
@export var tilemap: TileMapLayer
@export var tilecoords: Vector2i
enum Type { rock }
@export var type: Type
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func sword_collide():
	
	print("ow")
	var rock_break_sfx: AudioStreamPlayer2D = load("res://SFX/sfx_player.tscn").instantiate()
	rock_break_sfx.set_stream(load("res://SFX/Rocks/rock_break.mp3"))
	rock_break_sfx.set_volume_db(10)
	self.add_sibling(rock_break_sfx)
	
	var spawn_count = randi_range(1, 7)
	for i in spawn_count:
		var item_loading: ItemForm = load("res://item_form.tscn").instantiate()
		item_loading.Type = ItemForm.ResourceType.rock
		item_loading.global_position = global_position
		print("SPAWN COUNT: "+str(i))
		self.add_sibling(item_loading)
		if(i == spawn_count-1):
			queue_free()
	tilemap.set_cell(tilecoords)
	

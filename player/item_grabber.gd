extends Node2D
@export var closest_node: Node2D
var old_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var area_list: Array = $Area2D.get_overlapping_areas()
	var interactable_list: Array = []
	for i: Area2D in area_list:
		if(i.is_in_group("interactable")):
			interactable_list.append(i)
	for i in area_list.size():
		if i == area_list.size() - 1:
			done()
	await done()
	print("checked all")
	
	for i: Node2D in interactable_list:
		if closest_node == null:
			closest_node = i
			print("checked AAL")
		else:
			if(self.global_position.distance_to(i.global_position) < self.global_position.distance_to(closest_node.global_position)):
				old_node = closest_node
				old_node.cur_sprite.set_material(null)
				closest_node = i
	if interactable_list == []:
		if(closest_node != null):
			old_node = closest_node
			old_node.cur_sprite.set_material(null)
			closest_node = null
		
	if(closest_node != null):
		closest_node.cur_sprite.set_material((load("res://selected_interactable.tres")))

func done():
	pass


	

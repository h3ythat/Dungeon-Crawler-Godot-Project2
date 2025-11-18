extends Node
@export_category("Resources")
@export var Rocks: int = 0
@export var slot1: PickUpContainer #most recent / bottom
@export var slot2: PickUpContainer
@export var slot3: PickUpContainer #oldest / top

@onready var player_UI = get_tree().current_scene.get_node("Player/CharacterBody2D/Camera2D/Control/CanvasLayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func PickUpLogInit(type: ItemForm.ResourceType):
	if(slot1 == null):
		var temp_slot1: Control = load("res://UI/PickUpLog/pickuplogcontainer.tscn").instantiate()
		temp_slot1.resourceType = type
		temp_slot1.add_child(player_UI)
		slot1 = temp_slot1
		slot1.pickedup()
		slot1.cur_slot = PickUpContainer.Slot.one
	else:
		slot2 = slot1
		slot2.set_name("slot2")
		slot2.cur_slot = PickUpContainer.Slot.two
		slot2.move()
		

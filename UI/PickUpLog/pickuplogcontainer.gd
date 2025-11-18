class_name PickUpContainer
extends Control
enum Slot { one, two, three }
@export var resourceType: ItemForm.ResourceType
@export var collectNum: int
@export var cur_slot: Slot
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load("res://itemFormTextures/"+ItemForm.ResourceType.find_key(resourceType)+"_item_texture.png")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Collected.text = (str(collectNum) + "x")
	$ItemType.text = ItemForm.ResourceType.find_key(resourceType)
	
func pickedup():
	collectNum += 1
func move():
	match cur_slot:
		Slot.two:
			self.position.y -= self.size.y

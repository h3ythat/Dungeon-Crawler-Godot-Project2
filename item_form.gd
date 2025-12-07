class_name ItemForm
extends CharacterBody2D
enum ResourceType { rock, ruby, coin }
@export var Type: ResourceType
@export var itemSprite: Sprite2D
@export var Player: Node2D
@export var Speed: float = 600

@export var knockback: bool = true
@export var ui_process: bool = false
@export var move_to_pos: Vector2
@export var going_to_wallet: bool = false
@export var worth: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if(!ui_process):
		Player = Globals.player
		var rand_angle = randf() * TAU
		var random_dir = Vector2(cos(rand_angle), sin(rand_angle))
		rotate(randf_range(0, 20))
		velocity = random_dir * 300
		scale = Vector2(0.4, 0.4)
		itemSprite.texture = load("res://itemFormTextures/"+ResourceType.find_key(Type)+"_item_texture.png")
		await get_tree().create_timer(.6).timeout
		knockback = false
	else:
		Player = Globals.player
		rotate(randf_range(0, 20))
		scale = Vector2(0.4, 0.4)
		itemSprite.texture = load("res://itemFormTextures/"+ResourceType.find_key(Type)+"_item_texture.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Player != null && knockback == false && !ui_process):
		var target_pos = (Player.get_node("CharacterBody2D").global_position - global_position).normalized()
		look_at(Player.get_node("CharacterBody2D").global_position)
		velocity = target_pos * Speed
	if(ui_process):
		look_at(move_to_pos)
		var target_pos = (move_to_pos - global_position).normalized()
		velocity = target_pos * (Speed/2)
	move_and_slide()


func _on_scene_prototype_player_created():
	Player = get_tree().get_current_scene().get_node("Player")


func _on_area_2d_body_entered(body):
	if(body.is_in_group("Player") && !ui_process):
		var rock_pickup_sfx: AudioStreamPlayer2D = load("res://SFX/sfx_player.tscn").instantiate()
		rock_pickup_sfx.set_stream(load("res://SFX/Rocks/rock_pickup.mp3"))
		rock_pickup_sfx.set_volume_db(10)
		self.add_sibling(rock_pickup_sfx)
		PlayerResources.itemInvAdd(Type)
		PlayerResources.PickUpLogInit(Type)
		queue_free()
		
func _on_area_2d_area_entered(area):
	if(area.is_in_group("ARM") && !going_to_wallet):
		var rock_pickup_sfx: AudioStreamPlayer2D = load("res://SFX/sfx_player.tscn").instantiate()
		rock_pickup_sfx.set_stream(load("res://SFX/Rocks/rock_pickup.mp3"))
		rock_pickup_sfx.set_volume_db(10)
		self.add_sibling(rock_pickup_sfx)
	
		
		var item_loading: ItemForm = load("res://item_form.tscn").instantiate()
		item_loading.Type = ResourceType.coin
		item_loading.global_position = area.coin_pos()
		item_loading.ui_process = true
		item_loading.going_to_wallet = true
		item_loading.move_to_pos = PlayerResources.ARM_money_pos
		item_loading.worth = self.worth
		print("sick "+str(item_loading.move_to_pos))
		get_tree().current_scene.add_child(item_loading)
		queue_free()
	if(area.is_in_group("coin") && going_to_wallet):
		var rock_pickup_sfx: AudioStreamPlayer2D = load("res://SFX/sfx_player.tscn").instantiate()
		rock_pickup_sfx.set_stream(load("res://SFX/Rocks/rock_pickup.mp3"))
		rock_pickup_sfx.set_volume_db(10)
		self.add_sibling(rock_pickup_sfx)
		PlayerResources.Money += worth
		queue_free()

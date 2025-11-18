class_name ItemForm
extends CharacterBody2D
enum ResourceType { rock }
@export var Type: ResourceType
@export var itemSprite: Sprite2D
@export var Player: Node2D
@export var Speed: float = 600

@export var knockback: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = Globals.player
	var rand_angle = randf() * TAU
	var random_dir = Vector2(cos(rand_angle), sin(rand_angle))
	rotate(randf_range(0, 20))
	velocity = random_dir * 300
	scale = Vector2(0.4, 0.4)
	itemSprite.texture = load("res://itemFormTextures/"+ResourceType.find_key(Type)+"_item_texture.png")
	await get_tree().create_timer(.6).timeout
	knockback = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Player != null && knockback == false):
		var target_pos = (Player.get_node("CharacterBody2D").global_position - global_position).normalized()
		look_at(Player.get_node("CharacterBody2D").global_position)
		velocity = target_pos * Speed
		
	move_and_slide()


func _on_scene_prototype_player_created():
	Player = get_tree().get_current_scene().get_node("Player")


func _on_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		var rock_pickup_sfx: AudioStreamPlayer2D = load("res://SFX/sfx_player.tscn").instantiate()
		rock_pickup_sfx.set_stream(load("res://SFX/Rocks/rock_pickup.mp3"))
		rock_pickup_sfx.set_volume_db(10)
		self.add_sibling(rock_pickup_sfx)
		PlayerResources.Rocks += 1
		PlayerResources.PickUpLogInit(Type)
		queue_free()

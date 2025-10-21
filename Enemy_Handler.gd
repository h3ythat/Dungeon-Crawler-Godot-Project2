extends Node2D
signal enemyDeprecated

var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		var particleEffect: Node2D = load("res://confetti.tscn").instantiate()
		particleEffect.global_position = global_position
		self.add_sibling(particleEffect) 
		emit_signal("enemyDeprecated")
		queue_free()
	self.global_position = $CharacterBody2D.global_position
func take_damage(damage):
	print(self.name +  str(damage)+" damage taken.")
	health -= damage
	print(self.name + str(health)+" remaining")
func take_knockback(rotat_speed: int, player_velocity: Vector2, player_pos: Vector2):
	$CharacterBody2D.velocity +=  (player_pos - self.global_position).normalized() * rotat_speed *20
func return_node():
	return self

func _on_area_2d_body_entered(body: Node):
	if(body.is_in_group("Player")):
		print("yippie")

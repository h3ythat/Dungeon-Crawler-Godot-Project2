extends Node2D
signal enemyDeprecated
var knockback: Vector2 = Vector2.ZERO 
var health = 100
var knockback_timer: float = 0.0
var k_direction
var current_velocity: float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(knockback_timer > 0.0):
		if(current_velocity < 0):
			current_velocity = lerp(current_velocity, 0.0, 20*delta)
		
		print("slowing down "+str(current_velocity))
		$CharacterBody2D.velocity = k_direction * current_velocity
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		$CharacterBody2D.velocity = Vector2.ZERO
	

	if(health <= 0):
		var particleEffect: Node2D = load("res://confetti.tscn").instantiate()
		particleEffect.global_position = global_position
		self.add_sibling(particleEffect) 
		emit_signal("enemyDeprecated")
		queue_free()
	#self.global_position = $CharacterBody2D.global_position
func take_damage(damage):
	print(self.name +  str(damage)+" damage taken.")
	health -= damage
	print(self.name + str(health)+" remaining")
func take_knockback(rotat_speed: int, player_velocity: Vector2, player_pos: Vector2, knockback_duration: float):
	print("WOAHA "+str((player_pos - self.global_position).normalized()))
	print((self.global_position - player_pos).normalized()  * rotat_speed *10)
	k_direction = (player_pos - $CharacterBody2D.global_position).normalized()
	current_velocity = -4000.0
	knockback = k_direction * -4000
	knockback_timer = knockback_duration
	#$CharacterBody2D.velocity =  (self.global_position - player_pos).normalized()  * rotat_speed * 2 
	
func return_node():
	return self

func _on_area_2d_body_entered(body: Node):
	if(body.is_in_group("Player")):
		print("yippie")


extends Node2D


signal enemyDeprecated
var knockback: Vector2 = Vector2.ZERO 
#var health = 100
var knockback_timer: float = 0.0
var k_direction
var current_velocity: float
#var speed = 150
var target: Node2D
var rng = RandomNumberGenerator.new()
var dash_timer: Timer
@export var stats: EnemyType
@onready var health: float = stats.health
@onready var speed: float = stats.speed
@onready var sprite: Texture2D = stats.sprite_texture
@export var enemyClass: EnemyType.EnemyClass

@onready var Player: Node2D

@export_group("Dash Class")
@export var dash_time_active: bool = false
@export var follow_active: bool = true
@export var proximity_indicator: Node2D
signal color_change_commence

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_tree().current_scene.get_node("Player")
	enemyClass = stats.enemy_type
	if(enemyClass == EnemyType.EnemyClass.DASH):
		var indicator_preload: Node2D = load("res://enemy/dash_look_at.tscn").instantiate()
		$CharacterBody2D.add_child(indicator_preload)
		proximity_indicator = get_node("CharacterBody2D/dash_indicator")
		
		if(get_node("Dash_timer") == null):
			var temp_dash_timer = Timer.new()
			temp_dash_timer.set_name("Dash_timer")
			add_child(temp_dash_timer)
			dash_timer = get_node("Dash_timer")
			dash_time_active = true
			
	
	if stats.sprite_texture != null:
		$"CharacterBody2D/Sprite2D".set_texture(stats.sprite_texture)
	target = get_tree().current_scene.get_node("Player/CharacterBody2D")
	call_deferred("path_finding_setup")
func reready():
	Player = get_tree().current_scene.get_node("Player")
	enemyClass = stats.enemy_type
	if(enemyClass == EnemyType.EnemyClass.DASH):
		var indicator_preload: Node2D = load("res://enemy/dash_look_at.tscn").instantiate()
		$CharacterBody2D.add_child(indicator_preload)
		proximity_indicator = get_node("CharacterBody2D/dash_indicator")
		
		if(get_node("Dash_timer") == null):
			var temp_dash_timer = Timer.new()
			temp_dash_timer.set_name("Dash_timer")
			add_child(temp_dash_timer)
			dash_timer = get_node("Dash_timer")
			dash_time_active = true
			
	
	if stats.sprite_texture != null:
		$"CharacterBody2D/Sprite2D".set_texture(stats.sprite_texture)
	target = get_tree().current_scene.get_node("Player/CharacterBody2D")
	call_deferred("path_finding_setup")
func path_finding_setup():
	await get_tree().physics_frame
	if target:
		$CharacterBody2D/NavigationAgent2D.target_position = target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!follow_active && enemyClass == EnemyType.EnemyClass.DASH):
		proximity_indicator.set_visible(true)
		proximity_indicator.set_modulate(lerp(proximity_indicator.get_modulate(), Color(1.0, 0.0, 0.232, 1.0), delta*0.7))
	if target:
		$CharacterBody2D/NavigationAgent2D.target_position = target.global_position
	var current_agent_pos = $CharacterBody2D.global_position
	if(follow_active):
		proximity_indicator.set_visible(false)
		var next_pos = $CharacterBody2D/NavigationAgent2D.get_next_path_position()
		
	if(knockback_timer > 0.0):
		if(current_velocity < 0):
			current_velocity = lerp(current_velocity, 0.0, 20*delta)
		
		print("slowing down "+str(current_velocity))
		$CharacterBody2D.velocity = k_direction * current_velocity
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		if(follow_active):
			var dir = to_local($CharacterBody2D/NavigationAgent2D.get_next_path_position()).normalized()
			$CharacterBody2D.velocity = current_agent_pos.direction_to($CharacterBody2D/NavigationAgent2D.get_next_path_position()) * speed
		
			 
	

	customEnemyClassBehaviour()
	
	if(health <= 0):
		var particleEffect: Node2D = load("res://enemy/confetti.tscn").instantiate()
		particleEffect.global_position = $CharacterBody2D.global_position
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

func pathmaker():
	$Timer.start()
	await $Timer.timeout
	$CharacterBody2D/NavigationAgent2D.target_position = get_tree().current_scene.get_node("Player/CharacterBody2D").global_position
func return_node():
	return self

func _on_area_2d_body_entered(body: Node):
	if(body.is_in_group("Player")):
		print("yippie")


func _on_navigation_agent_2d_target_reached():
	pass



func customEnemyClassBehaviour():
	if(target != null):
		if(enemyClass == EnemyType.EnemyClass.DASH && proximity_indicator != null):
			proximity_indicator.look_at(target.global_position)
		if(enemyClass == EnemyType.EnemyClass.DASH && get_node("Dash_timer") != null):
			
			if(dash_time_active):
				dash_time_active = false
				dash_timer.set_wait_time(rng.randf_range(5, 10.0))
				dash_timer.start()
				await dash_timer.timeout
				print("dash complete ")
				
				if($CharacterBody2D.global_position.distance_to(target.global_position) <= 300):
					print("dash possible")
					
					proximity_indicator.set_modulate(Color(0.248, 0.884, 0.138, 1.0))
					print($CharacterBody2D.global_position.distance_to(target.global_position))
					follow_active = false
					$CharacterBody2D.velocity = Vector2.ZERO
					var new_target_pos = target.global_position
					await get_tree().create_timer(2).timeout
					var dir = ((target.global_position - $CharacterBody2D.global_position).normalized())
					$CharacterBody2D.velocity += dir * 500
					await get_tree().create_timer(.5).timeout
					follow_active = true
				dash_time_active = true
		
			

extends Node2D
var rotation_speed = 0.05
var rotat
var new_rotat
var current_rotat
@export var shad: ShaderMaterial
var charged_weapon = false
var teleporting = false

signal line1pos
signal line2pos
signal SLASH
signal done_slash
signal attack_not_detected
signal attack_detected
signal slash_sfx_sig


var slash_sound_effect = preload("res://player/slash_audio.tscn")
@onready var point_1: Node2D = $"Particle point 1"
@onready var point_2: Node2D = $"Particle point 2"

@onready var particle_handler = $"../../../particles"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var scene_loaded = get_tree().current_scene.get("scene_loaded")
	
	print("loaded")
	particle_handler.weapon_charged.connect(self.sword_charged_shader)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !teleporting:
		if(Input.is_action_just_pressed("rotate_sword_left")):
			rotat = self.get_rotation()
			new_rotat = rotat - 3.14159*3
		if(Input.is_action_pressed("rotate_sword_left")):
			current_rotat = self.get_rotation()
			if(rotation_speed < 0.35):
				rotation_speed = rotation_speed + (0.65*delta)
			else:
				print("hungryz")
				SLASH.emit()
				print(rotat)
				print(new_rotat)
			if(new_rotat != null && current_rotat > new_rotat):
				rotate(-1*rotation_speed)
			if(rotation_speed > 0.05):
				slash_sfx_sig.emit()
			if(new_rotat != null && current_rotat < new_rotat):
				done_slash.emit(rotation_speed)
				rotation_speed = 0.05
				
				charged_weapon = false
		
		if(Input.is_action_just_pressed("rotate_sword_right")):
			rotat = self.get_rotation()
			new_rotat = rotat + 3.14159*3
		if(Input.is_action_pressed("rotate_sword_right")):
			current_rotat = self.get_rotation()
			if(rotation_speed < 0.30):
				rotation_speed = rotation_speed + (0.65*delta)
				print(rotation_speed)
			else:
				print("hungryz")
				SLASH.emit()
				print(rotat)
				print(new_rotat)
			if(rotation_speed > 0.05):
				slash_sfx_sig.emit()
			if(current_rotat < new_rotat):
				rotate(rotation_speed)
			if(current_rotat >= new_rotat):
				done_slash.emit(rotation_speed)
				rotation_speed = 0.05
				
				charged_weapon = false
		if(Input.is_action_just_released("rotate_sword_left") || Input.is_action_just_released("rotate_sword_right")):
			done_slash.emit(rotation_speed)
			rotation_speed = 0.05
			
			charged_weapon = false
		if(Input.is_action_just_pressed("rotate_sword_left") || Input.is_action_just_pressed("rotate_sword_right")):
			attack_detected.emit(rotation_speed)
			
		if(Input.is_action_pressed("rotate_sword_left") || Input.is_action_pressed("rotate_sword_right")):
			line1pos.emit(point_1.global_position, current_rotat)
			#zzline2pos.emit(point_2.global_position, current_rotat)
		if(!Input.is_action_pressed("rotate_sword_left") && !Input.is_action_pressed("rotate_sword_right")):
			attack_not_detected.emit()
			#print(Line1.points.size())
			#if(Line1.points.size() < 30):
				#line1pos.emit(point_1.global_position)
				#Line1.add_point(point_1.global_position)
			#else:
				#Line1.points.remove_at(0)
		
		if(charged_weapon == true && shad != null):
			shad.set_shader_parameter("blend_strength", shad.get_shader_parameter("blend_strength")+0.08)
			print("DRIVING IN MY CAR")
		else:
			if(shad != null):
				while($Sword.material.get_shader_parameter("blend_strength") > 0.1):
					await get_tree().create_timer(.1).timeout
					if($Sword.material.get_shader_parameter("blend_strength") >= 0):
						shad.set_shader_parameter("blend_strength", shad.get_shader_parameter("blend_strength")-0.01)
					else:
						
						await get_tree().create_timer(.1).timeout
						shad.set_shader_parameter("blend_strength", 0)
func sword_charged_shader():
	charged_weapon = true
	shad = $Sword.material
func sword_decharged():
	pass
	
	
func awaiting_load():
	print("loaded")

	


func _on_left_body_entered(body: Node):
	if(body.is_in_group("Enemy") && rotation_speed > 0.05):
		$LeftCast/Node2D.position = $LeftCast.target_position
		print("TEST")
		var current_enemy = body.get_parent()
		print("Attack commenced")
		add_child(slash_sound_effect.instantiate())
		var dealt_damage = rotation_speed * 100
		if(charged_weapon == false):
			current_enemy.take_damage(dealt_damage)
			current_enemy.take_knockback(rotat, get_parent().velocity, get_parent().global_position, 0.12)
		if(charged_weapon == true):
			current_enemy.take_damage(dealt_damage+20)
			current_enemy.take_knockback(rotat, get_parent().velocity, get_parent().global_position, 0.1)


func _on_right_body_entered(body):
	pass # Replace with function body.


func _on_top_jab_body_entered(body):
	pass # Replace with function body.

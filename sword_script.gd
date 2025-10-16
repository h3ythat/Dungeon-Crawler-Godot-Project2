extends Node2D
var rotation_speed = 0.05
var rotat
var new_rotat
var current_rotat
@export var shad: ShaderMaterial
var charged_weapon = false

signal line1pos
signal line2pos
signal SLASH
signal done_slash
signal attack_not_detected
signal attack_detected

@onready var point_1: Node2D = $"Particle point 1"
@onready var point_2: Node2D = $"Particle point 2"
@onready var Line1: Line2D = $"../Line1"
@onready var Line2: Line2D = $"../Line2"
@onready var particle_handler = $"../../../particles"

# Called when the node enters the scene tree for the first time.
func _ready():
	particle_handler.weapon_charged.connect(self.sword_charged_shader)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		if(current_rotat > new_rotat):
			rotate(-1*rotation_speed)
		if(current_rotat < new_rotat):
			rotation_speed = 0.05
			done_slash.emit()
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
		if(current_rotat < new_rotat):
			rotate(rotation_speed)
		if(current_rotat >= new_rotat):
			rotation_speed = 0.05
			done_slash.emit()
			charged_weapon = false
	if(Input.is_action_just_released("rotate_sword_left") || Input.is_action_just_released("rotate_sword_right")):
		rotation_speed = 0.05
		done_slash.emit()
		charged_weapon = false
	if(Input.is_action_just_pressed("rotate_sword_left") || Input.is_action_just_pressed("rotate_sword_right")):
		attack_detected.emit()
	if(Input.is_action_pressed("rotate_sword_left") || Input.is_action_pressed("rotate_sword_right")):
		line1pos.emit(point_1.global_position, current_rotat)
		line2pos.emit(point_2.global_position, current_rotat)
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
					shad.set_shader_parameter("blend_strength", -0.1)
					await get_tree().create_timer(.1).timeout
					shad.set_shader_parameter("blend_strength", 0)
func sword_charged_shader():
	charged_weapon = true
	shad = $Sword.material
func sword_decharged():
	pass
	
	

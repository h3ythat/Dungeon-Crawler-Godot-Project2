extends Node2D
var rotation_speed = 0.05
var rotat
var new_rotat
var current_rotat
signal line1pos
signal line2pos
@onready var point_1: Node2D = $"Particle point 1"
@onready var point_2: Node2D = $"Particle point 2"
@onready var Line1: Line2D = $"../Line1"
@onready var Line2: Line2D = $"../Line2"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("rotate_sword_left")):
		rotat = self.get_rotation()
		new_rotat = rotat - 3.14159*3
	if(Input.is_action_pressed("rotate_sword_left")):
		current_rotat = self.get_rotation()
		if(rotation_speed < 0.30):
			rotation_speed = rotation_speed + (0.36*delta)
		else:
			print("hungryz")
			print(rotat)
			print(new_rotat)
		if(current_rotat > new_rotat):
			rotate(-1*rotation_speed)
		if(current_rotat < new_rotat):
			rotation_speed = 0.05
	
	if(Input.is_action_just_pressed("rotate_sword_right")):
		rotat = self.get_rotation()
		new_rotat = rotat + 3.14159*3
	if(Input.is_action_pressed("rotate_sword_right")):
		current_rotat = self.get_rotation()
		if(rotation_speed < 0.30):
			rotation_speed = rotation_speed + (0.35*delta)
			print(rotation_speed)
		else:
			print("hungryz")
			print(rotat)
			print(new_rotat)
		if(current_rotat < new_rotat):
			rotate(rotation_speed)
		if(current_rotat >= new_rotat):
			rotation_speed = 0.05
	if(Input.is_action_just_released("rotate_sword_left") || Input.is_action_just_released("rotate_sword_right")):
		rotation_speed = 0.05
		
	if(Input.is_action_pressed("rotate_sword_left") || Input.is_action_pressed("rotate_sword_right")):
		line1pos.emit(point_1.global_position)
		line2pos.emit(point_2.global_position)
		#print(Line1.points.size())
		#if(Line1.points.size() < 30):
			#line1pos.emit(point_1.global_position)
			#Line1.add_point(point_1.global_position)
		#else:
			#Line1.points.remove_at(0)

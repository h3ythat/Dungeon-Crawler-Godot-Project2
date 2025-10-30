extends RigidBody2D
const SPEED = 300
const JUMP_VELOCITY = -400.0
var grappled = true
@export var current_joint: Joint2D
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	
	player = self.get_node("../CharacterBody2D")
	

func _process(delta):
	if(Input.is_action_pressed("ui_accept")):
		grappled = false
	if(grappled):
		var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
		# Horizontal movement
		if input_direction.x != 0:
			apply_central_force(Vector2(input_direction.x * SPEED, 0))
			
			# Jumping
		if Input.is_action_just_pressed("jump"):
			apply_central_impulse(Vector2(0, -JUMP_VELOCITY))
		
		player.rotation = self.rotation
		player.global_position = self.global_position
	
	else:
		if(current_joint != null):
			current_joint.queue_free()
		self.position = player.position
		player.set_rotation_degrees(0)
		if not player.is_on_floor():
			player.velocity += get_gravity() * delta

	
		var direction = Input.get_axis("ui_left", "ui_right")
		#var dir2 = Vector2( global_position - self.get_node("../CharacterBody2D").global_position).normalized()
		if direction:
			
			#player.velocity = dir2 * 300
			player.velocity.x = direction * SPEED
		else:
			#pass
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
			#player.velocity = dir2 * 300
			
	player.move_and_slide()
	

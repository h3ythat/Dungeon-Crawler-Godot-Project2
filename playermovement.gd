extends CharacterBody2D
var rolling = false 
var ability_to_roll = true

const speed = 300.0
const Acceleration = 20

var movement_input: Vector2

func get_input():
	movement_input.x = Input.get_action_strength("Right_Movement") - Input.get_action_strength("Left_Movement")
	movement_input.y = Input.get_action_strength("Down_Movement") - Input.get_action_strength("Up_Movement")
	$RayCast2D.look_at(movement_input)
	return movement_input.normalized()

func dash_sfx():
	var DashSfx: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	DashSfx.set_stream(load("res://SFX/Dash/woosh.mp3")) 
	self.add_child(DashSfx)
	DashSfx.play()
	
func _physics_process(delta):
	var playerMovementInput = get_input()
	if(Input.is_action_pressed("dash") && ability_to_roll):
		dash_sfx()
		$Control/TextureProgressBar.set_self_modulate(Color(1, 1, 1, 1))
		$Control/TextureProgressBar/Sprite2D.set_self_modulate(Color(1, 1, 1, 1))
		$Control/TextureProgressBar.set_visible(true)
		$Control/TextureProgressBar/Sprite2D.set_visible(true)
		$Control/TextureProgressBar.set_value(-20)
		rolling = true
		velocity = lerp(velocity, playerMovementInput * speed, delta * Acceleration)*8
		
	if($Control/TextureProgressBar.value < 100):
		ability_to_roll = false
		$Control/TextureProgressBar.set_value($Control/TextureProgressBar.value+3)
	if($Control/TextureProgressBar.value >= 100):
		ability_to_roll = true
		$Control/TextureProgressBar.set_self_modulate(Color(1, 1, 1, $Control/TextureProgressBar.get_self_modulate().a -0.05))
		$Control/TextureProgressBar/Sprite2D.set_self_modulate(Color(1, 1, 1, $Control/TextureProgressBar/Sprite2D.get_self_modulate().a -0.05))
		if($Control/TextureProgressBar.get_self_modulate().a == 0):
			$Control/TextureProgressBar.set_visible(false)
			$Control/TextureProgressBar/Sprite2D.set_visible(false)
	velocity = lerp(velocity, playerMovementInput * speed, delta * Acceleration)
	
	move_and_slide()
	
	if(rolling):
		
		if($Player.rotation_degrees < 360):
			
			$Player.rotate(0.4)
			rolling = true
		if $Player.rotation_degrees >= 360:
			$Player.set_rotation_degrees(0)
			
			rolling = false

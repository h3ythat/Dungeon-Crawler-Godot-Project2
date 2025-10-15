extends CharacterBody2D


const speed = 300.0
const Acceleration = 20

var movement_input: Vector2

func get_input():
	movement_input.x = Input.get_action_strength("Right_Movement") - Input.get_action_strength("Left_Movement")
	movement_input.y = Input.get_action_strength("Down_Movement") - Input.get_action_strength("Up_Movement")
	return movement_input.normalized()
	

func _physics_process(delta):
	var playerMovementInput = get_input()
	
	velocity = lerp(velocity, playerMovementInput * speed, delta * Acceleration)
	
	move_and_slide()

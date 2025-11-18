extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel/switch_object_target.text = InputMap.action_get_events("switch_target").front().as_text()+ " to switch targeted object."
	$Panel2/interact.text = InputMap.action_get_events("interact").front().as_text()+ " to interact."

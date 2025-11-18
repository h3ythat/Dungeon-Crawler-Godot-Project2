extends Node2D
@export var price: float = 10.00

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var converted_str = "%.2f" % price
	$RichTextLabel.text = "$"+str(converted_str)

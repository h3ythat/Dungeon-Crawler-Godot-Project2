extends Node2D
@onready var Line1: Line2D = $Line1
@onready var Line2: Line2D = $Line2

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Player/CharacterBody2D/Node2D".line1pos.connect(self.line1maker)
	$"../Player/CharacterBody2D/Node2D".line2pos.connect(self.line2maker)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func line1maker(lpos: Vector2):
	print(Line1.points.size())
	if(Line1.points.size() < 60):
		Line1.add_point(lpos)
		
	else:
		Line1.remove_point(0)
		Line1.remove_point(0)
		Line1.add_point(lpos)

func line2maker(lpos: Vector2):
	print(Line2.points.size())
	if(Line2.points.size() < 60):
		Line2.add_point(lpos)
		
	else:
		Line2.remove_point(0)
		Line2.remove_point(0)
		Line2.add_point(lpos)		
		
	
	

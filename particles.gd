extends Node2D
@onready var Line1: Line2D = $Line1
@onready var Line2: Line2D = $Line2
var slashd: bool = false
var attack_active = false
var prev_rotat

signal weapon_charged
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Player/CharacterBody2D/Node2D".line1pos.connect(self.line1maker)
	$"../Player/CharacterBody2D/Node2D".line2pos.connect(self.line2maker)
	$"../Player/CharacterBody2D/Node2D".SLASH.connect(self.slash)
	$"../Player/CharacterBody2D/Node2D".done_slash.connect(self.dslash)
	$"../Player/CharacterBody2D/Node2D".attack_not_detected.connect(self.no_attack_input)
	$"../Player/CharacterBody2D/Node2D".attack_detected.connect(self.attack_input)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(attack_active == false):
		#Line1.clear_points()
	if(Line1.points.size() > 20):
		Line1.remove_point(0)
		Line1.remove_point(0)
	if(!slashd):
		Line1.width = 7+(Line1.width*delta*2)
		
		Line1.set_gradient(load("res://gradient_normal.tres"))
		#var cool: Color = Color(1.0, 0.2, 0.153, 0.741) 
#		Line1.gradient.set_color(1, cool)
		
func line1maker(lpos: Vector2, rotat):
	print(Line1.points.size())
	if(prev_rotat == rotat):
		Line1.remove_point(0)
	if(Line1.points.size() < 60 && prev_rotat != rotat):
		Line1.add_point(lpos)
		prev_rotat = rotat
	else:
		if(prev_rotat != rotat):
			prev_rotat = rotat
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
		
func slash():
	weapon_charged.emit()
	slashd = true
	Line1.set_gradient(load("res://red_grad.tres"))
func dslash():
	if(slashd == true):
		await get_tree().create_timer(.5).timeout
		slashd = false
		attack_active = false
	slashd = false
	attack_active = false
func no_attack_input():
	#attack_active = false
	Line1.remove_point(0)
	
func attack_input():
	attack_active = true
	
	

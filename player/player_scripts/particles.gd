extends Node2D
@onready var Line1: Line2D = $Line1
@onready var Line2: Line2D = $Line2
var slashd: bool = false
var attack_active = false
var prev_rotat
var slash_sfx_active = false
var swoosh_sfx_active = false
var player
signal weapon_charged

@onready var sword_audiostream = $sword_sfx
# Called when the node enters the scene tree for the first time.
func _ready():
	
	player = $"../Player/CharacterBody2D/Node2D"
	if(player):
		player.line1pos.connect(self.line1maker)
		player.line2pos.connect(self.line2maker)
		player.SLASH.connect(self.slash)
		player.done_slash.connect(self.dslash)
		player.attack_not_detected.connect(self.no_attack_input)
		player.attack_detected.connect(self.attack_input)
		player.slash_sfx_sig.connect(self.swoosh_sfx)
func reconnect():
	player = $"../Player/CharacterBody2D/Node2D"
	player.line1pos.connect(self.line1maker)
	player.line2pos.connect(self.line2maker)
	player.SLASH.connect(self.slash)
	player.done_slash.connect(self.dslash)
	player.attack_not_detected.connect(self.no_attack_input)
	player.attack_detected.connect(self.attack_input)
	player.slash_sfx_sig.connect(self.swoosh_sfx)
# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if(player != null):
		position = player.position
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
	slash_sfx()
	
	
	weapon_charged.emit()
	slashd = true
	Line1.set_gradient(load("res://red_grad.tres"))
func dslash(rotat_speed):
	
	#if(rotat_speed < 13):
		#minor_swoosh_sfx()
	#else:
	swoosh_sfx_active = false
	if(slashd == true):
		await get_tree().create_timer(.5).timeout
		slashd = false
		attack_active = false
	slashd = false
	attack_active = false
func no_attack_input():
	#attack_active = false
	Line1.remove_point(0)
	
func attack_input(rotat_speed):
	attack_active = true
	#swoosh_sfx_active = false
	
func slash_sfx():
	var rng = RandomNumberGenerator.new()
	if(slash_sfx_active == false):
		slash_sfx_active = true
		var SlashSfx: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		SlashSfx.set_stream(load("res://SFX/Sword/charged_sword/sword5_1.mp3")) 
		var pitch = rng.randf_range(1, 2.5)
		print("this is pitch: "+str(pitch))
		SlashSfx.set_pitch_scale(pitch)
		
		SlashSfx.set_volume_db(-10)
		self.add_child(SlashSfx)
		SlashSfx.play()
		await get_tree().create_timer(.5).timeout
		slash_sfx_active = false
		
var list_of_usable_sfx: Array
func import_filter(string_to_check: String):
	var rng = RandomNumberGenerator.new()
	#checks if file is an import file, if so, I HATE YOU, DIE!!!!11!!
	print("checking" + string_to_check)
	print("WHAT" + str(string_to_check.contains(".import")))
	if(!"import" in string_to_check):
		if(!list_of_usable_sfx.has(string_to_check)):
			list_of_usable_sfx.push_front(string_to_check)
	else:
		print("not cool" + string_to_check)
		var new_sfx = "sword"+str(rng.randi_range(1,3))+".mp3" 
		#print("really " + "sword"+str(rng.randi_range(1,4))+".mp3")
		if(!list_of_usable_sfx.has(new_sfx)):
			list_of_usable_sfx.push_front(new_sfx)

func swoosh_sfx():
	var rng = RandomNumberGenerator.new()
	if(swoosh_sfx_active == false && slash_sfx_active == false):
		swoosh_sfx_active = true
		
		
		var dir := DirAccess.open("res://SFX/Sword")
		var sfxs: PackedStringArray = dir.get_files()
		var FilteredArray: Array = Array(sfxs)
		for i in FilteredArray:
			import_filter(i)
		var sound_eff = list_of_usable_sfx.get(rng.randi_range(0, list_of_usable_sfx.size()-1))
		if(sound_eff != null):
			print(" cool " + sound_eff)
			sword_audiostream.set_stream(load("res://SFX/Sword/"+sound_eff)) 
		else:
			print("not cool")
		
		var pitch = rng.randf_range(1.5, 2.5)
		
		print("this is pitch: "+str(pitch))
		sword_audiostream.set_pitch_scale(pitch)
		sword_audiostream.play()
	
	
func minor_swoosh_sfx():
	var rng = RandomNumberGenerator.new()
	if(sword_audiostream.playing == true):
		pass
		#await sword_audiostream.finished
		#sword_audiostream.set_stream(load("res://SFX/Sword/quick_slash/quick1.mp3"))
		#var pitch = rng.randf_range(1, 2.5)
		#sword_audiostream.play()
	else:
		sword_audiostream.set_stream(load("res://SFX/Sword/quick_slash/quick1.mp3"))
		var pitch = rng.randf_range(1, 2.5)
		sword_audiostream.set_pitch_scale(pitch)
		sword_audiostream.play()

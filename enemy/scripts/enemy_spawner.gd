extends Node2D

@export var spawnPositions: Array[Node2D]


signal enemies_defeated
@onready var signalConnectEnemies: Array = get_tree().get_nodes_in_group("EnemyHandler")
@export var inf_debug_mode: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	self.enemies_defeated.connect(get_tree().current_scene._on_enemy_spawner_enemies_defeated)
	for i in signalConnectEnemies:
		i.enemyDeprecated.connect(self.enemySpawn)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func enemySpawn():
	
	if(inf_debug_mode):
		var newEnemy = load("res://enemy/enemy.tscn").instantiate()
		
		
		newEnemy.global_position = spawnPositions.pick_random().global_position
		newEnemy.enemyDeprecated.connect(self.enemySpawn)
		self.add_sibling(newEnemy)
	else:
		print("enemySpawnFunc")
		enemies_defeated.emit()
		
	
	

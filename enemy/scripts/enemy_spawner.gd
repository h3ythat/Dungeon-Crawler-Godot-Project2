extends Node2D

@export var spawnPositions: Array[Node2D]

@onready var signalConnectEnemies: Array = get_tree().get_nodes_in_group("EnemyHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in signalConnectEnemies:
		i.enemyDeprecated.connect(self.enemySpawn)
		
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func enemySpawn():
	var newEnemy = load("res://enemy/enemy.tscn").instantiate()
	
	
	newEnemy.global_position = spawnPositions.pick_random().global_position
	newEnemy.enemyDeprecated.connect(self.enemySpawn)
	self.add_sibling(newEnemy)
	
	
	

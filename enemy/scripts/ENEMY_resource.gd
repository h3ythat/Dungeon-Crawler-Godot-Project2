class_name EnemyType
extends Resource

enum EnemyClass { FOLLOW, DASH}


@export var health: float
@export var speed: float
@export var sprite_texture: Texture2D
@export var enemy_type: EnemyClass

func get_health():
	return health
func get_speed():
	return speed
func get_enemy_type():
	return enemy_type

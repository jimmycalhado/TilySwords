extends Node2D

@export var mobs_por_minuto: float = 60.0
@export var creature: Array[PackedScene]

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var cooldown: float = 0.0

func _process(delta:float):
	cooldown -= delta
	if cooldown > 0: 
		return
		
	var interval = 60.0 / mobs_por_minuto
	cooldown = interval
	
	var index = randi_range(0, creature.size() - 1)
	var creature_scene = creature[index]
	var creature = creature_scene.instantiate()
	creature.position = get_point()
	get_parent().add_child(creature)
	
func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.position

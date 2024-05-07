class_name GameOver
extends CanvasLayer

@onready var time_label: Label = %TSLabel
@onready var monster_label: Label = %MDLabel

@export var  restart_delay: float = 5.0
var restart_cooldown: float


func _ready():
	time_label.text = GameManage.time_elapsed_string
	monster_label.text = str(GameManage.monsters_defeated_counter)
	restart_cooldown = restart_delay
	
func _process(delta):
	restart_cooldown -= delta
	if restart_cooldown <= 0.0:
		restart_game()
		
func restart_game():
	GameManage.reset()
	get_tree().reload_current_scene()

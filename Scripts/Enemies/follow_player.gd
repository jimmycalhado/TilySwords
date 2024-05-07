extends Node

 
@export var speed: float = 1

var enemy: Enemy
var sprite: AnimatedSprite2D

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("Inimigo")
	

func _physics_process(delta: float) -> void:
	if GameManage.is_game_over: return
	
	var player_position = GameManage.player_position
	var difference = player_position - enemy.position
	var input_vector = difference.normalized()
	
	#MOVIMENTAÇÃO
	enemy.velocity = input_vector * speed * 100
	enemy.move_and_slide()
	
	# Girar sprite
	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true

class_name Enemy
extends Node2D

@export_category("Life")
@export var health: int = 10
@export var death_prefab : PackedScene
@export var damage_digital_prefab: PackedScene

@onready var damage_digital_mark = $DamageDigitMarker

@export_category("Drops")
@export var drop_chance: float = 0.2
@export var drop_items:Array[PackedScene]
@export var drop_chances: Array[float]

func _ready():
	pass

func damage(amount: int) -> void:
	health -= amount
	
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	var damage_digit = damage_digital_prefab.instantiate()
	damage_digit.value = amount
	if damage_digital_mark:
		damage_digit.global_position = damage_digital_mark.global_position
	else:
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
	
	if health <= 0:
		die()
		
func die() -> void:
	#animação caveira
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
	
	#drop
	if randf() <= drop_chance:
		_drop_item()
	
	GameManage.monsters_defeated_counter += 1
	
	queue_free()

func _drop_item() -> void :
	var drop = get_random_drop_item().instantiate()
	drop.position = position
	get_parent().add_child(drop)

func get_random_drop_item() -> PackedScene:
	if drop_items.size() == 1:
		return drop_items[0]
	
	var max_chance: float = 0.0
	for drop_chance in drop_chances:
		max_chance += drop_chance
		
	#joga o daddo
	var random_value = randf() * max_chance
	
	#girar a roleta
	var needle: float = 0.0
	for i in drop_items.size():
		var drop_item = drop_items[i]
		var drop_chance = drop_chances[i] if i < drop_chances.size() else 1
		if random_value <= drop_chance + needle:
			return drop_item
		needle += drop_chance
		
	return drop_items[0]

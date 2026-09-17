extends Node2D

@export var player: CharacterBody2D
@export var enemy: PackedScene
@export var destructible: PackedScene

var distance: float = 400
var can_spawn: bool = true
@export var max_match_seconds: int = 300
@export var base_enemy_cap: int = 90
@export var final_enemy_cap: int = 360

var elapsed_seconds: int = 0
var victory_reached: bool = false

@export var enemy_types : Array[Enemy]

var minute : int :
	set(value):
		minute = value
		%Minute.text = str(value)

var second : int :
	set(value):
		second = value
		%Second.text = str(value).lpad(2, '0')
		

func _physics_process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < get_enemy_cap():
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos: Vector2, elite: bool = false):
	if not can_spawn and not elite:
		return
	
	var enemy_instance = enemy.instantiate()
	
	enemy_instance.type = choose_enemy_type()
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	enemy_instance.elite = elite
	
	get_tree().current_scene.add_child(enemy_instance)
	

func get_random_position() -> Vector2 :
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number: int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout() -> void:
	if victory_reached:
		return
	elapsed_seconds += 1
	minute = floori(float(elapsed_seconds) / 60.0)
	second = elapsed_seconds % 60
	if elapsed_seconds >= max_match_seconds:
		victory()
		return
	amount(get_spawn_amount())


func _on_pattern_timeout() -> void:
	if victory_reached:
		return
	for i in range(get_pattern_amount()):
		spawn(get_random_position())


func _on_elite_timeout() -> void:
	if victory_reached or elapsed_seconds < 45:
		return
	spawn(get_random_position(), true)


func _on_desctructible_timeout() -> void:
	spawn_destructible(get_random_position())
	
func spawn_destructible(pos):
	var object_instance = destructible.instantiate()
	object_instance.position = pos
	get_tree().current_scene.add_child(object_instance)

func get_enemy_cap() -> int:
	var progress := float(elapsed_seconds) / float(max_match_seconds)
	return int(lerp(base_enemy_cap, final_enemy_cap, clamp(progress, 0.0, 1.0)))

func get_spawn_amount() -> int:
	if elapsed_seconds < 30:
		return 1
	if elapsed_seconds < 60:
		return 2
	if elapsed_seconds < 120:
		return 3
	if elapsed_seconds < 180:
		return 4
	if elapsed_seconds < 240:
		return 5
	if elapsed_seconds < 270:
		return 6
	return 8

func get_pattern_amount() -> int:
	if elapsed_seconds < 60:
		return 6
	if elapsed_seconds < 120:
		return 12
	if elapsed_seconds < 180:
		return 18
	if elapsed_seconds < 240:
		return 24
	return 32

func choose_enemy_type() -> Enemy:
	var index = min(minute, enemy_types.size() - 1)
	if elapsed_seconds >= 270:
		index = min(4, enemy_types.size() - 1)
	elif elapsed_seconds >= 210:
		index = min(3, enemy_types.size() - 1)
	elif elapsed_seconds >= 150:
		index = min(2, enemy_types.size() - 1)
	elif elapsed_seconds >= 75:
		index = min(1, enemy_types.size() - 1)
	else:
		index = 0
	return enemy_types[index]

func victory():
	victory_reached = true
	SaveData.gold += player.gold
	SaveData.set_and_save()
	var report = player.find_child("Report")
	if report:
		report.game_over = true
		report.show()
		report.find_child("Status").text = "Victory"
	get_tree().paused = true

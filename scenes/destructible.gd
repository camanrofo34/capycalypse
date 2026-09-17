extends Sprite2D

var frame_counter = 0
var separation: float

@export var normal_frames: int = 4
@export var destruction_frames: int = 6
@export var animation_speed: int = 6

var is_destroying := false

var health: float = 1:
	set(value):
		health = value
		
		if health <= 0 and not is_destroying:
			drop_item()

@onready var player_reference = get_tree().current_scene.find_child("Player")
var drop_node = preload("res://scenes/pickups.tscn")
@export var drops: Array[Pickups]


func _physics_process(delta: float) -> void:
	if not is_destroying:
		frame_counter += 1
		
		if frame_counter >= animation_speed:
			frame_counter = 0
			frame = (frame + 1) % normal_frames
	
	separation = (player_reference.position - position).length()
	
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self


func take_damage(amount = 1):
	health -= amount
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(3, 0.25, 0.25), 0.2)
	tween.chain().tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	
	tween.bind_node(self)


func drop_item():
	if destruction_frames > 0:
		play_destruction()
	else:
		spawn_drop()


func play_destruction():
	is_destroying = true
	
	var start_frame = normal_frames
	
	for i in range(destruction_frames):
		frame = start_frame + i
		await get_tree().create_timer(0.08).timeout
	
	spawn_drop()


func spawn_drop():
	var item
	var weights = []
	
	for pickup in drops:
		if pickup is Gold:
			weights.append(pickup.weight)
		else:
			weights.append(pickup.weight * player_reference.luck)
	
	var chance = randf()
	
	for i in range(drops.size()):
		if chance < get_weighted_chance(weights, i):
			item = drops[i]
			break
	
	var item_to_drop = drop_node.instantiate()
	
	item_to_drop.type = item
	item_to_drop.position = position
	item_to_drop.player_reference = player_reference
	
	get_tree().current_scene.call_deferred("add_child", item_to_drop)
	queue_free()


func get_weighted_chance(weight, index):
	var sum = 0
	
	for i in range(weight.size()):
		sum += weight[i]
	
	var cumulative = 0
	
	for i in range(index + 1):
		cumulative += weight[i]
	
	return float(cumulative) / sum

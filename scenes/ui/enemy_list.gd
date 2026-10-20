extends GridContainer

const PATH := "res://resources/Enemies/"

@export var enemy_slot: PackedScene

@onready var enemy_name: Label = %EnemyName
@onready var health_label: Label = %Health
@onready var damage_label: Label = %Damage
@onready var speed_label: Label = %Speed
@onready var gold_label: Label = %Gold
@onready var texture_rect: TextureRect = %Texture

var enemies: Array[Enemy] = []
var _base_y: float
var _bob_tween: Tween


func _ready() -> void:
	_base_y = texture_rect.position.y
	_load_enemies()
	if get_child_count() > 0:
		get_child(0).select()


func _load_enemies() -> void:
	var files: Array[String] = []
	for f in DirAccess.get_files_at(PATH):
		f = f.trim_suffix(".remap")
		if f.ends_with(".tres") and not files.has(f):
			files.append(f)
	files.sort()

	for f in files:
		var enemy := load(PATH + f) as Enemy
		if enemy == null:
			continue
		enemies.append(enemy)

		var slot = enemy_slot.instantiate()
		add_child(slot)
		slot.icon = enemy.texture
		slot.title = enemy.title
		slot.pressed.connect(_on_pressed.bind(enemy))


func _on_pressed(enemy: Enemy) -> void:
	enemy_name.text = enemy.title
	health_label.text = _fmt(enemy.health)
	damage_label.text = _fmt(enemy.damage)
	speed_label.text = _fmt(enemy.speed)
	gold_label.text = str(enemy.gold)
	texture_rect.texture = enemy.texture


func _fmt(value: float) -> String:
	if is_equal_approx(value, roundf(value)):
		return str(int(value))
	return str(snappedf(value, 0.1))

extends Area2D

var direction: Vector2
var speed: float = 175
var animation_timer: float = 0.0

@export var type: Pickups
@export var frame_count: int = 1
@export var animation_speed: float = 0.1
@export var player_reference: CharacterBody2D:
	set(value):
		player_reference = value
		if type:
			type.player_reference = value

var can_follow: bool = false

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = type.icon
	sprite.hframes = type.frame_count
	sprite.frame = 0

func _physics_process(delta: float) -> void:
	if type.frame_count > 1:
		animation_timer += delta
		if animation_timer >= type.animation_speed:
			animation_timer = 0.0
			sprite.frame = (sprite.frame + 1) % type.frame_count

	if player_reference and can_follow:
		direction = (player_reference.position - position).normalized()
		position += direction * speed * delta

func follow(_target: CharacterBody2D, gem_flag: bool = false) -> void:
	if type is Chest:
		return

	if gem_flag:
		if type is Gem:
			can_follow = true
		return

	can_follow = true

func _on_body_entered(_body: Node2D) -> void:
	type.activate()
	queue_free()

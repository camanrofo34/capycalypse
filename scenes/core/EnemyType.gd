extends Resource

class_name Enemy

@export var title: String
@export var texture: Texture2D
@export var health: float
@export var damage: float
@export var speed: float = 75.0
@export var gold: int = 0

@export var drops: Array[Pickups]

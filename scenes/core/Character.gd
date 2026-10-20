extends Resource
class_name Character

@export var title: String
@export var icon: Texture2D
@export var animation_name: String

@export var preview_sheet: Texture2D
@export var preview_frames: int = 4
@export var preview_scale: int = 0

@export_group("Walk sprites")
@export var walk_front: Texture2D
@export var walk_back: Texture2D
@export var walk_left: Texture2D
@export var walk_right: Texture2D
@export var walk_frames: int = 4
@export var walk_fps: float = 8.0
@export var sprite_scale: float = 1.0

@export_group("")
@export var base_stats: Stats
@export var starting_weapon: Weapon

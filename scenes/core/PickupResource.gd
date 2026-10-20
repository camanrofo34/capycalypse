extends Resource

class_name Pickups
@export var frame_count: int = 1
@export var animation_speed: float = 0.1
@export var title: String
@export var icon: Texture2D
@export_multiline var description: String
@export var sound : AudioStream
@export var weight : float

var player_reference : CharacterBody2D


func activate():
	if sound != null:
		SoundManager.play_sfx(sound)
	print(title + " picked up.")

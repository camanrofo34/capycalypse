extends GridContainer

@export var character_slot : PackedScene
@onready var starting_weapon = %StartingWeapon
@onready var char_name = %CharName
@onready var char_desc = %CharDesc
@onready var preview = %PreviewSprite

@export var characters : Array[Character]

func _ready():
	load_characters()
	if get_child_count() > 0:
		get_child(0).select()

func load_characters():
	for character in characters:
		var slot = character_slot.instantiate()
		add_child(slot)
		slot.icon = character.icon
		slot.title = character.title
		slot.pressed.connect(_on_pressed.bind(character))

func _on_pressed(character : Character):
	Persistence.character = character
	starting_weapon.texture = character.starting_weapon.icon
	char_name.text = character.title
	char_desc.text = character.base_stats.description if character.base_stats else ""
	if character.preview_sheet:
		preview.texture = character.preview_sheet
		preview.hframes = character.preview_frames
		preview.frame = 0
		var s: float = max(1.0, floor(140.0 / character.preview_sheet.get_height()))
		if character.preview_scale > 0:
			s = float(character.preview_scale)
		preview.scale = Vector2(s, s)

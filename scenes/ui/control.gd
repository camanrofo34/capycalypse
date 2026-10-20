
extends Control

func _ready():
	menu()
	_setup_buttons()

func _on_upgrades_pressed() -> void:
	skill_tree()

func _on_bestiary_pressed() -> void:
	beastiary()

func menu():
	$Menu.show()
	$SkillTree.hide()
	$Beastiary.hide()
	$CharacterSelection.hide()
	$Gold.hide()
	$Back.hide()
	$Dim.hide()

func skill_tree():
	$SkillTree.show()
	$Gold.show()
	$Menu.hide()
	$CharacterSelection.hide()
	$Back.show()
	$Dim.show()

func beastiary():
	$Beastiary.show()
	$Menu.hide()
	$Gold.hide()
	$CharacterSelection.hide()
	$Back.show()
	$Dim.show()

func _on_back_pressed() -> void:
	menu()

func tween_pop(panel):
	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.5)

func _on_start_pressed() -> void:
	$CharacterSelection.show()
	$Menu.hide()
	$Gold.hide()
	$Back.show()
	$Dim.show()

func _setup_buttons() -> void:
	var buttons: Array[TextureButton] = [
		$Menu/Start,
		$Menu/Beastiary,
		$Menu/Upgrades,
		$CharacterSelection/Start,
		$Back,
	]

	for b in buttons:
		b.pivot_offset = b.size / 2.0
		b.resized.connect(func(): b.pivot_offset = b.size / 2.0)

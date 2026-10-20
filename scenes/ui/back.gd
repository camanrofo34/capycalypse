extends Button

func _on_pressed() -> void:
	get_tree().paused = false
	Persistence.character = null
	SaveData.gold += owner.gold
	SaveData.set_and_save()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

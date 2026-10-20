extends Label

func _process(delta: float) -> void:
	text = "Gold: " + str(SaveData.gold)

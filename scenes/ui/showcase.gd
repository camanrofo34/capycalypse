extends Control

func _ready() -> void:
	var tree: Control = get_node("../SkillTree")
	visible = tree.visible
	tree.visibility_changed.connect(func(): visible = tree.visible)

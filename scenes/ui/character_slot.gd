extends Control

var icon = null:
	set(value):
		icon = value
		$TextureButton.texture_normal = value

var title: String = "":
	set(value):
		title = value
		$NameLabel.text = value

signal pressed


func _ready():
	$Select.hide()
	$TextureButton.mouse_entered.connect(func(): $Frame.modulate = Color(1.35, 1.15, 1.4))
	$TextureButton.mouse_exited.connect(func(): $Frame.modulate = Color.WHITE)


func _on_texture_button_pressed():
	for slot in get_parent().get_children():
		slot.deselect()
	$Select.show()
	pressed.emit()


func select():
	_on_texture_button_pressed()


func deselect():
	$Select.hide()

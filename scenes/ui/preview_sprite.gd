extends Sprite2D
# Anima la hoja de frames (hframes) de la vista previa del personaje.

@export var fps: float = 5.0
var _t: float = 0.0


func _process(delta: float) -> void:
	if hframes <= 1:
		return
	_t += delta
	frame = int(_t * fps) % hframes

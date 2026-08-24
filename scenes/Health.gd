extends Pickups
class_name Health

@export var amount : int = 20

func active():
	super.activate()
	player_reference.health += amount

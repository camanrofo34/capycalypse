extends Weapon
class_name DamagingArea

@export var angular_speed: float = 10
@export var area : float = 1

var angle : float
var projectile_reference

func activate(source, _target, _scene_tree):
	SoundManager.play_sfx(sound)
	reset_collision()
	pulsate(_scene_tree)
	
	if not projectile_reference:
		add_to_player(source)

func update(delta): 
	angle += angular_speed * delta
	if is_instance_valid(projectile_reference):
		projectile_reference.rotation_degrees = angle
		projectile_reference.damage = damage

func reset():
	if is_instance_valid(projectile_reference):
		projectile_reference.queue_free()

func add_to_player(source):
	var projectile = projectile_node.instantiate()

	projectile.speed = 0
	projectile.damage = damage
	projectile.source = source
	projectile.z_index = 0
	projectile.knockback = -40
	projectile.weapon = self

	var sprite: Sprite2D = projectile.find_child("Sprite2D")
	var collision: CollisionShape2D = projectile.find_child("CollisionShape2D")

	sprite.texture = texture

	# Base collision radius
	var radius := 90.0

	# Apply your weapon's area multiplier
	radius *= area

	# Collision
	var circle := collision.shape as CircleShape2D
	circle.radius = radius

	# Sprite must have a diameter equal to the collision diameter
	var diameter := radius * 2.0
	var texture_size := sprite.texture.get_size()

	sprite.scale = Vector2.ONE * (diameter / texture_size.x)

	# Do NOT scale the Area2D
	projectile.scale = Vector2.ONE

	projectile_reference = projectile

	source.call_deferred("add_child", projectile)

func reset_collision():
	if projectile_reference:
		projectile_reference.find_child("CollisionShape2D").disabled = true
		projectile_reference.find_child("CollisionShape2D").disabled = false

func pulsate(tree):
	if is_instance_valid(projectile_reference):
		var tween = tree.create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(projectile_reference, "scale", Vector2(area + 0.1, area + 0.1), 0.25)
		tween.chain().tween_property(projectile_reference, "scale", Vector2(area, area), 0.25)
		tween.bind_node(projectile_reference)

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	
	area += upgrade.area
	cooldown += upgrade.cooldown
	damage += upgrade.damage
	
	level += 1

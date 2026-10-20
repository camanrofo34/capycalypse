extends Weapon
class_name MultiDamagingArea

@export var amount : int = 1
@export var area : float = 50

@export var delay : float = 0.2
var counter : float = 0

var projectile_reference = []

func activate(source, _target, scene_tree):
	reset()
	SoundManager.play_sfx(sound)
	for i in range(amount):
		add_to_world(source, scene_tree)
	
	for i in range(projectile_reference.size()):
		var offset = i * (360.0/amount)
		projectile_reference[i].position = source.position + 100 * Vector2(cos(deg_to_rad(offset)), sin(deg_to_rad(offset)))
		projectile_reference[i].show()

func add_to_world(source, tree):
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

	# area = radius of the attack
	var radius = area
	var diameter = radius * 2.0

	# Make the texture's diameter equal to the collision diameter
	var texture_size = sprite.texture.get_size()
	var scale_factor = diameter / texture_size.x

	sprite.scale = Vector2.ONE * scale_factor

	# Make the collision have the same radius
	var circle = collision.shape as CircleShape2D
	circle.radius = radius

	projectile.hide()
	projectile_reference.append(projectile)

	tree.current_scene.call_deferred("add_child", projectile)

func reset():
	for i in range(projectile_reference.size()):
		var temp = projectile_reference.pop_front()
		if is_instance_valid(temp):
			temp.queue_free()

func reset_collision(value):
	for projectile in projectile_reference:
		if is_instance_valid(projectile):
			projectile.find_child("CollisionShape2D").disabled = value

func update(delta):
	counter += delta
	
	if counter > 2 * delay and projectile_reference.size() > 0:
		reset_collision(false)
		counter = 0
	elif counter > delay and projectile_reference.size() > 0:
		reset_collision(true)

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	
	area += upgrade.area
	damage += upgrade.damage
	amount += upgrade.amount
	
	level += 1

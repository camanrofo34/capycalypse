extends CharacterBody2D

@export var character: Character

var health: float = 100:
	set(value):
		health = clamp(value, 0, max_health)
		%Health.value = health
		if health <= 0:
			SaveData.gold += gold
			SaveData.set_and_save()
			var report = find_child("Report")
			if report:
				report.game_over = true
				report.show()
				report.find_child("Status").text = "Defeat"
			get_tree().paused = true

var movement_speed: float = 150

var max_health: float = 100:
	set(value):
		max_health = value
		%Health.max_value = value

var recovery: float = 0:
	set(value):
		recovery = value
		%Recovery.text = "R : " + str(value)
var armor: float = 0:
	set(value):
		armor = value
		%Armor.text = "A : " + str(value)
var might: float = 1.0:
	set(value):
		might = value
		%Might.text = "M : " + str(value)
var area: float = 100

var magnet: float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 50 + value

var growth: float = 1

var luck: float = 1.0

var nearest_enemy
var nearest_enemy_distance: float = 150 + area


var gold: int = 0:
	set(value):
		gold = value
		%Gold.text = str(value)


var XP: int = 0:
	set(value):
		XP = value
		%XP.value = value

var total_XP: int = 0


var level: int = 1:
	set(value):
		level = value
		%Level.text = "Lv " + str(value)
		%Options.show_option()

		if level >= 7:
			%XP.max_value = 40
		elif level >= 3:
			%XP.max_value = 20

func _ready() -> void:
	Persistence.gain_bonus_stats(self)
	if Persistence.character != null:
		character = Persistence.character
	if character == null:
		# Por si se ejecuta test_scene directamente sin pasar por el menu
		character = load("res://resources/Characters/miku.tres")
	setup_sprites()
	set_base_stats(character.base_stats)
	%Options.check_item(character.starting_weapon)

# Dirección que está mirando el personaje
var last_direction: String = "front"


func _physics_process(delta: float) -> void:

	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null

	# Obtener movimiento
	velocity = Input.get_vector("left", "right", "up", "down") * movement_speed

	move_and_collide(velocity * delta)
	update_animation()
	check_XP()

	health += recovery * delta


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var portrait: AnimatedSprite2D = %PortraitSprite


# wawa
func setup_sprites() -> void:
	var frames := build_walk_frames(character)
	if frames == null:
		return

	sprite.sprite_frames = frames
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.scale = Vector2.ONE * character.sprite_scale
	sprite.visible = true
	update_animation()

	# El retrato del HUD es estatico: se queda en el primer frame de frente
	var frame_size: Vector2 = frames.get_frame_texture("walk_front", 0).get_size()
	portrait.sprite_frames = frames
	portrait.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	portrait.scale = Vector2.ONE * maxf(1.0, snappedf(64.0 / maxf(frame_size.x, frame_size.y), 0.5))
	portrait.animation = "walk_front"
	portrait.stop()
	portrait.frame = 0


func build_walk_frames(c: Character) -> SpriteFrames:
	if c == null or c.walk_front == null:
		return null

	var sheets := {
		"front": c.walk_front,
		"back": c.walk_back if c.walk_back else c.walk_front,
		"left": c.walk_left if c.walk_left else c.walk_front,
		"right": c.walk_right if c.walk_right else c.walk_front,
	}

	var frames := SpriteFrames.new()
	frames.remove_animation("default")
	var count: int = maxi(c.walk_frames, 1)

	for dir in sheets:
		var sheet: Texture2D = sheets[dir]
		var anim_name: String = "walk_" + dir
		var frame_w: int = ceili(sheet.get_width() / float(count))
		frames.add_animation(anim_name)
		frames.set_animation_speed(anim_name, c.walk_fps)
		frames.set_animation_loop(anim_name, true)
		for i in count:
			var atlas := AtlasTexture.new()
			atlas.atlas = sheet
			var x: int = i * frame_w
			atlas.region = Rect2(x, 0, mini(frame_w, sheet.get_width() - x), sheet.get_height())
			frames.add_frame(anim_name, atlas)

	return frames


func update_animation() -> void:
	if sprite == null or sprite.sprite_frames == null:
		return

	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			last_direction = "right"
		elif velocity.x < 0:
			last_direction = "left"
		elif velocity.y > 0:
			last_direction = "front"
		else:
			last_direction = "back"
		sprite.play("walk_" + last_direction)
	else:
		# Quieto: se queda en el primer frame mirando hacia donde iba
		sprite.animation = "walk_" + last_direction
		sprite.stop()
		sprite.frame = 0


func take_damage(amount):
	health -= max(amount * (amount/(amount + armor)), 1)


func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)


func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth


func check_XP():
	if XP >= %XP.max_value:
		XP -= %XP.max_value
		level += 1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)


func gain_gold(amount):
	gold += amount


func open_chest():
	$UI/Chest.open()

func set_base_stats(base_stats: Stats):
	max_health += base_stats.max_health
	health = max_health
	recovery += base_stats.recovery
	armor += base_stats.armor
	movement_speed += base_stats.movement_speed
	might += base_stats.might
	area += base_stats.area
	magnet += base_stats.magnet
	growth += base_stats.growth
	luck += base_stats.luck

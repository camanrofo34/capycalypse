extends CharacterBody2D


var health: float = 100:
	set(value):
		health = max(value, 0)
		%Health.value = value

var movement_speed: float = 150

var max_health: float = 100:
	set(value):
		max_health = value
		%Health.max_value = value

var recovery: float = 0
var armor: float = 0
var might: float = 1.5
var area: float = 100

var magnet: float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 50 + value

var growth: float = 1


var nearest_enemy: CharacterBody2D
var nearest_enemy_distance: float = 150 + area


var gold: int = 0:
	set(value):
		gold = value
		%Gold.text = "Gold : " + str(value)


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

	# Actualizar animación
	update_animation()

	move_and_collide(velocity * delta)

	check_XP()

	health += recovery * delta


func update_animation() -> void:

	# DERECHA
	if velocity.x > 0:
		last_direction = "right"
		$AnimatedSprite2D.play("walk_right")

	# IZQUIERDA
	elif velocity.x < 0:
		last_direction = "left"
		$AnimatedSprite2D.play("walk_left")

	# ABAJO / FRENTE
	elif velocity.y > 0:
		last_direction = "front"
		$AnimatedSprite2D.play("walk_front")

	# ARRIBA / ATRÁS
	elif velocity.y < 0:
		last_direction = "back"
		$AnimatedSprite2D.play("walk_back")

	# NO SE ESTÁ MOVIENDO
	else:
		play_idle()


func play_idle() -> void:

	match last_direction:

		"right":
			$AnimatedSprite2D.play("idle_right")

		"left":
			$AnimatedSprite2D.play("idle_left")

		"front":
			$AnimatedSprite2D.play("idle_front")

		"back":
			$AnimatedSprite2D.play("idle_back")


func take_damage(amount):
	health -= max(amount - armor, 0)


func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)


func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth


func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)


func gain_gold(amount):
	gold += amount


func open_chest():
	$UI/Chest.open()

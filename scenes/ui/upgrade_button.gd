extends TextureButton

@export var skill: Skill

const COLOR_OK := Color(1, 1, 1, 1)
const COLOR_POOR := Color(1, 0.45, 0.5, 1)
const COLOR_OWNED := Color(1, 0.55, 0.85, 1)
const COLOR_LOCKED := Color(0.6, 0.45, 0.7, 1)
const ICON_LOCKED := Color(0.35, 0.28, 0.42, 1)

const STAT_FIELDS := {
	"max_health": false,
	"recovery": false,
	"armor": false,
	"movement_speed": true,
	"might": true,
	"area": true,
	"magnet": true,
	"growth": true,
	"luck": true,
}

@onready var icon: TextureRect = $Icon
@onready var select: NinePatchRect = $Select
@onready var coin: TextureRect = $Price/Coin
@onready var cost_label: Label = $Price/Cost
@onready var bonus_label: Label = $Bonus

var enabled : bool = false:
	set(value):
		enabled = value
		if is_node_ready():
			_refresh()

var _hover := false
var _last_key := ""


func _ready():
	if skill:
		icon.texture = skill.texture
		bonus_label.text = _bonus_text()
	mouse_entered.connect(_on_hover.bind(true))
	mouse_exited.connect(_on_hover.bind(false))
	_refresh()


func _process(_delta: float) -> void:
	if is_visible_in_tree():
		_refresh()


func _on_hover(value: bool) -> void:
	_hover = value
	_refresh()


func _refresh() -> void:
	if skill == null:
		return

	var upgradable := is_upgradable()
	var affordable: bool = skill.cost <= SaveData.gold
	var key := "%s|%s|%s|%s" % [enabled, upgradable, affordable, _hover]
	if key == _last_key:
		return
	_last_key = key

	select.visible = enabled or (_hover and upgradable)

	if enabled:
		icon.modulate = Color.WHITE
		coin.hide()
		cost_label.text = "COMPRADO"
		cost_label.add_theme_color_override("font_color", COLOR_OWNED)
	else:
		coin.show()
		cost_label.text = str(skill.cost)
		if not upgradable:
			icon.modulate = ICON_LOCKED
			cost_label.add_theme_color_override("font_color", COLOR_LOCKED)
		else:
			icon.modulate = Color.WHITE
			cost_label.add_theme_color_override("font_color", COLOR_OK if affordable else COLOR_POOR)


func _bonus_text() -> String:
	if skill == null or skill.stats == null:
		return ""
	for field in STAT_FIELDS:
		var value: float = skill.stats.get(field)
		if value != 0.0:
			if STAT_FIELDS[field]:
				return "+%d%%" % roundi(value * 100.0)
			return "+" + _fmt(value)
	return ""


func _fmt(value: float) -> String:
	if is_equal_approx(value, roundf(value)):
		return str(int(value))
	return str(snappedf(value, 0.01))


func _pop() -> void:
	icon.pivot_offset = icon.size / 2.0
	icon.scale = Vector2(0.6, 0.6)
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(icon, "scale", Vector2.ONE, 0.5)


func is_upgradable() -> bool:
	if get_index() == 0:
		return true
	elif get_index() > 0:
		if get_parent().get_child(get_index()-1).enabled == true:
			return true
		else:
			return false

	return false


func _on_pressed() -> void:
	if skill.cost <= SaveData.gold and is_upgradable() and not enabled:
		SaveData.gold -= skill.cost
		enabled = true
		_pop()
		get_parent().get_parent().set_skill_tree()
		get_parent().get_parent().get_total_stats()

extends RigidBody2D

const VITEZA_JOS = 250.0
const FORTA_MIN = 700.0
const MULTIPLICATOR = 1.5

var aruncat = false

func _ready():
	add_to_group("bloc")
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_cand_ma_lovesc)

func _physics_process(_delta):
	if not aruncat:
		linear_velocity.y = VITEZA_JOS
	if global_position.y > 1500 or global_position.y < -800 \
	or global_position.x < -400 or global_position.x > 2600:
		queue_free()

func _cand_ma_lovesc(corp):
	if not corp.is_in_group("scut"):
		return
	aruncat = true

	var v = corp.viteza_scut
	var dir_dinspre_scut = (global_position - corp.global_position).normalized()

	if v.length() > 50.0:
		linear_velocity = v * MULTIPLICATOR
	else:
		linear_velocity = dir_dinspre_scut * FORTA_MIN

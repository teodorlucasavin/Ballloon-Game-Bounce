extends AnimatableBody2D

const VITEZA = 500.0

var viteza_scut = Vector2.ZERO

func _ready():
	add_to_group("scut")

func _physics_process(delta):
	var directie = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var miscare = directie * VITEZA * delta
	position += miscare
	viteza_scut = miscare / delta

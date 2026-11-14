extends Node2D

const VITEZA = 100.0

var fundaluri = []
var inaltimi = []
var inaltime_totala = 0.0

func _ready():
	for copil in get_children():
		fundaluri.append(copil)
		var h = copil.texture.get_height() * copil.scale.y
		inaltimi.append(h)
		inaltime_totala += h

	var y = 0.0
	for i in range(fundaluri.size()):
		y -= inaltimi[i]
		fundaluri[i].position = Vector2(0, y + inaltimi[0])

func _process(delta):
	var ecran_jos = get_viewport_rect().size.y

	for i in range(fundaluri.size()):
		var f = fundaluri[i]
		f.position.y += VITEZA * delta

		if f.position.y >= ecran_jos:
			f.position.y -= inaltime_totala

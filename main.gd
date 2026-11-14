extends Node2D

const VITEZA_FUNDAL = 100.0

var bloc_scena = preload("res://bloc.tscn")
var fundaluri = []
var inaltime_totala = 0.0
var joc_terminat = false
var scor = 0
var timp_scor = 0.0

var stanga = 0.0
var dreapta = 440.0
var latime_zona = 520.0
var marime = 70.0 
var margine = 60.0

func _ready():
	var centru = get_viewport_rect().size.x / 2.0
	dreapta = centru + 437.0 / 2.0
	stanga = dreapta - latime_zona

	$TimerSpawn.timeout.connect(_spawn_bloc)
	$balon.explodat.connect(_game_over)

	var inaltimi = []
	for f in $fundal.get_children():
		fundaluri.append(f)
		var h = f.texture.get_height() * f.scale.y
		inaltimi.append(h)
		inaltime_totala += h

	var y = 0.0
	for i in range(fundaluri.size()):
		fundaluri[i].position = Vector2(0, y)
		y -= inaltimi[i]

func _process(delta):
	if joc_terminat:
		return
	var ecran_jos = get_viewport_rect().size.y
	for f in fundaluri:
		f.position.y += VITEZA_FUNDAL * delta
		if f.position.y >= ecran_jos:
			f.position.y -= inaltime_totala

	timp_scor += delta
	if timp_scor >= 1.0:
		timp_scor -= 1.0
		scor += 1
		$UI/ScorLabel.text = str(scor)

func _spawn_bloc():
	if joc_terminat:
		return
	var x = randf_range(stanga + margine, dreapta - margine)
	var start = Vector2(x, -100)

	match randi() % 5:
		0: _pune_bloc(start)
		1: _piramida(start)
		2: _perete_cu_gaura()
		3: _una_dupa_alta()
		4: _zigzag(start)

func _pune_bloc(poz):
	poz.x = clamp(poz.x, stanga + marime / 2.0, dreapta - marime / 2.0)
	var bloc = bloc_scena.instantiate()
	bloc.position = poz
	add_child(bloc)

func _piramida(start):
	for rand in range(3):
		for i in range(rand + 1):
			var offset_x = (i - rand / 2.0) * marime
			_pune_bloc(start + Vector2(offset_x, -rand * marime))

func _perete_cu_gaura():
	var nr = int((dreapta - stanga) / marime)
	var gaura = randi() % nr
	for i in range(nr):
		if abs(i - gaura) > 1:
			_pune_bloc(Vector2(stanga + i * marime + marime / 2.0, -100))

func _una_dupa_alta():
	for i in range(5):
		if joc_terminat:
			return
		_pune_bloc(Vector2(randf_range(stanga + margine, dreapta - margine), -100))
		await get_tree().create_timer(0.6).timeout

func _zigzag(start):
	for i in range(5):
		var offset_x = (i % 2) * 2 * marime - marime
		_pune_bloc(start + Vector2(offset_x, -i * marime * 1.5))

func _game_over():
	if joc_terminat:
		return
	joc_terminat = true
	$TimerSpawn.stop()
	Global.scor = scor
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://ending.tscn")

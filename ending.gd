extends Control

func _ready():
	print("Ending pornit")
	$ScorLabel.text = "Scor: " + str(Global.scor)
	$PlayButton.pressed.connect(_joaca)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("Enter apasat")
		_joaca()

func _joaca():
	print("Pornesc jocul")
	get_tree().change_scene_to_file("res://node_2d.tscn")

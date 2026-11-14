extends Area2D

signal explodat

var mort = false

func _ready():
	body_entered.connect(_cand_intra_ceva)

func _cand_intra_ceva(corp):
	if mort:
		return
	if corp.is_in_group("bloc"):
		mort = true
		$Sprite2D.visible = false
		explodat.emit()

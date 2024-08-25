extends Node2D

var Box = ["red", "green", "blue"]

func _ready():
	print("1 ",Box)
	ArrayBox()

func ArrayBox():
	var TempBox = []
	for i in range(Box.size()):
		TempBox.append(Box[randi() % Box.size()])
	Box = TempBox
	print("2 ",Box)
	$Label.text = str(Box)
	

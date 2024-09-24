extends Control

# Declare the search term variable
var search_text: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the text_changed signal of the LineEdit node to the search function
	$LineEdit.connect("text_changed", _on_search_text_changed)
	# Initial search to update the display based on initial text (if any)
	_update_search()
	img()

# Function to handle the text_changed signal
func _on_search_text_changed(new_text: String):
	print("Changed ")
	search_text = new_text
	_update_search()

# Function to update the visibility of the children based on the search text
func _update_search():
	# Iterate over all children of the VBoxContainer
	for child in $VBoxContainer.get_children():
		if search_text in child.name:
			child.show()
		else:
			child.hide()
			
			
			
			


func  img():
	
	
	#$AnimatedSprite2D.sprite_frames = GifManager.sprite_frames_from_file("res://Images/Searcg.gif",41,30.00)
	
	$AnimatedSprite2D.play("Search")
	$AnimatedSprite2D2.play("Search")
	
	pass

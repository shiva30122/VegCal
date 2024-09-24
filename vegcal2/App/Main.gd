extends Control

class_name Main

var Cal = preload("res://App/Cal.tscn")


var database = SQLite.new()
var Fdatabase = SQLite.new()




var DB_PATH : String = "user://data.db"
var FDB_PATH : String = "user://Fdata.db"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Load.play("Load")
	$Search.connect("text_changed", _on_Search_Text_Changed)
	$Back2.connect("pressed",Back)
	$Setting_List/Edit.connect("pressed",Back)
	
	if ! FileAccess.file_exists(DB_PATH) and ! FileAccess.file_exists(FDB_PATH): 
		
		return

	database.path = DB_PATH
	database.open_db()
	Fdatabase.path = FDB_PATH
	Fdatabase.open_db()
	DataBaseLoad()
	AutoLoad()
	


func DataBaseLoad():
	
	#print(database.select_rows("Vegetable","Name ==Name",["Name","Rate"]))
	
	if %HBC.get_child_count() > 0:
		for child in %HBC.get_children():
			%HBC.remove_child(child)
			child.queue_free()  # Free the child from memory if no longer needed

	
	var data = database.select_rows("Vegetable","Name ==Name",["Name","Rate"])
	var Fdata = Fdatabase.select_rows("Vegetable","Name ==Name",["Name","Rate"])

	for i in Fdata:
		var Name = i.Name 
		var Rate = i.Rate
		var Ins = preload("res://App/Cal.tscn").instantiate()

		%HBC.add_child(Ins)
		Ins.Name = str(Name)
		Ins.Rate = str(Rate)
		
		print(Ins.Name, Ins.Rate,Name)
		print(i.Name,i.Rate)
	
	for i in data:
		var Name = i.Name 
		var Rate = i.Rate
		var Ins = preload("res://App/Cal.tscn").instantiate()

		%HBC.add_child(Ins)
		Ins.Name = str(Name)
		Ins.Rate = str(Rate)
		
		Ins.name = str(Name)
		
		print(Ins.Name, Ins.Rate,Name)
		print(i.Name,i.Rate)
		

		
	
	pass
	

func Setting():
	
	$Box.hide()
	$Back.show()
	$Setting.hide()
	$Setting_List.show()
	$FullScreen.hide()
	$Search.hide()
	$FullScreen2.hide()
	
	$TotalButton.hide()
	pass

func Back():
	
	$Box.show()
	$Setting.show()
	$Back.hide()
	$Setting_List.hide()
	$FullScreen.show()
	$Search.show()
	$FullScreen2.show()
	
	pass


func  AutoLoad():
	
	NoOfDataBase()
	
	pass


func NoOfDataBase():
	
	var intbase = database.select_rows("Vegetable","Name == Name",["*"]).size()
	var floatbase = Fdatabase.select_rows("Vegetable","Name == Name",["*"]).size()
	
	Global.TotalData  = intbase + floatbase
	print(Global.TotalData)
	
	#print(" TotalNoOfDataBase ",intbase,floatbase)
	
	pass


"                   SEARCH                                 "


var Search_Text: String = ""
var Matches = []
@onready var items = %HBC.get_children()
# Function to handle the text_changed signal
func _on_Search_Text_Changed(New_Text: String):
	#items = %HBC.get_children()
	print(items,Matches)
	New_Text = New_Text.to_lower()
	
	if New_Text == "":
		for child in %HBC.get_children():
			child.show()
			$Notify.text = " NEW SEARCH !..  "
			$Out2.start()
			
		return
		Matches.clear()
	Matches.clear()
	for child in %HBC.get_children():
		
		
		if New_Text in child.name.to_lower():
			Matches.append(child.name)
	for child in %HBC.get_children():
		
		if child.name in Matches:
			print(child.name)
			child.show()
			if Matches.size() >0:
				
				$Notify.text = "  HAHH Found !..  "
				$Out3.start()
			
		else :
			if Matches.size() <=0:
				
				$Notify.text = "   NOT Found ! MMM..  "
				$Out3.start()
			child.hide()
			
			
		if child.KG.to_float() > 0 :
			child.show()
			

	
	pass




func ScrenSize():
	
# Get the screen size of the current device
	var screen_size = DisplayServer.window_get_size()
	print("Original Screen size:", screen_size)
	
	# Calculate the aspect ratio of the current screen
	var aspect_ratio = screen_size.x / screen_size.y
	
	# Target resolution (can be adjusted as needed)
	var target_width = 1280
	var target_height = 720
	var target_aspect_ratio = target_width / target_height
	
	# Adjust width and height to fit the screen size while maintaining the aspect ratio
	var new_width = screen_size.x
	var new_height = screen_size.y

	if aspect_ratio > target_aspect_ratio:
		new_height = new_width / target_aspect_ratio 
	else:
		new_width = new_height * target_aspect_ratio 

	DisplayServer.window_set_size(Vector2i(screen_size.x, screen_size.y))
	print("Adjusted Screen size:", DisplayServer.window_get_size())
	
	# Set the stretch mode and aspect ratio to fit the screen size
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#ProjectSettings.set_setting("display/window/stretch/mode", "2d")
	#ProjectSettings.set_setting("display/window/stretch/aspect", "keep")
	$Notify.text = "  Display Size   " +str(screen_size,"  ", new_height,"  ",new_width,"  ",)


func Setting_pressed() -> void:
	
	$Notify.text = "  SETTING !...  "
	$Out.start()
	
	Setting()
	
	pass # Replace with function body.


func Back_Pressed() -> void:
	
	$Notify.text = "  MAIN MENU !...  "
	$Out.start()
	Back()
	
	pass # Replace with function body.


func Screen_Size_Pressed() -> void:
	
	ScrenSize()
	
	pass # Replace with function body.

@export var DataBase : PackedScene

func Bata_Base_Pressed() -> void:
	
	get_tree().change_scene_to_file("res://App/Data_Base.tscn")
	
	pass # Replace with function body.


func _on_out_timeout() -> void:
	
	$Notify.text = ""
	
	pass # Replace with function body.


func _on_out_2_timeout() -> void:
	
	$Notify.text = ""
	
	pass # Replace with function body.

var Total : float

func _on_total_pressed() -> void:
	
	Total = 0
	if %HBC.get_children().is_empty(): return
	
	for child in %HBC.get_children():
		
		
		Total = (float(child.Amount) + Total)
	
	
	
	$Notify.text = "  TOTAL AMOUNT ADDED !... " #+ str(String("%.2f" % Total))
	$Out2.start()
	$TotalButton/Amount.text = "  TOTAL AMOUNT = " + str(String("%.2f" % Total))

	pass
	
	pass # Replace with function body.


func _on_refresh_pressed() -> void:
	
	
	DataBaseLoad()
	$Out.start()
	
	$Notify.text = "  Refreshing . "
	await get_tree().create_timer(0.3).timeout
	$Notify.text = "  Refreshing .. "
	await get_tree().create_timer(0.3).timeout
	$Notify.text = "  Refreshing ... "
	

	pass # Replace with function body.


func _on_about_pressed() -> void:
	
	$Setting_List/ABOUT.text = "SHARMI >_DEV "
	
	pass # Replace with function body.


func _on_load_animation_finished() -> void:
	
	
	$ColorRect2.hide()
	$Load.hide()
	
	pass # Replace with function body.


func _on_cloud_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Google.tscn")
	
	pass # Replace with function body.

extends Node

# File paths
var config_file_path = "user://Data.cfg"

func _ready():
	# Ensure the DataBase File exists
	if not FileAccess.file_exists(config_file_path):
		var file = FileAccess.open(config_file_path, FileAccess.WRITE)
		file.store_line("[Data]")
		file.close()
		$Notify.text = " FILE ACCESED !..."
		$Timer.start()

# Function to add data
func add_data(Name: String, Rate: String) -> void:
	var config = ConfigFile.new()
	
	# Load existing config
	var err = config.load(config_file_path)
	if err != OK:
		print("Error loading DataBase File: %s" % err)
		return
	
	# Check if the Name already exists
	if config.has_section_key("Data", Name):
		print("Name ' %s ' already exists in the DataBase File !..." % Name)
		
		$Nagivator.text = str("Name  ' %s ' already exists in the DataBase File !..." % Name )
		$Timer.stop()
		$Timer.start()
		
	else:
		# Add new entry
		config.set_value("Data", Name, Rate)
		config.save(config_file_path)
		print("Name ' %s ' with Rate ' %s ' added to the DataBase File !..." % [ Name , Rate ])
		
		$Nagivator.text = str("Name ' %s ' with Rate ' %s ' added to the DataBase File !..." % [ Name , Rate ])
		
		$Timer.stop()
		$Timer.start()

# Function to check if a Name exists
func Name_exists(Name: String) -> bool:
	var config = ConfigFile.new()
	var err = config.load(config_file_path)
	if err != OK:
		print("Error loading DataBase File: %s" % err)
		return false
	return config.has_section_key("Data", Name) 
	



func _on_add_data_pressed() -> void:
	if $Name.text == "" or $Name.text == null:
		$Nagivator.text = "  Enter A Valid Name !...  "
		$Timer.stop()
		$Timer.start()
		return

	elif $Rate.text == "" or $Rate.text == null:
		$Nagivator.text = "  Enter A Valid Rate !...  "
		$Timer.stop()
		$Timer.start()
		return

	var Name_regex = RegEx.new()
	Name_regex.compile("^[A-Za-z]+$")
	if not Name_regex.search($Name.text):
		$Nagivator.text = " Name Should only contain ALPHABETS !... "
		$Timer.stop()
		$Timer.start()
		return

	var Rate_regex = RegEx.new()
	Rate_regex.compile("^[0-9]*\\.?[0-9]+$")
	if not Rate_regex.search($Rate.text):
		$Nagivator.text = " Rate should only contain INTEGERS or DECIMALS !... "
		$Timer.stop()
		$Timer.start()
		return

	$Nagivator.text = "  Valid INPUT !... "
	$Timer.stop()
	$Timer.start()

	add_data($Name.text, $Rate.text)
	$Notify.text = str(" Name  : " + $Name.text + " Rate  : " + $Rate.text + "\n   Saved !..  ")
	$Timer.stop()
	$Timer.start()

func MainMenu() -> void:
	Hide()

	$Notify.horizontal_alignment = 0

	$Notify.text = " LOADING TO MAIN MENU  "
	await get_tree().create_timer(0.2).timeout

	$Notify.text = " LOADING TO MAIN MENU  !"
	await get_tree().create_timer(0.3).timeout

	$Notify.text = " LOADING TO MAIN MENU  !."
	await get_tree().create_timer(0.4).timeout

	$Notify.text = " LOADING TO MAIN MENU  !.."
	await get_tree().create_timer(0.5).timeout

	get_tree().change_scene_to_file("res://App/Main.tscn")

func Hide():
	$Name.hide()
	$Rate.hide()
	$"Add Data".hide()
	$NoOfDataBase.hide()
	$"Main Menu".hide()
	$Nagivator.hide()

func Timeout_Notify() -> void:
	$Notify.text = ""
	$Nagivator.text = ""

func Create_Table() -> void:
	$Notify.text = "  AddData  "

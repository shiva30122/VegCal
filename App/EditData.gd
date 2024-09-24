extends Node


@export var Name : String 
@export var Rate : String
@export var KG : String  
@export var M : float
@export var Amount : String

var Message : String

@onready var col: ColorRect = $ColorRect
@onready var c_Name = $CName
@onready var c_Rate = $CRate
@onready var Cal = $"."
@onready var update: Button = $Update
@onready var delete: Button = $Delete
@onready var show: Button = $Show
@onready var hide: Button = $Hide
@onready var temp_remove: Button = $TempRemove


# File paths
var config_file_path = "user://Data.cfg"

func _ready():
	Cal.custom_minimum_size = Vector2(33,44)
	await get_tree().create_timer(0.28).timeout
	$Name.text = Name
	print("CAL : ",Name)
	$Rate.text = Rate
	$Kg.text = KG
	
	Global.Show.connect(ShowEdit)
	Global.Hide.connect(HideEdit2)
	
	$CName.text = Name
	$CRate.text = Rate
	

	$Name.show()
	Amount = $Amount.text
	print($CName.text,$CRate.text,)
	

	
	
	if not FileAccess.file_exists(config_file_path):
		var file = FileAccess.open(config_file_path, FileAccess.WRITE)
		file.store_line("[Data]")
		file.close()

# Function to delete data by name
# Function to delete data by name
func delete_data(Old_Name: String) -> void:
	var config = ConfigFile.new()
	var err = config.load(config_file_path)
	if err != OK:
		print("Error loading config file: %s" % err)
		return
	
	# Check if the name exists and remove it
	if config.has_section_key("Data", Old_Name):
		config.erase_section_key("Data", Old_Name)
		config.save(config_file_path)
		print("Name '%s' deleted from the config file." % Old_Name)
		Message = str("Name '%s' deleted from the config file." % Old_Name)
		Global.CALNotify.emit(Message)
	else:
		print("Name '%s' not found in the config file." % Old_Name)
		Message = str("Name '%s' not found in the config file." % Old_Name)
		Global.CALNotify.emit(Message)


# Function to update data
func update_data(Old_Name: String, New_Name: String, New_Rate: String) -> void:
	var config = ConfigFile.new()
	var err = config.load(config_file_path)
	if err != OK:
		print("Error loading config file: %s" % err)
		return

	# Check if the old name exists and update it
	if config.has_section_key("Data", Old_Name):
		var old_rate = config.get_value("Data", Old_Name)
		
		# Update the name and rate in the same order
		var file = FileAccess.open(config_file_path, FileAccess.READ_WRITE)
		var content = file.get_as_text()
		file.close()

		var new_content = ""
		var lines = content.split("\n")
		for line in lines:
			if line.begins_with("%s=" % Old_Name):
				new_content += "%s=%s\n" % [New_Name, New_Rate]
			else:
				new_content += "%s\n" % line

		file = FileAccess.open(config_file_path, FileAccess.WRITE)
		file.store_string(new_content.strip_edges())
		file.close()

		print("Name '%s' updated to '%s' with rate '%s'." % [Old_Name, New_Name, New_Rate])
		Message = str("Name '%s' updated to '%s' with rate '%s'." % [Old_Name, New_Name, New_Rate])
		Global.CALNotify.emit(Message)
	else:
		Message = str("Name '%s' not found in the config file." % Old_Name)
		print("Name '%s' not found in the config file." % Old_Name)
		
		
		
		Global.CALNotify.emit(Message)




# Signal handler for delete button pressed
func _on_delete_pressed():
	delete_data($Name.text)
	self.queue_free()
	

# Signal handler for update button pressed
func _on_update_pressed():
	var Old_Name = $Name.text 
	var New_Name =  $CName.text
	var New_Rate = $CRate.text
	
	update_data(Old_Name, New_Name, New_Rate)
	
	$Name.text = New_Name
	


func HideEdit():
	col.hide()
	c_Name.hide()
	c_Rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.show()
	Cal.custom_minimum_size = Vector2(33, 44)


func HideEdit2():
	col.hide()
	c_Name.hide()
	c_Rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.hide()
	Cal.custom_minimum_size = Vector2(33, 44)


func ShowEdit():
	col.show()
	c_Name.show()
	c_Rate.show()
	update.show()
	delete.show()
	temp_remove.show()
	hide.show()
	show.hide()
	Cal.custom_minimum_size = Vector2(33, 152)


func _on_hide_pressed() -> void:
	HideEdit()


func _on_show_pressed() -> void:
	ShowEdit()


func _on_kg_text_changed(new_text: String) -> void:
	Calculate()


func Calculate():
	FindIntOrFloat()
	KG = $Kg.text
	
	if Int == true:
		Rate.to_int()
		KG.to_int()
		$Amount.text = str(Rate.to_float() * (float($Kg.text.to_int())))
		M = float($Amount.text)
		Amount = $Amount.text
		$Amount.text = str("%.2f" % float($Amount.text))
		
	if Float == true:
		Rate.to_float()
		KG.to_float()
		$Amount.text = str(float(Rate.to_float() * (float($Kg.text.to_float()))))
		M = float($Amount.text)
		Amount = $Amount.text
		$Amount.text = str("%.2f" % float($Amount.text))


var Int: bool
var Float: bool

func FindIntOrFloat():
	var val = $Kg.text.strip_edges()  # Remove leading and trailing whitespace

	if val.find(".") != -1:
		Int = false
		Float = true
	else:
		Int = true
		Float = false


func Temp_Remove() -> void:
	self.queue_free()

extends Control


@export var Name : String 

@export var Rate : String

@export var KG : String  
@export var M : float

@export var Amount : String

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	#M = float($KG.text)
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
	
	c_Name.text = Name
	c_Rate.text = Rate
	
	$Name.show()
	Amount = $Amount.text
	print($CName.text,$CRate.text,)
	
	if ! FileAccess.file_exists(config_file_path) :
	
		return
		
	load_data()
	


# Path to the config file
var config_file_path : String = Global.config_file_path

var config = ConfigFile.new()


# Function to load data from the config file
func load_data():
	var error = config.load(config_file_path)
	if error != OK:
		print("Failed to load config file")
		return
		
		
	# Example: print all the vegetables and their Rates
	
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			
			print("Vegetable: %s, Rate: %s" % [key, config.get_value(section, key)])
			var VName = str(key)
			var VRate = config.get_value("vegetables", key)
			print(" Name :",VName,"    VRate :",VRate)
			

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#
	#
	#Calculate()
	#
	#if Input.is_action_just_pressed("ui_up"):
		#$Hide.show()
		#ShowEdit()
	#if Input.is_action_just_pressed("ui_down"):
		#ShowEdit()
	#if Input.is_action_just_pressed("ui_accept"):
		#pass
	#pass

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
		#print(KG.to_int())
		$Amount.text = str(float(Rate.to_float() * (float($Kg.text.to_float()))))
		M = float($Amount.text)
		Amount = $Amount.text
		$Amount.text = str("%.2f" % float($Amount.text))
	
	
	
	
	pass

var Int : bool
var Float : bool

func FindIntOrFloat():
	
	var val = $Kg.text.strip_edges()  # Remove leading and trailing whitespace

	if val.find(".") != -1:
		# Decimal point found, treat as float
		
		#var float_value = val.to_float()
		Int = false
		Float = true
		#print("Float value:", float_value)
	else:
		# No decimal point found, treat as integer
		
		#var int_value = val.to_int()
		Int = true
		Float = false
		#print("Integer value:", int_value)



@onready var col: ColorRect = $ColorRect
@onready var c_Name = $CName
@onready var c_Rate = $CRate
@onready var Cal = $"."
@onready var update: Button = $Update
@onready var delete: Button = $Delete
@onready var show: Button = $Show
@onready var hide: Button = $Hide
@onready var temp_remove: Button = $TempRemove


func HideEdit():
	
	col.hide()
	c_Name.hide()
	c_Rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.show()
	
	
	Cal.custom_minimum_size = Vector2(33,44)

func HideEdit2():
	
	col.hide()
	c_Name.hide()
	c_Rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.hide()
	
	
	Cal.custom_minimum_size = Vector2(33,44)

func ShowEdit():
	
	col.show()
	c_Name.show()
	c_Rate.show()
	update.show()
	delete.show()
	temp_remove.show()
	hide.show()
	show.hide()
	
	Cal.custom_minimum_size = Vector2(33,98)

func _on_hide_pressed() -> void:
	HideEdit()
	pass # Replace with function body.

func _on_show_pressed() -> void:
	ShowEdit()
	pass # Replace with function body.

# Function to add or update a vegetable
func add_or_update_vegetable(Name: String, Rate: String):
	
	if config.has_section_key("Vegetables", $Name.text):
		var rate = config.get_value("Vegetables",  $Name.text)
		
		# Remove the old entry
		config.set_value("Vegetables",  $Name.text, null)
		
		# Add the new entry with the same rate
		config.set_value("Vegetables",  $CName.text, rate)
		
		return
	config.set_value("vegetables", Name, Rate)
	config.save(config_file_path)

# Function to delete a vegetable
func delete_vegetable(Name: String, ):
	if config.has_section_key("vegetables", Name):
		config.erase_section_key("vegetables", Name)
		
		#print(Name+str("="+"'"+Rate+"'"))
		var error = config.save(config_file_path)
		if error != OK:
			print("Failed to save config file: %s" % error)
	else:
		print("Vegetable not found: %s" % Name)

# Example usage with UI
func _add_or_update():
	var Name = $Name.text
	var Rate = $Rate.text
	add_or_update_vegetable(Name, Rate)
	load_data()

func _on_delete():
	var Name = $Name.text
	var Rate = $Rate.text
	delete_vegetable(Name)
	load_data()




func Temp_Remove() -> void:
	
	self.queue_free()

func _on_kg_text_changed(new_text: String) -> void:
	
	Calculate()
	
	pass # Replace with function body.

extends Control


# Path to the config file
var config_file_path = "res://vegetables.cfg"

var config = ConfigFile.new()

# Loads the data from the config file
func _ready():
	var config_file_path = "res://vegetables.cfg"
	var cal = CAL.instantiate()
	cal.add_child($Box/BoxContainer/HBC)

	load_data()
var CAL = preload("res://App/Cal.tscn")
# Function to load data from the config file
func load_data():
	var error = config.load(config_file_path)
	if error != OK:
		print("Failed to load config file")
		return
		
		

	# Example: print all the vegetables and their rates
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			print("Vegetable: %s, Rate: %s" % [key, config.get_value(section, key)])
			var VName = str(key)
			var VRate = config.get_value("vegetables", key)
			print(" NAME :",VName,"    VRATE :",VRate)
			
			var Ins = preload("res://App/Cal.tscn").instantiate()
			%HBC.add_child(Ins)
			
			
			print(VName)
			Ins.Rate = str(VRate)
			Ins.Name = str(VName)
			Ins.name = str(VName)
			

# Function to add or update a vegetable
func add_or_update_vegetable(name: String, rate: String):
	config.set_value("vegetables", name, rate)
	config.save(config_file_path)

# Function to delete a vegetable
func delete_vegetable(name: String, ):
	if config.has_section_key("vegetables", name):
		config.erase_section_key("vegetables", name)
		
		#print(name+str("="+"'"+rate+"'"))
		var error = config.save(config_file_path)
		if error != OK:
			print("Failed to save config file: %s" % error)
	else:
		print("Vegetable not found: %s" % name)

# Example usage with UI
func _on_add_button_pressed():
	var name = $Name.text
	var rate = $Rate.text
	add_or_update_vegetable(name, rate)
	load_data()

func _on_delete_button_pressed():
	var name = $Name.text
	var rate = $Rate.text
	delete_vegetable(name)
	load_data()

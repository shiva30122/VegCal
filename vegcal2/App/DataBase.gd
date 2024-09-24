extends Control


var database = SQLite.new()      # Int DataBase
var Fdatabase = SQLite.new()   # Float DataBase

var DB_PATH : String = "user://data.db"
var FDB_PATH : String = "user://Fdata.db"

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	$NoOfDataBase.text = str("  Number Of Data's In DataBase  = ", Global.TotalData ,"\n ",FDB_PATH ,"  " , DB_PATH)
	
	if FileAccess.file_exists(DB_PATH) and FileAccess.file_exists(FDB_PATH): 
		
		$Notify.text = "  DataBase Is Exist  !... 
		 If Any Error ? -> Click Create DataBase !..  "
		$Timer.start()
		database.path = DB_PATH
		database.open_db()
		Fdatabase.path = FDB_PATH
		Fdatabase.open_db()
		NoOfDataBase()
		
		#print(" Ready ",Fdatabase.open_db(),"  ", database.open_db())
		
		return
	
	Create_Table()
	
	$Notify.text = " DataBase Created Sucessufully !...  "
	


func Add_Data() -> void:
	
	"       Make Sure Int or Float For Coressponding DataBase          "
	
	FindIntOrFloat()
	
	if $Name.text == "" :
		$Notify.text = "  Enter A Valid Name  !... "
		$Timer.start()
		return
	if $Rate.text == "" :
		$Notify.text = "  Enter A Valid Rate  !... "
		$Timer.start()
		return
	
	if Int == true and database.select_rows("Vegetable","Name == '"+str($Name.text)+ "'",["Name"]):
		
		$Notify.text = "  The Name Is Already Exist In DataBase !... \n   Choose a Different Name !...  "
		
		$Timer.start()
		return
	if Float == true and Fdatabase.select_rows("Vegetable","Name == '"+str($Name.text)+ "'",["Name"]):
		
		$Notify.text = "  The Name Is Already Exist In DataBase !... \n   Choose a Different Name !...  "
		
		$Timer.start()
		return
		
	if Int == true:
		int($Rate.text)
		var data ={
			"Name" : str($Name.text),
			"Rate" : float($Rate.text)
		}
		
		database.insert_row("Vegetable",data)
		#print(" DataAdded  ",data)
		
	elif Float == true:
		
		float($Rate.text)
		var data ={
			"Name" : str($Name.text),
			"Rate" : float($Rate.text)
		}
		
		Fdatabase.insert_row("Vegetable",data)
		#print(" DataAdded  ",data)
		
	#print(" Check Last ",database.select_rows("Vegetable","Name == '"+str($Name.text)+ "'",["Name"]))
	
	$Notify.text = "  Added to DataBase  " + str(" Name : ",$Name.text," Rate ",$Rate.text ,"  ")
	
	NoOfDataBase()
	
	$Timer.start()
	
	#print("  Select  ",database.select_rows("Vegetable"," Name = " + str($Name.text) ,["Name"]))
	pass # Replace with function body.


func Create_Table() -> void:
	
	if FileAccess.file_exists(DB_PATH) and FileAccess.file_exists(FDB_PATH): 
		
		$Notify.text = "  DataBase Is Exist  !...  "
		
		#return
		
	database.path = DB_PATH
	database.open_db()
	
	var table={
		"id":{ "data_type":"int", "primary_key" : true , "not_null" : true , "auto_increment" : true},
		"Name":{ "data_type":"text"},
		"Rate":{ "data_type":"int"}
	}
	
	database.create_table("Vegetable", table)
	
	
	Fdatabase.path = FDB_PATH
	Fdatabase.open_db()
	
	var Ftable={
		"id":{ "data_type":"int", "primary_key" : true , "not_null" : true , "auto_increment" : true},
		"Name":{ "data_type":"text"},
		"Rate":{ "data_type":"float"}
	}
	
	Fdatabase.create_table("Vegetable", Ftable)
	
	$Notify.text = " Table  : \n  " + str(table,"\n",Ftable)
	
	#print("  Table Created   ", table ,"   ", Ftable )
	
	pass # Replace with function body.


var Int : bool
var Float : bool

func FindIntOrFloat():
	
	var val = $Rate.text.strip_edges()  # Remove leading and trailing whitespace

	if val.find(".") != -1:
		# Decimal point found, treat as float
		
		var float_value = val.to_float()
		Int = false
		Float = true
		print("Float value:", float_value)
	else:
		# No decimal point found, treat as integer
		
		var int_value = val.to_int()
		Int = true
		Float = false
		print("Integer value:", int_value)
		


func NoOfDataBase():
	
	var intbase = database.select_rows("Vegetable","Name == Name",["*"]).size()
	var floatbase = Fdatabase.select_rows("Vegetable","Name == Name",["*"]).size()
	Global.TotalData = 0
	Global.TotalData  = intbase + floatbase
	print(Global.TotalData)
	
	$NoOfDataBase.text = str("  Number Of Data's In DataBase  = ", Global.TotalData)
	
	#print(" TotalNoOfDataBase ",intbase,floatbase)
	
	pass


func Timeout_Notify() -> void:
	
	$Notify.text = " "
	
	pass # Replace with function body.

@export var Main_Menu : PackedScene

func MainMenu() -> void:
	
	get_tree().change_scene_to_file("res://App/Main.tscn")
	
	pass # Replace with function body.

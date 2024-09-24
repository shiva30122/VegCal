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
	
	c_name.text = Name
	c_rate.text = Rate
	
	$Name.show()
	Amount = $Amount.text
	print($CName.text,$CRate.text,)
	
	
	pass # Replace with function body.



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
@onready var c_name = $CName
@onready var c_rate = $CRate
@onready var Cal = $"."
@onready var update: Button = $Update
@onready var delete: Button = $Delete
@onready var show: Button = $Show
@onready var hide: Button = $Hide
@onready var temp_remove: Button = $TempRemove


func HideEdit():
	
	col.hide()
	c_name.hide()
	c_rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.show()
	
	
	Cal.custom_minimum_size = Vector2(33,44)




func HideEdit2():
	
	col.hide()
	c_name.hide()
	c_rate.hide()
	update.hide()
	delete.hide()
	hide.hide()
	temp_remove.hide()
	show.hide()
	
	
	Cal.custom_minimum_size = Vector2(33,44)




func ShowEdit():
	
	col.show()
	c_name.show()
	c_rate.show()
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


func Update_DataBase() -> void:
	
	FindIntOrFloat()
	
	print("    Update ")
	
	var database = SQLite.new()
	var Fdatabase = SQLite.new()
	
	var DB_PATH : String = "user://data.db"
	var FDB_PATH : String = "user://Fdata.db"
	database.path = DB_PATH
	Fdatabase.path = FDB_PATH
	database.open_db()
	Fdatabase.open_db()
	
	if Int == true:
		

		
		#print("Data Deleted : ",Name,"  ",Int,Float)
		database.update_rows("Vegetable"," Name = '" + $Name.text +"'",{"Name" : $CName.text,"Rate" : int($CRate.text)})
		
		self.queue_free()
		
		pass
		
	if Float == true:
		
		#print("Data Deleted : ",Name,"  ",Int,Float)
		Fdatabase.update_rows("Vegetable"," Name = '" + $Name.text +"'",{"Name" : $CName.text,"Rate" : float($CRate.text)})
		
		self.queue_free()
		
		pass
		
		
	pass # Replace with function body.


func Delete_From_DataBase() -> void:
	
	FindIntOrFloat()
	
	print("   Delete  ")
	
	var database = SQLite.new()
	var Fdatabase = SQLite.new()
	
	var DB_PATH : String = "user://data.db"
	var FDB_PATH : String = "user://Fdata.db"
	database.path = DB_PATH
	Fdatabase.path = FDB_PATH
	database.open_db()
	Fdatabase.open_db()
	
	if Int == true:
		
		print("Data Deleted : ",Name,"  ",  $Name.text ,"  ",Int,Float)
		database.delete_rows("Vegetable"," Name = '" + $Name.text +"'")
		
		self.queue_free()
		
		
		
	if Float == true:
		
		print("Data Deleted : ",Name,"  ",  $Name.text ,"  ",Int,Float)
		Fdatabase.delete_rows("Vegetable"," Name =='"+$Name.text+"'")
		
		self.queue_free()
		
		
		
		
	


func Temp_Remove() -> void:
	
	self.queue_free()
	
pass # Replace with function body.


func _on_kg_text_changed(new_text: String) -> void:
	
	Calculate()
	
	pass # Replace with function body.

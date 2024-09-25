extends Node

signal Show

signal  Hide

signal CALNotify(Message : String)

signal Total

@onready var TotalData : int 



var config_file_path = "user://Data.cfg"


var config = ConfigFile.new()

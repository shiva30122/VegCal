extends Node2D

var db= Firebase.Database.get_database_reference("DB")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db.getd.connect(getd)
	pass # Replace with function body.

func getd(data):
	print(data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_sign_in_google_pressed() -> void:
	
	var Provider : AuthProvider = Firebase.Auth.get_GoogleProvider()
	#Firebase.Auth.get_auth_localhost(Provider,8060)
	print("  Provider   ",Provider)
	pass # Replace with function body.


var DB_PATH : String = "user://data.db"


var COLLECTION_ID ="SharMi"
func _on_save_to_cloud_pressed() -> void:
	
	
	var upnp = UPNP.new()
	var dis = upnp.discover()
	print(dis)
	#var upload_task = Firebase.Storage.ref("").put_file(DB_PATH)
	
	pass # Replace with function body.
	
#var auth = Firebase.Auth.auth#
	#if auth.localid:
	#var collection: FirebaseDatabaseStore = Firebase.Storage.collection(COLLECTION_ID)

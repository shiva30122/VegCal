extends Node

# Replace with your Firebase Storage bucket URL
const FIREBASE_STORAGE_BUCKET = "your-firebase-storage-url"

# Firebase reference
var storage_ref = Firebase.Storage.new()


func _ready():
	storage_ref = Firebase.Storage.new()
	
	var upload_task = Firebase.Storage.ref("gs://sharmi-data.appspot.com/upload/icon.png").put_file("res://icon.png")
	await upload_task.task_finished
	upload_task.task_finished
	# Initialize Firebase (make sure you have initialized Firebase in your project)
	Firebase.initialize("your-firebase-config")

# Function to upload a file
func upload_file(file_path: String, file_name: String):

		var task = storage_ref
		var storage_path = "uploads/" + file_name  # Define the path in Firebase Storage
		#storage_ref(FIREBASE_STORAGE_BUCKET, storage_path, file_data, true)
		storage_ref
		
	
# Callback for upload completion
func _on_upload_completed(download_url: String):
	print("File uploaded successfully! Download URL: " + download_url)

# Callback for upload failure
func _on_upload_failed(error: String):
	print("Upload failed with error: " + error)

# Function to download a file
#func download_file(file_name: String):
	#var storage_path = "uploads/" + file_name  # Define the path in Firebase Storage
	#storage_ref.get_file(FIREBASE_STORAGE_BUCKET, storage_path).then(
		#funcref(self, "_on_download_completed")
	#).catch(
		#funcref(self, "_on_download_failed")
	#)
#
## Callback for download completion
#func _on_download_completed(file_data: PoolByteArray):
	#var file_path = "downloaded_" + file_name  # Define a local file path
	#var file = File.new()
	#file.open(file_path, File.WRITE)
	#file.store_buffer(file_data)
	#file.close()
	#print("File downloaded successfully to: " + file_path)

# Callback for download failure
func _on_download_failed(error: String):
	print("Download failed with error: " + error)
	
	


	
	
	
	
	
	

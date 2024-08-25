extends Node2D



var ScrenTouch = 0

func _on_full_screen_pressed() -> void:
	
	ScrenTouch+=1
	print(ScrenTouch," Touch  ")
	if ScrenTouch == 2:
		ScrenTouch=0
		$"../FullScreen".play("Play")
		$"../Box".size.y = 682
		$"../Notify".text = "  FULL SCREEN SIZE .    "
		$Out.start()
	
	elif ScrenTouch == 1:
		
		$"../FullScreen".play("Play")
		$"../Box".size.y = 228
		$"../Notify".text = "    MINIMIZED SCREEN SIZE .    "
		$Out.start()
		
	
	pass # Replace with function body.


func _on_out_timeout() -> void:
	
	$"../Notify".text = ""
	$"../Notify2".text = ""
	pass # Replace with function body.
	
	


func _on_edit_pressed() -> void:
	
	
	
	Global.Show.emit()
	$".".hide()
	$"../Back2".show()
	$"../TotalButton".hide()
	
	pass # Replace with function body.

func _on_back_pressed() -> void:
	
	Global.Hide.emit()
	$"../Back2".hide()
	$"../TotalButton".show()
	
	pass # Replace with function body.
	
	

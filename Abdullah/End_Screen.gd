extends Control

signal goto_next
signal repeat

func _on_Button_pressed():
	get_tree().quit()

func _on_Button2_pressed():
	self.emit_signal("goto_next")
	

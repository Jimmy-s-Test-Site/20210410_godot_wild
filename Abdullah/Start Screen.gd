extends Control

signal goto_next
signal repeat

func _on_Label_goto_next():
	self.emit_signal("goto_next")

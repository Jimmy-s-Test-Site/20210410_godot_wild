extends Node2D

signal goto_next
signal repeat

export(NodePath) var slot_machine_path = null

func _ready():
	$AudioStreamPlayer.play()

func _on_Character_die():
	self.emit_signal("repeat")

func _on_SlotMachine_teleport():
	self.emit_signal("goto_next")

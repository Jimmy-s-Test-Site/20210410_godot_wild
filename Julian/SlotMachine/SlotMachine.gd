extends Node2D

signal teleport

enum SLOT {
	EVIL1_WRATH,
	EVIL2_LUST,
	EVIL3_GREED,
	EVIL4_SLOTH,
	EVIL5_ENVY,
	EVIL6_GLUTTONY,
	EVIL7_PRIDE
}

export(NodePath) var slots : NodePath
export(Array, SLOT) var slot_values : Array
export(int) var covered_slots = 0

func _ready():
	pass

func cover(slots : int) -> void:
	if self.covered_slots == slots:
		return

func teleport():
	self.emit_signal("teleport")

func _on_InteractionRadius_body_entered(body):
	if body.name == "Character":
		self.teleport()

extends Node2D

enum ENEMY_SPAWN {
	EVIL1_WRATH,
	EVIL2_LUST,
	EVIL3_GREED,
	EVIL4_SLOTH,
	EVIL5_ENVY,
	EVIL6_GLUTTONY,
	EVIL7_PRIDE
}

var enemy_scenes = {
	ENEMY_SPAWN.EVIL1_WRATH:    "res://Abdullah/Enemies[7]/Minion_Wrath.tscn",
	ENEMY_SPAWN.EVIL2_LUST:     "res://Abdullah/Enemies[7]/Minion_Lust.tscn",
	ENEMY_SPAWN.EVIL3_GREED:    "res://Abdullah/Enemies[7]/Minion_Greed.tscn",
	ENEMY_SPAWN.EVIL4_SLOTH:    "res://Abdullah/Enemies[7]/Minion_Sloth.tscn",
	ENEMY_SPAWN.EVIL5_ENVY:     "res://Abdullah/Enemies[7]/Minion_Envy.tscn",
	ENEMY_SPAWN.EVIL6_GLUTTONY: "res://Abdullah/Enemies[7]/Minion_Gluttony.tscn",
	ENEMY_SPAWN.EVIL7_PRIDE:    "res://Abdullah/Enemies[7]/Minion_Pride.tscn"
}

export(ENEMY_SPAWN) var enemy_spawned
export(int) var amount = 5

func _ready():
	self.generate()

func generate() -> void:
	for i in range(self.amount):
		var minion = load(self.enemy_scenes[self.enemy_spawned]).instance()
		minion.position.x +=  randf() * 6 - 3
		self.add_child(minion)

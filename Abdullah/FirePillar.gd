extends Node2D

export (PackedScene) var Fairy
export (int) var max_range = 300
export (int) var minimum_time_to_blow = 2
export (int) var maximum_time_to_blow = 6

onready var ratio = self.max_range/(self.maximum_time_to_blow - self.minimum_time_to_blow)


# Called when the node enters the scene tree for the first time.
func _ready():
	Fairy.connect("Fire_Pillar", self , "_on_get_fire_pillar_trigged")
	

func _on_get_fire_pillar_trigged():
	print("hey")

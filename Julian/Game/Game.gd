extends Node2D

export(Array, PackedScene) var levels

var scene_index = -1
var scene : Node2D = null

func _ready():
	self.load_scene(0)

func load_scene(n : int) -> void:
	if self.scene != null:
		self.scene.disconnect("goto_next", self, "on_level_goto_next")
		self.scene.queue_free()
	
	self.scene_index = n
	self.scene = self.levels[n].instance()
	
	self.scene.connect("goto_next", self, "on_level_goto_next")
	
	self.add_child(scene)

func on_level_goto_next() -> void:
	self.load_scene((self.scene_index + 1) % self.levels.length)

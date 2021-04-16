extends Node2D

export(Array, PackedScene) var levels

var level_index = -1
var level : Node2D = null

func _ready():
	self.load_level(0)

func load_level(n : int) -> void:
	if self.level != null:
		self.level.disconnect("goto_next", self, "on_level_goto_next")
		self.level.queue_free()
	
	self.level_index = n
	self.level = self.levels[n].instance()
	self.level.connect("goto_next", self, "on_level_goto_next")
	
	self.call_deferred("add_child", self.level)# add_child(level)

func on_level_goto_next() -> void:
	self.load_level(self.level_index + 1)

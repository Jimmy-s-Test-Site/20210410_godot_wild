extends Node2D

export(int) var start_at = 0
export(Array, PackedScene) var levels

var level_index = -1
var level = null
var muted = false

func _ready():
	self.load_level(self.start_at % self.levels.size())

func load_level(n : int) -> void:
	if self.level != null:
		self.level.disconnect("goto_next", self, "on_level_goto_next")
		self.level.disconnect("repeat", self, "on_level_repeat")
		self.level.queue_free()
	
	self.level_index = n
	self.level = self.levels[n].instance()
	self.level.connect("goto_next", self, "on_level_goto_next")
	self.level.connect("repeat", self, "on_level_repeat")
	
	# this fucker right here almost killed me
	# if you get errors about collisions or whatever, remember this line
	# since the level is getting freed, I can't add the new level until I'm sure the world is clear
	self.call_deferred("add_child", self.level)

func on_level_goto_next() -> void:
	self.load_level((self.level_index + 1) % self.levels.size())

func on_level_repeat() -> void:
	self.load_level(self.level_index);
	
func _process(delta):
	if Input.is_action_just_pressed("Mute"):
		self.muted = !self.muted
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), self.muted)

extends Node2D

export var enabled = false

func _ready():
	pass

func set_is_casting(value : bool) -> void:
	for fire_pillar in self.get_children():
		if not fire_pillar is Timer:
			fire_pillar.is_casting = value

func _on_AppearTimer_timeout():
	if self.enabled:
		self.set_is_casting(true)
		$DisappearTimer.start()

func _on_DisappearTimer_timeout():
	self.set_is_casting(false)
	$AppearTimer.start()

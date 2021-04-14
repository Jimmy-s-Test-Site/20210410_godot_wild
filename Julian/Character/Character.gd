extends KinematicBody2D

export(int) var run_speed = 350
export(int) var jump_speed = -1000
export(int) var gravity = 2500

var alive = true

var velocity = Vector2.ZERO

var input = {
	movement = Vector2.ZERO,
	jump = false
}

func _ready() -> void:
	$AnimationPlayer.play("main")

func _physics_process(delta : float) -> void:
	if alive:
		self.input_manager()
		self.movement_manager(delta)
		self.attack_manager()
		self.animation_manager()

func input_manager() -> void:
	self.input.movement = Vector2(
		int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
		int(Input.is_action_pressed("up"))    - int(Input.is_action_pressed("down")))
	
	self.input.jump = Input.is_action_just_pressed("jump")

func movement_manager(delta : float) -> void:
	# add gravity
	self.velocity.y += self.gravity * delta
	
	# add jump force
	if self.is_on_floor() and self.input.jump:
		self.velocity.y = self.jump_speed
	
	# add horizontal movement
	self.velocity.x = self.input.movement.x * self.run_speed
	
	# apply movement
	self.velocity = self.move_and_slide(self.velocity, Vector2.UP)

func attack_manager():
	pass

func animation_manager():
	pass

func _on_Hitbox_body_entered(body):
	if body.name.begins_with("Enemy"):
		# die when touched
		self.queue_free()

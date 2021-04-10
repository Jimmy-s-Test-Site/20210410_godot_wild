extends KinematicBody2D

var run_speed = 350
var jump_speed = -1000
var gravity = 2500

var velocity = Vector2.ZERO

var input = {
	movement = Vector2.ZERO,
	jump = false
}

func get_input():
	self.input.movement.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	self.input.jump = Input.is_action_just_pressed("jump")
	
	if self.is_on_floor() and self.input.jump:
		self.velocity.y = self.jump_speed
	
	self.velocity.x = self.input.movement.x * self.run_speed

func _physics_process(delta):
	self.velocity.y += self.gravity * delta
	self.get_input()
	self.velocity = self.move_and_slide(self.velocity, Vector2.UP)

extends KinematicBody2D

signal died
signal ready_hit
signal hit_player

export (NodePath) var player_character_path

onready var player_character = self.get_node(player_character_path)

export (int) var  movement_speed = 100
export (int) var jump_speed

export (int) var attack_power
export (int) var aggro_range = 500
export (int) var health = 1

export (int) var gravity = 250

var velocity = Vector2.ZERO
var is_alive = true
var direction_to_move

func movement_manager(delta : float):
	self.velocity.x = 0
	
	
	if !self.is_on_floor():
		self.velocity.y += self.gravity * delta
	
	
	if direction_to_move > 0:
		self.velocity.x = -movement_speed
	elif direction_to_move < 0:
		self.velocity.x = movement_speed
	
	
	self.velocity = self.move_and_slide(self.velocity, Vector2.UP)

func health_manager():
	if health <= 0:
		emit_signal("died")
		#$CollisionShape2D.disabled = true
		self.is_alive = false
		#self.visible = false
		self.queue_free()

func attack_manager():
	if direction_to_move > (100) or direction_to_move < (-100) or direction_to_move == 0:
		$"Attack Area/Range".disabled = true
	else:
		$"Attack Area/Range".disabled = false

func animation_manager():
	pass

func find_character():
	self.direction_to_move = self.position.x - player_character.position.x
	if direction_to_move > aggro_range or direction_to_move < -aggro_range:
		direction_to_move = 0

func _ready():
	pass # Replace with function body.



func _process(delta):
	self.health_manager()
	if self.is_alive:
		self.find_character()
		self.movement_manager(delta)
		self.attack_manager()
	


func _on_Attack_Area_body_entered(body):
	if body.name == "Character":
		emit_signal("hit_player")





func _on_HitBox_body_entered(body):
	print(body.name)
	var damage = 1#body.damage
	self.health -= 1

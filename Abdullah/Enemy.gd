extends KinematicBody2D

signal died

export (NodePath) var player_character_path

onready var player_character = self.get_node(player_character_path)

export (int) var  movement_speed = 100
export (int) var jump_speed

export (int) var attack_power
export (int) var health

export (int) var gravity = 250

var velocity = Vector2.ZERO
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

func find_character():
	self.direction_to_move = self.position.x - player_character.position.x

func _ready():
	pass # Replace with function body.



func _process(delta):
	self.find_character()
	self.movement_manager(delta)

extends KinematicBody2D

signal died
signal ready_hit
signal hit_player

export (NodePath) var player_character_path

onready var player_character = self.get_node_or_null(player_character_path)

export (int) var  movement_speed = 100

export (int) var aggro_range = 500
export (int) var health = 1

export (int) var gravity = 250

#onready var state_machine = $AnimationTree.get("parameters/playback")
var velocity = Vector2.ZERO
var is_being_lazered = false
var is_alive = true
var direction_to_move
var timer_length = .3

func movement_manager(delta : float):
	self.velocity.x = 0
	
	
	if !self.is_on_floor():
		self.velocity.y += self.gravity * delta
	
	if player_character != null:
		if  self.position.y - player_character.position.y < -10:
			self.direction_to_move = 0
	else:
		self.direction_to_move = 0
	
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
	if self.direction_to_move != 0:
		if direction_to_move < -3:
			#$AnimationTree.set('parameters/Idle/blend_position' ,-1)
			#$AnimationTree.set('parameters/Walk/blend_position' ,-1)
			$AnimationPlayer.play("Walking_Right")
		elif direction_to_move > 3:
			#$AnimationTree.set('parameters/Idle/blend_position' ,1)
			#$AnimationTree.set('parameters/Walk/blend_position' ,1)
			$AnimationPlayer.play("Walking_Left")
		
	if self.direction_to_move > -3 and self.direction_to_move < 3:
		$AnimationPlayer.play("Idle")
		#self.state_machine.travel('Idle')


func find_character():
	if player_character != null:
		self.direction_to_move = self.position.x - player_character.position.x
		if direction_to_move > aggro_range or direction_to_move < -aggro_range:
			direction_to_move = 0

func _ready():
	pass


func _process(delta):
	self.health_manager()
	if self.is_alive:
		self.find_character()
		self.movement_manager(delta)
		self.animation_manager()
		self.attack_manager()
		
	


func _on_Attack_Area_body_entered(body):
	if body.name == "Character":
		emit_signal("hit_player")




func _on_HitBox_area_entered(area):
	if area.get_parent().name == "CollisionParticles2D":
		var damage = 1
		self.health -= damage
		self.is_being_lazered = true
		$Timer.start(self.timer_length)


func _on_HitBox_area_exited(area):
	if area.get_parent().name == "CollisionParticles2D":
		self.is_being_lazered = false
		$Timer.stop()
	


func _on_Timer_timeout():
	if self.is_being_lazered == true:
		self.health -= 1
		$Timer.start(self.timer_length)

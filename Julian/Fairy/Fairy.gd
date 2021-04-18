extends KinematicBody2D

signal Fire_Pillar

export(NodePath) var player_path
export(NodePath) var spawn_points_path
export(NodePath) var fire_rings_path
export(int) var speed = 4000

var casting
var facing_direction = 1
var frozen = false
var movement = Vector2.ZERO



func get_player() -> Object:
	return get_node_or_null(self.player_path)

func get_spawn_point() -> Object:
	return get_node_or_null(self.spawn_points_path)

func get_fire_rings() -> Object:
	return get_node_or_null(self.fire_rings_path)


func _ready():
	$AnimationPlayer.play("idle_right")

func _physics_process(delta : float) -> void:
	if not self.frozen:
		self.movement_manager(delta)
		self.animation_manager()



func movement_manager(delta : float) -> void:
	if self.get_player() != null:
		var direction_to_player = self.get_player().position - self.position
		
		if direction_to_player.length() < 102:
			return
		
		var direction_to_move = direction_to_player.normalized()
		
		self.facing_direction = sign(direction_to_move.x)
		
		self.movement = direction_to_move
		
		self.movement = self.move_and_slide(self.movement * self.speed * delta)

func animation_manager():
	if self.facing_direction == 1:
		$AnimationPlayer.play("idle_right")
	else:
		$AnimationPlayer.play("idle_left")



func _on_HitBox2D_area_entered(area):
	$FreezingTimer.start()

func _on_HitBox2D_area_exited(area):
	$FreezingTimer.stop()

func _on_FreezingTimer_timeout():
	self.frozen = true
	$UnfreezingTimer.start()

func _on_UnfreezingTimer_timeout():
	self.frozen = false

func _on_SpawnTimer_timeout():
	
	
	$SpawnTimer.start()

func _on_FireTimer_timeout():
	if self.get_fire_rings() != null:
		var closest_spawn_point
		var smallest_distance = -1
		
		for spawn_point in self.get_fire_rings().get_children():
			spawn_point.enabled = false
			
			var distance = spawn_point.position.distance_to(self.position)
			
			if smallest_distance == -1 or distance < smallest_distance:
				closest_spawn_point = spawn_point
				smallest_distance = distance
		
		if closest_spawn_point.enabled == false:
			closest_spawn_point.enabled = true
			closest_spawn_point.get_node("AppearTimer").start()
	
	$FireTimer.start()

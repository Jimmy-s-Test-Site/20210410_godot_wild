extends RayCast2D

export var rotation_speed = deg2rad(5)
# Speed at which the laser extends when first fired, in pixels per seconds.
export var cast_speed := 7000.0
export var max_length := 1400.0
export var growth_time := 0.1

# If `true`, the laser is firing.
# It plays appearing and disappearing animations when it's not animating.
var is_casting := false setget set_is_casting

onready var fill := $FillLine2D
onready var tween := $Tween
onready var casting_particles := $CastingParticles2D
onready var collision_particles := $CollisionParticles2D
onready var beam_particles := $BeamParticles2D

onready var line_width: float = fill.width

var snap_to_mouse_next_frame = false

func _ready() -> void:
	self.set_physics_process(false)
	fill.points[1] = Vector2.ZERO

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		self.is_casting = event.pressed

func _physics_process(delta: float) -> void:
	var target_rotation = (self.get_global_mouse_position() - self.global_position).angle()
	
	if self.snap_to_mouse_next_frame:
		self.rotation = target_rotation
		self.snap_to_mouse_next_frame = false
	
	var dir = self.get_angle_to(self.get_global_mouse_position())
	
	if abs(dir) < self.rotation_speed:
		self.rotation += dir
	else:
		if dir > 0: self.rotation += self.rotation_speed
		if dir < 0: self.rotation -= self.rotation_speed
	
	
	self.cast_to = (self.cast_to + Vector2.RIGHT * self.cast_speed * delta).clamped(self.max_length)
	self.cast_beam()

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	if self.is_casting:
		self.cast_to = Vector2.ZERO
		self.fill.points[1] = self.cast_to
		self.appear()
	else:
		self.collision_particles.emitting = false
		self.disappear()

	self.set_physics_process(self.is_casting)
	self.beam_particles.emitting = self.is_casting
	self.casting_particles.emitting = self.is_casting

func cast_beam() -> void:
	var cast_point := self.cast_to
	
	self.force_raycast_update()
	self.collision_particles.emitting = self.is_colliding()
	
	if self.is_colliding():
		cast_point = self.to_local(self.get_collision_point())
		self.collision_particles.global_rotation = self.get_collision_normal().angle()
		self.collision_particles.position = cast_point
	
	self.fill.points[1] = cast_point
	self.beam_particles.position = cast_point * 0.5
	self.beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func appear() -> void:
	if self.tween.is_active(): self.tween.stop_all()
	self.tween.interpolate_property(self.fill, "width", 0, self.line_width, self.growth_time * 2)
	self.tween.start()

func disappear() -> void:
	if self.tween.is_active(): self.tween.stop_all()
	self.tween.interpolate_property(self.fill, "width", self.fill.width, 0, self.growth_time)
	self.tween.start()

# Adapted from @Unain's youtube tutorial
# https://youtu.be/yzbxoZFsU2Y?si=xWUWDL4AoLBSnVbU

class_name MovementComponent
extends Node2D

@export_subgroup("Settings")
@export var gravity: float = 1000.0
@export var speed: float = 100
@export var jump_velocity: float = -350.0
@export var falling_acceleration_percent: int = 100

var body: CharacterBody2D 
var airborne: bool = false
var sprite: AnimatedSprite2D
var using_anim_player: bool = false
var animator: Node
var is_falling: bool = false
var dir_h: bool = false # false = right, true = left
var hitboxes: Array[CollisionShape2D] = []
var weapon: CollisionShape2D
var current_animation: String
var is_attacking: bool = false

func _ready():		
	body = self.get_parent()
	assert(body != null, "Found no parent")
	
	var player
	for child in Globals.get_all_descendants(body):
		if child is AnimatedSprite2D:
			sprite = child
		if child is CollisionShape2D:
			hitboxes.append(child)
			if "weapon" in child.get_parent().name.to_lower():
				weapon = child
		if child is AnimationPlayer:
			player = child
			
	assert(sprite != null, "MovementComponent could not find an AnimatedSprite2D under the body: %s" % body)
	if player!=null:
		using_anim_player = true
		animator = player
		animator.animation_finished.connect(_on_animation_finished_anim)
	else:
		animator = sprite
		animator.animation_finished.connect(_on_animation_finished)

func _process(_delta):
	if not is_attacking:
		if not body.is_on_floor():
			# jumping or falling animation
			pass
		#elif left or right:
			#$SpriteAnimations.play("run")
		else:
			if not animator.is_playing():
				animator.play("idle", 0.5)
				current_animation = animator.current_animation if using_anim_player else animator.animation

func move_horizontal(direction: float) -> void:
	var flip: bool = false
	body.velocity.x = direction * speed # Move

	# Flip sprite in direction
	if direction > 0:
		if dir_h:
			flip = true
		else:
			flip = false
		dir_h = false
	elif direction < 0:
		if dir_h:
			flip = false
		else:
			flip = true
		dir_h = true
	else: # if 0, maintain last direction
		pass
	
	sprite.flip_h = dir_h
	for box in hitboxes: # Adjust hitbox for flip
		box.position.x *= -1 if flip else 1
		
	#if direction != 0:
		#sprite.play("run")
	#else:
		#sprite.play("idle")

func jump() -> void:
	if body.is_on_floor() and not airborne:
		body.velocity.y = jump_velocity
		airborne = true
	
	#if is_jumping:
		#sprite.play("jump")
	# optional: add falling animation
	#elif is_falling:
		#sprite.play("fall")

func _physics_process(delta):
	is_falling = true if body.velocity.y > 0 else false
	airborne = false if body.is_on_floor() else true

	# Gravity/falling physics
	if airborne:
		if is_falling: 
			body.velocity.y += gravity * (1.0 + float(falling_acceleration_percent)/100.0) * delta 
		else:
			body.velocity.y += gravity * delta 
	
	body.move_and_slide()

func attack() -> void:
	animator.play("attack", 1.0)
	current_animation = animator.current_animation if using_anim_player else animator.animation
	if !using_anim_player: # animation player will enable hitbox (and enable hurting)
		weapon.disabled = false
	is_attacking = true

func _on_animation_finished() -> void:
	if current_animation == "attack": 
		weapon.disabled = true
		is_attacking = false

func _on_animation_finished_anim(temp) -> void:
	if current_animation == "attack": 
		weapon.disabled = true
		is_attacking = false

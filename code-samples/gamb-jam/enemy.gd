extends CharacterBody2D

@export var target_groups: Array[String] = ["players"] 
@export var hurt_groups: Array[String] = ["players"]
@export var max_hp: int
@export var atk: int
var current_hp: int

func _ready():	
	self.visible = true
	assertions()
	for child in Globals.get_all_descendants(self):
		for group in self.get_groups():
			child.add_to_group(group)
	current_hp = max_hp

func _process(_delta):		
	if current_hp <= 0: 
		self.visible = false
		# TODO death handling
	$"Pathing/Pathfinder".get_next_path_position()
	
	## both left & right cancel out and no left and right stops horizontal movement
	#if (left and right) or (not left and not right):
		#$MovementComponent.move_horizontal(0)
	#elif left:
		#$MovementComponent.move_horizontal(-1)
	#elif right:
		#$MovementComponent.move_horizontal(1)
	#if jump:
		#$MovementComponent.jump()
	#if attack and not is_attacking:
		#$SpriteAnimations.play("attack", 1.5)
		#current_animation = $SpriteAnimations.animation
		#is_attacking = true
		#$MovementComponent.attack()
		 ## TODO hit detection
	#
	##if Input.is_action_pressed("move_down"):
	##if Input.is_action_pressed("move_up"):
	##if Input.is_action_pressed("right_click"):
	#
	#if not is_attacking:
		#if not is_on_floor():
			## jumping or falling animation
			#pass
		##elif left or right:
			##$SpriteAnimations.play("run")
		#else:
			#if not $SpriteAnimations.is_playing():
				#$SpriteAnimations.play("idle", 0.5)
				#current_animation = $SpriteAnimations.animation

func assertions() -> void:
	var has_sprite = false
	var has_movement = false
	var has_pathing = false
	
	for child in Globals.get_all_descendants(self):
		if child is AnimatedSprite2D:
			has_sprite = true
		if child is MovementComponent:
			has_movement = true
		if child is NavigationAgent2D:
			has_pathing = true
		if has_movement and has_sprite and has_pathing:
			break
	
	for group in target_groups:
		assert(ProjectSettings.get_setting("global_group/" + group)!=null, "Group \"%s\" does not exist" %group)
	for group in hurt_groups:
		assert(ProjectSettings.get_setting("global_group/" + group)!=null, "Group \"%s\" does not exist" %group)
	
	assert(has_sprite, "Enemies require an AnimatedSprite2D child.")
	assert(has_movement, "Enemies require a MovementComponent child.")
	assert(has_pathing, "Enemies require a NavigationAgent2D child.")

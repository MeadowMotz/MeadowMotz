extends CharacterBody2D

@export var hurt_groups: Array[String] = ["enemies"]
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

	# movement
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	var attack = Input.is_action_just_pressed("attack")
	
	# both left & right cancel out and no left and right stops horizontal movement
	if (left and right) or (not left and not right):
		$MovementComponent.move_horizontal(0)
	elif left:
		$MovementComponent.move_horizontal(-1)
	elif right:
		$MovementComponent.move_horizontal(1)
	if jump:
		$MovementComponent.jump()
	if attack:
		$MovementComponent.attack()
	if not left and not right and not jump and not attack:
		$MovementComponent.move_horizontal(0)
	#if Input.is_action_pressed("move_down"):
	#if Input.is_action_pressed("move_up"):
	#if Input.is_action_pressed("right_click"):

func assertions() -> void:
	var has_sprite = false
	var has_movement = false
	
	for child in get_children():
		if child is AnimatedSprite2D:
			has_sprite = true
		if child is MovementComponent:
			has_movement = true
		if has_movement and has_sprite:
			break
	
	for group in hurt_groups:
		assert(ProjectSettings.get_setting("global_group/" + group)!=null, "Group \"%s\" does not exist" %group)
	
	assert(has_sprite, "Players require an AnimatedSprite2D child.")
	assert(has_movement, "Players require a MovementComponent child.")

extends NavigationAgent2D

var target: Area2D = null
var body: CharacterBody2D

func _ready():
	$"../Vision".target_entity.connect(set_target)
	$"../Vision".untarget_entity.connect(remove_target)
	$PathCooldown.timeout.connect(on_timeout)
	body = self.get_parent().get_parent()
	assert(body!=null, "Could not find parent body")
	
	makepath()

func set_target(entity: Area2D) -> void:
	if entity != target:
		#print("DEBUG: Target acquired: %s" %entity)
		target = entity

func remove_target(entity: Area2D) -> void:
	if target == entity:
		target = null
		#print("DEBUG: Target removed: %s" %entity)
	else:
		push_warning(entity.to_string() + " is not the current target. Cannot untarget.")

# Pathing ----

func on_timeout() -> void:
	makepath()

func makepath() -> void:
	if target != null:
		target_position = target.global_position
		#print("DEBUG: pathing to %s" %target)
	else:
		#print("DEBUG: pathing idle")
		target_position = body.position
		# TODO idle pathing

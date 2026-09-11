extends Area2D

var hurt_groups: Array[String]
var body: CharacterBody2D
var atk: int
signal hurt(target: CharacterBody2D, damage: int)

func _ready():
	hurt_groups = self.get_parent().hurt_groups
	body = self.get_parent()
	atk = body.atk
	area_entered.connect(on_area_entered)

# Handling for hitbox intersection listener
func on_area_entered(entity: Area2D):
	#print("DEBUG: " + entity.to_string() + " entered this body")
	
	# Find character parent of Area2D entity
	var p = entity.get_parent()
	while p and not (p is CharacterBody2D):
		if p==null:
			push_warning("No character parent found for %s" %entity)
			break
		else:
			p = p.get_parent()
	
	# If can be hurt, create hurt event
	for group in hurt_groups:
		if entity.is_in_group(group):
			if p!=null:
				#print("DEBUG: Hurting %s" %p)
				hurt.emit(p, atk)
			break

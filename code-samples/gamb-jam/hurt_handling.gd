# Stage script that "dishes out damage"
extends Node2D

var hurtbox_script = preload("res://scenes/scripts/hurtbox.gd")
var enemie_hitboxes: Array[Area2D] = []
var enemiie_attack: Array[MovementComponent] = []

func _ready():
	# Listen for hurt events
	for child in Globals.get_all_descendants(self):
		if child.get_script() == hurtbox_script:
			child.hurt.connect(on_hurt)
	
	for child in get_children():
		if "enemy" in child.name.to_lower():
			for c in Globals.get_all_descendants(child):
				if c is Area2D and "target" in c.name.to_lower():
					enemie_hitboxes.append(c)
				if c is MovementComponent:
					enemiie_attack.append(c)

func on_hurt(entity: CharacterBody2D, damage: int):
	var current_hp = entity.current_hp
	var max_hp = entity.max_hp
	var new_hp: int = current_hp - damage
	#print("DEBUG: %s: %s/%s HP -> %s/%s HP" % [entity,current_hp,max_hp,new_hp,max_hp])
	entity.current_hp = new_hp

func _process(_delta):	
	if Input.is_action_pressed("escape"):
		get_tree().quit()

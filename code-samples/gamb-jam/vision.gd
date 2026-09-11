# vision field functionality for enemy targeting
extends Node2D

var target_groups: Array[String]
signal target_entity(entity: Area2D)
signal untarget_entity(entity: Area2D)

func _ready():
	target_groups = self.get_parent().get_parent().target_groups
		
	$TargetThreshold.area_entered.connect(seen)
	$FollowThreshold.area_exited.connect(unseen)

func seen(entity: Area2D):
	for group in target_groups:
		if entity.is_in_group(group):
			target_entity.emit(entity)
			break

func unseen(entity: Area2D):
	for group in target_groups:
		if entity.is_in_group(group):
			untarget_entity.emit(entity)
			break

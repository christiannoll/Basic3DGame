extends Area3D

@export var animationPlayer: AnimationPlayer
@export var anim_name: String
	
func trigger_entered(body):
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player"):
		animationPlayer.play(anim_name)
		monitoring = false

extends StaticBody3D

var object_counter

func _ready() -> void:
	object_counter = get_tree().current_scene.get_node("UI/object_counter")

func interact():
	get_parent().num_of_objects += 1
	get_tree().current_scene.get_node("Sounds/obj_pickup").play()
	object_counter.text = str(get_parent().num_of_objects) + "/3"
	if get_parent().num_of_objects >= 3:
		get_tree().current_scene.get_node("hallway_door/AnimationPlayer").play("open")
	queue_free()

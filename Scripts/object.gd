extends StaticBody3D

func interact():
	get_parent().num_of_objects += 1
	if get_parent().num_of_objects >= 3:
		pass
	queue_free()

extends CharacterBody3D

var SPEED = 4
var player
var caught = false
var distance: float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	player = get_node("/root/" + get_tree().current_scene.name + "/Player")
	
func _physics_process(delta: float) -> void:
	if visible:
		if not is_on_floor():
			velocity -= gravity * delta
		var current_location = global_transform.origin
		var next_location = $NavigationAgent3D.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized * SPEED
		$NavigationAgent3D.set_velocity(new_velocity)
		var look_dir = atan2(-velocity.y, -velocity.z)
		rotation.y = look_dir
		distance = player.global_transform.origin.distance_to(global_transform.origin) 

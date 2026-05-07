extends CharacterBody3D

var SPEED = 1
var jumpscareTime = 2
var player
var caught = false
var distance: float
@export var scene_name: String
@export var destinations: Array[Node3D]
var rng
var current_destination
var chasing = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var able_to_pick = false
@export var walk_footsteps: Array[AudioStream]
@export var sprint_footsteps: Array[AudioStream]

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	player = get_node("/root/" + get_tree().current_scene.name + "/Player")
	var rand_dest = rng.randi_range(0, destinations.size() - 1)
	current_destination = destinations[rand_dest]
	
func pick_new_destination():
	if chasing == false && able_to_pick == false && distance <= 1:
		able_to_pick = true
		SPEED = 0
		var wait_time = rng.randf_range(3.0, 10.0)
		await get_tree().create_timer(wait_time, false).timeout
		if distance <= 1:
			var rand_dest = rng.randi_range(0, destinations.size() - 1)
			print(str(rand_dest))
			SPEED = 1
			current_destination = destinations[rand_dest]
		able_to_pick = false
	
func _process(delta: float) -> void:
	if chasing == true && !$chase_music.playing:
		$chase_music.play()
	if chasing == false && $chase_music.playing:
		$chase_music.stop() 
	if chasing == false && SPEED > 0:
		if !$footsteps.playing:
			var num = rng.randi_range(0, walk_footsteps.size() - 1)
			$footsteps.stream = walk_footsteps[num]
			$footsteps.play()	
		distance = current_destination.global_transform.origin.distance_to(global_transform.origin)
		update_target_location(current_destination.global_transform.origin)
	if chasing == true && SPEED > 0:
		if !$footsteps.playing:
			var num = rng.randi_range(0, sprint_footsteps.size() - 1)
			$footsteps.stream = sprint_footsteps[num]
			$footsteps.play()
		distance = player.global_transform.origin.distance_to(global_transform.origin)
		update_target_location(player.global_transform.origin)
	
func _physics_process(delta: float) -> void:
	if visible:
		if not is_on_floor():
			velocity.y -= gravity * delta
		var current_location = global_transform.origin
		var next_location = $NavigationAgent3D.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		$NavigationAgent3D.set_velocity(new_velocity)
		var look_dir = atan2(-velocity.x, -velocity.z)
		rotation.y = look_dir
		if chasing == true:
			if distance <= 2 && caught == false:
				player.visible = false
				if !$jumpscare.playing:
					$jumpscare.play()
				SPEED = 0
				caught = true
				$jumpscare_camera.current = true
				await get_tree().create_timer(jumpscareTime, false).timeout
				get_tree().change_scene_to_file("res://Scenes/" + scene_name + ".tscn")
			
func update_target_location(target_location):
	$NavigationAgent3D.target_position = target_location
	
func on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()

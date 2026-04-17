extends Node3D

@export var min_time: float
@export var max_time: float
@export var min_flash_time: float
@export var max_flash_time: float
var loop = true

func _process(delta: float) -> void:
	if loop:
		loop = false
		var rng = RandomNumberGenerator.new()
		var rand = rng.randf_range(min_time, max_time)
		await get_tree().create_timer(rand, false).timeout
		pass
		

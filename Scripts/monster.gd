extends CharacterBody3D

var SPEED = 4
var player
var caught = false
var distance: float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

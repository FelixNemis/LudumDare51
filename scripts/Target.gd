tool
extends StaticBody

# warning-ignore:unused_signal
signal hit

export var is_red: = true setget set_red

var on: = true
var scorable: = true

var red_matt = preload("res://assets/textures/RedSquares.tres")
var red_matt_off = preload("res://assets/textures/RedSquaresOff.tres")
var blue_matt = preload("res://assets/textures/BlueScales.tres")
var blue_matt_off = preload("res://assets/textures/BlueScalesOff.tres")

var red_particles = preload("res://scenes/TargetRedParticle.tscn")
var blue_particles = preload("res://scenes/TargetBlueParticle.tscn")

export(int) var points = 20

func set_red(value):
	is_red = value
	if Engine.editor_hint:
		clock_tick(true)

func _ready():
	clock_tick(true)

func clock_tick(is_blue: bool) -> void:
	if Engine.editor_hint:
		if is_red:
			$MeshInstance.material_override = red_matt
		else:
			$MeshInstance.material_override = blue_matt
		return
	if is_red:
		if is_blue:
			$MeshInstance.material_override = red_matt_off
			on = false
		else:
			$MeshInstance.material_override = red_matt
			on = true
	else:
		if is_blue:
			$MeshInstance.material_override = blue_matt
			on = true
		else:
			$MeshInstance.material_override = blue_matt_off
			on = false
	scorable = on

func hit() -> void:
	if on:
		var particles
		if is_red:
			particles = red_particles.instance()
		else:
			particles = blue_particles.instance()
		get_parent().add_child(particles)
		particles.emitting = true
		particles.global_transform = global_transform
		queue_free()

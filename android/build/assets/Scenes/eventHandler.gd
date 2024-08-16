extends Node3D

var running = false
var frames = 5

@export var intensity = 3

var vocal
var bass
var spreadUp = false

# BPM 138.6

var interface : MobileVRInterface

func _ready() -> void:
	interface = XRServer.find_interface("OVRMobile")
	get_viewport().use_xr = true
	if interface and interface.is_initialized():
		print("yipee")
		


func _process(delta):
	
	var spectrum = AudioServer.get_bus_effect_instance(0,0)
	vocal = ((spectrum.get_magnitude_for_frequency_range(400,3000).x + spectrum.get_magnitude_for_frequency_range(400,3000).y)/2)/1.2
	bass = ((spectrum.get_magnitude_for_frequency_range(120,300).x + spectrum.get_magnitude_for_frequency_range(120,300).y)/2)/1.2
	$purpleSpin.rotate_y(vocal*delta*12*intensity)
	$particle.draw_pass_1.material.emission_energy_multiplier = bass*14*intensity
	$particle.process_material.gravity = Vector3(bass*intensity*2,bass*intensity*2,bass*intensity*2)
	$blueSpin.rotate_y(bass*delta*12*intensity)
	$arch3.rotate_z(bass*delta*6*intensity)
	$arch4.rotate_z(-bass*delta*6*intensity)
	$arch5.rotate_z(vocal*delta*6*intensity)
	$arch.rotate_z(vocal*delta*2*intensity)
	$arch2.rotate_z(-vocal*delta*2*intensity)
	$glowBars.rotate_z(bass*delta*24*intensity)
	$glowBars2.rotate_z(-bass*delta*24*intensity)
func _physics_process(delta):
	frames += 1
	if frames >= 30:
		running = true


func _on_bpm_timer_timeout():
	running = true

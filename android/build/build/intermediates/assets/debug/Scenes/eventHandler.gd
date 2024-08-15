extends Node3D

var running = false
var frames = 10

@export var intensity = 1.5

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
	vocal = ((spectrum.get_magnitude_for_frequency_range(300,4000).x + spectrum.get_magnitude_for_frequency_range(300,4000).y)/2)/1.2
	bass = ((spectrum.get_magnitude_for_frequency_range(50,200).x + spectrum.get_magnitude_for_frequency_range(50,200).y)/2)/1.2
	$player/XROrigin3D/camera.environment.fog_light_color = Color(lerp($player/XROrigin3D/camera.environment.fog_light_color.r,vocal*intensity/4,0.2),0,lerp($player/XROrigin3D/camera.environment.fog_light_color.b,bass*intensity/8,0.2))
	$purpleSpin.rotate_y(vocal*delta*12*intensity)
	$spinAbovePurple.rotate_y(-vocal*delta*12*intensity)
	$blueSpin.rotate_y(bass*delta*12*intensity)
	$spinAboveBlue.rotate_y(-bass*delta*12*intensity)
	$player/XROrigin3D/camera.environment.glow_intensity = lerp(clamp(vocal+bass,0.2,1.4),$player/XROrigin3D/camera.environment.glow_intensity,0.1)
	if spreadUp: 
		$spread1.rotate_x(-bass*delta*4*intensity)
		if $spread1.rotation_degrees.x <= -30: spreadUp = false
	elif not spreadUp:
		$spread1.rotate_x(bass*delta*4*intensity)
		if $spread1.rotation_degrees.x > 30: spreadUp = true
func _physics_process(delta):
	
	if running:
		frames -= 1
		#$purpleSpin.rotate_y(vocal)
		#$blueSpin.rotate_y(bass)
		if frames < 1:
			running = false
			frames = 10


func _on_bpm_timer_timeout():
	running = true

extends Node3D

var running = false
var frames = 10

var vocal
var bass

# BPM 138.6

func _ready():
	pass


func _process(delta):
	var spectrum = AudioServer.get_bus_effect_instance(0,0)
	# print((spectrum.get_magnitude_for_frequency_range(0,100).x + spectrum.get_magnitude_for_frequency_range(0,100).y)/2)
	vocal = ((spectrum.get_magnitude_for_frequency_range(300,3000).x + spectrum.get_magnitude_for_frequency_range(300,5000).y)/2)/1.2
	bass = ((spectrum.get_magnitude_for_frequency_range(0,300).x + spectrum.get_magnitude_for_frequency_range(0,300).y)/2)/1.2
	$player/neck/camera.environment.fog_light_color = Color(lerp($player/neck/camera.environment.fog_light_color.r,vocal,1),0,lerp($player/neck/camera.environment.fog_light_color.b,bass/2,1))
func _physics_process(delta):
	if running:
		frames -= 1
		$purpleSpin.rotate_y(0.1)
		$blueSpin.rotate_y(-0.05)
		if frames < 1:
			running = false
			frames = 10


func _on_bpm_timer_timeout():
	running = true

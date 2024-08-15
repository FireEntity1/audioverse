extends Node3D

var running = false
var frames = 10

# BPM 138.6

func _ready():
	pass


func _process(delta):
	print(AudioServer.get_bus_volume_db(0))

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

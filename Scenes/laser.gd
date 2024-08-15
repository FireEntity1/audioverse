extends Node3D
 
var distance
	
func _process(delta):
	if $raycast.get_collider(): 
		distance = transform.origin.distance_to($RayCast.get_collision_point())
		$scaler.scale.z = distance
		

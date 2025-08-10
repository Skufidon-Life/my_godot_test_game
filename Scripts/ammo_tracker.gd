extends Node

class_name  AmmoTracker


enum ammo_type {bullet, small_bullet}

var ammo := {
	ammo_type.bullet: 30, 
	ammo_type.small_bullet: 10
}

func has_ammo(type: ammo_type) -> bool:
	return ammo[type] > 0
		
	
func use_ammo(type: ammo_type):
	ammo[type] -= 1
	#print(ammo[type])

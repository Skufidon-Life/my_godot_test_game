extends Node3D

@export var weapon_1: Node3D
@export var weapon_2: Node3D

func eqip(active_weapon:Node3D):
	for x in get_children():
		if x == active_weapon:
			x.visible = true
			x.set_process(true)
		else:
			x.visible = false
			x.set_process(false)
		
		
		
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("weapon1"):
		eqip(weapon_1)
	if Input.is_action_just_pressed("weapon2"):
		eqip(weapon_2)
	if Input.is_action_just_pressed("next_weapon"):
		next_weapon()



func next_weapon():
	var index = get_current_index()
	index = wrapi(index + 1, 0 , get_child_count())
	eqip(get_child(index))
	
	
func get_current_index() -> int:
	for index in get_child_count():
		if get_child(index).visible:
			return index
	return 0
			

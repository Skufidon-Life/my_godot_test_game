extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var player
var is_provoked: bool = false
var attack_range := 1.5
var agro_range:= 15.0


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(delta: float) -> void:
	navigation_agent_3d.target_position = player.global_position
	var next_postion = navigation_agent_3d.get_next_path_position()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	var direction = global_position.direction_to(next_postion)
	var distance = global_position.distance_to(player.global_position)
	
	if distance < agro_range:
		is_provoked = true
		
	if is_provoked:
		if distance <= attack_range:
			attack()
			
		if direction:
			look_at_target(direction)
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()


func look_at_target(direction):
	var adjusted_direction = direction
	adjusted_direction.y = 0 
	look_at(adjusted_direction + global_position, Vector3.UP, true)
	
func attack():
	print(1)

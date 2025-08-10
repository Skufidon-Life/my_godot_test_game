extends Node3D

@export var firerate: int
@export var recoil:= 0.05
@export var weapon_damage: int
@export var weapon_mesh: Node3D
var weapon_position: Vector3
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var muzzleflash: GPUParticles3D = $Muzzleflash
@onready var timer: Timer = $Timer
@export var hit_spark: PackedScene
@export var automatick: bool
@export var ammo_tracker: AmmoTracker
@export var bullet_type: AmmoTracker.ammo_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_position = weapon_mesh.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if automatick == true:
		if Input.is_action_pressed("fire"):
			if timer.is_stopped():
				shoot()
	else:
		if Input.is_action_just_pressed("fire"):
			if timer.is_stopped():
				shoot()
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)
	

func shoot():
	if ammo_tracker.has_ammo(bullet_type):
		ammo_tracker.use_ammo(bullet_type)
		muzzleflash.restart()
		timer.start(1.0 / firerate)
		weapon_mesh.position.z += recoil
		var collider = ray_cast_3d.get_collider()
		if collider is Enemy:
			collider.health -= weapon_damage
			
		var spark = hit_spark.instantiate()
		add_child(spark)
		spark.global_position = ray_cast_3d.get_collision_point()
		print(collider)

extends Spatial

export (PackedScene) var basic_bullet = preload("res://Player/Weapons/BasicBullet.tscn")
onready var bullet_container = $BulletContainer

var ground_size = Vector2(40,40)

var next_chunk_coord = Vector3(0,0,0)
onready var map = $World/Ground
onready var player = $Path/Dolly/PlayerShip

onready var guide = $Path/Dolly/PositionGuide
#onready camera = $Path/Dolly/Camera

var dolly_speed = 50
var strafe_speed = 100

var basic_enemy = preload("res://Enemies/BasicEnemy.tscn")
onready var enemy_container = $EnemyContainer

var SpawnEnemy

func _ready():
	create_chunk(ground_size.x, ground_size.y)
	SpawnEnemy = Timer.new()
	add_child(SpawnEnemy)
	SpawnEnemy.set_wait_time(2)
	SpawnEnemy.connect("timeout", self, "_on_SpawnEnemy_timeout")
	SpawnEnemy.start()
	

func _physics_process(delta):
	var next_trigger = (next_chunk_coord.z * 10) - (ground_size.y * 10)
	#var next_trigger = (next_chunk_coord.z) - (ground_size.y)
	if player.translation.z > next_trigger:
		create_chunk(ground_size.x, ground_size.y)
		
func create_chunk(chunk_width, chunk_length):
	for x in chunk_width:
		for z in chunk_length:
				var a = (randi() % 2)
				map.set_cell_item(x, 0, z + next_chunk_coord.z + 1, a)		
	next_chunk_coord.z += chunk_length
	
func _fire_bullet(trans):
	var a = basic_bullet.instance()
	a.global_transform = trans
	bullet_container.add_child(a)


func _on_SpawnEnemy_timeout():
	var a = basic_enemy.instance()
	var num_x = rand_range(0.0, ground_size.x)
	var num_z = rand_range(-5.0, 5.0)
	a.transform.origin = Vector3(next_chunk_coord.x + num_x, next_chunk_coord.y + 5, next_chunk_coord.z + num_z) * 10
	enemy_container.add_child(a)
	

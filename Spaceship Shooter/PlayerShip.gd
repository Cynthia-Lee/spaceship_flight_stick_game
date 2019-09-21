extends KinematicBody

signal fire_bullet

var ready_to_shoot = true

# make ship lean
var turn_right = false
var turn_left = false

var rot_x = 0.0
var rot_y = 180.0
var rot_z = 0.0

var velocity = Vector3()

onready var movement_guide = $MovementGuide

var turn_speed = 35
var speed = 100 # movement speed
# 140

func _ready():
	for node in get_tree().get_nodes_in_group("game"):
		connect("fire_bullet", node, "_fire_bullet")

func _physics_process(delta):
	get_input(delta)
	if turn_right:
		rot_z -= 0.5
	elif rot_z < 0:
		rot_z += 0.5
	if turn_left:
		rot_z += 0.5
	elif rot_z > 0:
		rot_z -= 0.5
		
	rot_z = clamp(rot_z, -25.0, 25)
	
	# rotation_degrees.x = rot_x
	# rotation_degrees.y = rot_y
	# rotation_degrees.z = rot_z
	translate(-movement_guide.transform.basis.z * speed * delta)
	
	$CameraRig.rotation_degrees.z = -rot_z
	
	velocity = move_and_slide(velocity, Vector3.UP)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
# func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input(delta):
	velocity = Vector3()
	if Input.is_action_pressed("up"):
		# rotate_x(delta)
		rot_x += turn_speed * delta
		# velocity += -transform.basis.z * speed
		
	if Input.is_action_pressed("down"):
		# rotate_x(-delta)
		rot_x += -turn_speed * delta
		# velocity += transform.basis.z * speed
		
	if Input.is_action_pressed("right"):
		# shift right
		# translate(transform.basis.x * speed * delta)
		# Strafe
		# rot_y += -turn_speed * delta
		velocity += -movement_guide.transform.basis.x * speed / 2
		
		turn_right = true
	elif rot_z < 0.0: # make ship level out
		turn_right = false
		# rotate_y(-delta)
		
	if Input.is_action_pressed("left"):
		# shift left
		# translate(-transform.basis.x * speed * delta)
		# rot_y += turn_speed * delta
		
		# Strafe
		# rotate_y(delta)
		velocity += movement_guide.transform.basis.x * speed / 2
		
		turn_left = true
	elif rot_z > 0.0:
		turn_left = false
		
	rotation_degrees.x = rot_x
	rotation_degrees.y = rot_y
	rotation_degrees.z = rot_z
	
	# shoot
	if Input.is_action_pressed("shoot"):
		if ready_to_shoot:
			ready_to_shoot = false
			$GunContainer/GunTimer.start()
			# Tell Root node where to add bullets
			var trans = $GunContainer/MuzzleLeft.global_transform
			emit_signal("fire_bullet", trans)
			trans = $GunContainer/MuzzleRight.global_transform
			emit_signal("fire_bullet", trans)

func _on_GunTimer_timeout():
	ready_to_shoot = true

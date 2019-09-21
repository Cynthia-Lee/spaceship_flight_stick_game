extends Area
var bullet_speed = 900 # :3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	

func _physics_process(delta):
	translate(transform.basis.z * bullet_speed * delta)
	
func _on_BasicBullet_body_entered(body):
	if body.is_in_group('enemy'):
		body.queue_free()
	queue_free()

extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# creates a new 2d vector (X,Y) with both values = 0
var velocity = Vector2.ZERO

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# Called when the node enters the scene tree for the first time.
onready var animationPlayer = $AnimationPlayer
#func _ready():
#	print("Node Ready!")	

# Called every frame
func _physics_process(delta):
	# delta = frame rate (or the time the last frame took to process)
	# it is usually 1/60 as normal monitors runs at 60 frames per second
	# but it can very if the game lags (so adding delta to the equasion corrects this)
	# so when you have something that changes over time (or frame), you multiply it by delta
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# corrects diagonal movements to unit lenght
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationPlayer.play("RunRight")
		else:
			animationPlayer.play("RunLeft")	
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
#		velocity += input_vector * ACCELERATION * delta
#		velocity = velocity.clamped(MAX_SPEED)
	else:
		animationPlayer.play("IdleRight")		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	# for better collision to walls, we use move_and_slide instead of move_and_collide
	# if you read the docs, you will see that we should not multiply the velocity by delta
	velocity = move_and_slide(velocity) 
#	move_and_collide(velocity * delta)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

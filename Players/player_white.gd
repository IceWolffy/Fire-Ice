extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D1
@onready var double_jump_trail = $DoubleJumpTrail  # Ensure this path is correct

var can_double_jump = false
var is_double_jumping = false

func _ready():
	# Initially hide the trail
	double_jump_trail.emitting = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true  # Reset double jump ability when on the floor
		is_double_jumping = false  # Reset double jump state

	# Handle jump.
	if Input.is_action_just_pressed("jump-a"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false  # Disable double jump after using it
			is_double_jumping = true  # Set double jump state

			# Emit the double jump trail effect
			double_jump_trail.emitting = true

	# Stop emitting the trail if the particles are done emitting
	if double_jump_trail.one_shot and double_jump_trail.emitting and double_jump_trail.get_particles_remaining() == 0:
		double_jump_trail.emitting = false

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("left", "right")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle1")
		else:
			animated_sprite.play("walk1")
	else:
		animated_sprite.play("jump1")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

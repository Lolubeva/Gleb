extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 100
const FRICTION = 0.25
const GRAVITY = 300
const JUMP_FORSCE = 200
const AIR_RESISTANCE = 0.02
onready var animation = $AnimatedSprite

var is_dead = false
var motion = Vector2.ZERO
var c = 0


func die():
	animation.play("d")
	$CollisionShape2D.set_deferred("c", true)
	$DeadCollision.set_deferred("c", false)
	is_dead = true
	
	
	
func _physics_process(delta):
	
	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if is_dead:
		return
	if x_input != 0:
		animation.play("run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		animation.flip_h =  x_input < 0 
	else:
		animation.play("Idle")
		
	motion = move_and_slide(motion, Vector2.UP)
	motion.y += GRAVITY * delta
	if Input.get_action_strength("ui_down"):
		animation.play("d")
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORSCE
	else:
		if Input.is_action_just_pressed("ui_up") and motion.y < -JUMP_FORSCE/2:
			motion.y = JUMP_FORSCE/2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
		
	




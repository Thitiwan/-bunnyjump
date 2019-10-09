extends KinematicBody2D

var motion = Vector2(0,100)

export var gravity = 10
export var speed = 500
export var jump_power = 500
var jump_count = 0
func _physics_process(delta):
	
	apply_gravity()
	jump()
	walk()
	update_animation()
		
	move_and_slide(motion, Vector2(0, -1 ))
	
func apply_gravity():
	if is_on_floor():
		motion.y = 0
		$AnimatedSprite.play("stand")
	else:
		motion.y = motion.y + gravity


func jump():
	if jump_count <1:
		if Input.is_action_just_pressed("jump"):
			motion.y = -jump_power
			jump_count = jump_count + 1
			$AudioStreamPlayer.play()

	if is_on_floor():
		jump_count = 0

func walk():
	if Input.is_action_pressed("left"):
		motion.x = -speed
	elif Input.is_action_pressed("right"):
		motion.x = +speed
	else:
		motion.x = 0

func update_animation():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif motion.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("stand")
		
func is_dead():
	
	if position.y > 1900:
		return true
		
	return false
	


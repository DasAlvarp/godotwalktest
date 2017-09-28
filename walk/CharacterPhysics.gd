extends Node2D

const MAX_SPEED = 100
const WALK_SPEED = 10
const FRICTION = 1
const WEIGHT = 250.0

var vertVelocity = 0.0
var acceleration = 0.0
var jumpSpeed = 800.0

var horVelocity = 0.0
var debug = true
var state = 0
var statelock = 0

var phyBox
var ground
var sprite
var height

# Initialization here
func _ready():
	phyBox = get_node("./Def/GrabHurtbox")
	ground = get_node("../Floor")
	sprite = get_node("./Def")
	height = (phyBox.get_region_rect().size.y + phyBox.get_offset().y + phyBox.get_region_rect().pos.y) * get_node("./Def").get_scale().y
	get_node(".").set_pos(Vector2(get_node(".").get_pos().x, ground.get_pos().y - height / 2))
	set_process(true)

#shitty "do the things" function b/c this is a lazy program to test how I want things to interact
func _process(delta):
	if(state == 0 || state == 1):
		sprite.set_texture(load("res://stick1.tex"))
	elif(state == 2):
		sprite.set_texture(load("res://stick2.tex"))
	elif(state == 3):
		sprite.set_texture(load("res://stick3.tex"))
	elif(state == 4):
		sprite.set_texture(load("res://stick4.tex"))
		
	if(statelock > 0):
		statelock -= 1
	
	var pos = get_node(".").get_pos()
	if(statelock == 0):
		if(state == 0):
			if(Input.is_action_pressed("move_left")):
				horVelocity = -WALK_SPEED
			if(Input.is_action_pressed("move_right")):
				horVelocity = WALK_SPEED
			if(Input.is_action_pressed("move_jump")):
				vertVelocity = jumpSpeed
				state = 1
			if(Input.is_action_pressed("attack_a")):
				statelock = 5
				state = 2
		elif(state == 2):
			state = 3
			statelock = 2
		elif(state == 3):
			state = 4
			statelock = 2
		elif(state == 4):
			state = 0
	
	if(state == 0):
		if(horVelocity > 0):
			horVelocity -= FRICTION
		elif(horVelocity < 0):
			horVelocity += FRICTION

	pos.x += horVelocity
	if(state == 1):
		pos.y -= vertVelocity / 60
		acceleration += WEIGHT / 60
		vertVelocity -= acceleration * acceleration / 60
		if(pos.y + height / 2 > ground.get_pos().y):
			state = 0
			acceleration = 0.0
			vertVelocity = 0.0
			pos.y = ground.get_pos().y - height / 2
	
	get_node(".").set_pos(pos)
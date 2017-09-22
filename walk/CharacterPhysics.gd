extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MAX_SPEED = 100
const WALK_SPEED = 10
const FRICTION = 1
const WEIGHT = 250.0

var vertVelocity = 0.0
var acceleration = 0.0
var jumpSpeed = 600.0

var horVelocity = 0.0
var debug = true
var state = 0
var statelock = 0

var phyBox
var ground

var height


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	phyBox = get_node("Def/GrabHurtbox")
	ground = get_node("../Floor")
	height = (phyBox.get_region_rect().size.y + phyBox.get_offset().y + phyBox.get_region_rect().pos.y) * get_node("Def").get_scale().y
	get_node(".").set_pos(Vector2(100, ground.get_pos().y - height / 2))
	set_process(true)

func _process(delta):
	var pos = get_node(".").get_pos()
	if(statelock == 0 && state == 0):
		if(Input.is_action_pressed("move_left")):
			horVelocity = -WALK_SPEED
		if(Input.is_action_pressed("move_right")):
			horVelocity = WALK_SPEED
		if(Input.is_action_pressed("move_jump")):
			vertVelocity = jumpSpeed
			state = 1

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
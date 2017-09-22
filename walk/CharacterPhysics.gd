extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MAX_SPEED = 100
const WALK_SPEED = 10
const FLOORY = 322
const WEIGHT = 250.0

var vertVelocity = 0.0
var acceleration = 0.0
var jumpSpeed = 600.0

var debug = true
var state = 0
var statelock = 0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node(".").set_pos(Vector2(100, FLOORY))
	set_process(true)

func _process(delta):
	var pos = get_node(".").get_pos()
	if(statelock == 0 && state == 0):
		if(Input.is_action_pressed("move_left")):
			pos.x -= WALK_SPEED
		if(Input.is_action_pressed("move_right")):
			pos.x += WALK_SPEED
		if(Input.is_action_pressed("move_jump")):
			vertVelocity = jumpSpeed
			state = 1
			acceleration = 0.0;
	
	if(state == 1):
		pos.y -= vertVelocity / 60
		acceleration += WEIGHT / 60
		vertVelocity -= acceleration * acceleration / 60
		if(pos.y > FLOORY):
			state = 0
			acceleration = 0.0
			vertVelocity = 0.0
			pos.y = FLOORY
	
	get_node(".").set_pos(pos)
extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MAX_SPEED = 100
const WALK_SPEED = 10
var velocity = 0
var weight = 1

var debug = true


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_process(true)

func _process(delta):
	var pos = get_node(".").get_pos()
	
	if(Input.is_action_pressed("move_left")):
		pos.x -= WALK_SPEED
	if(Input.is_action_pressed("move_right")):
		pos.x += WALK_SPEED
	
	get_node(".").set_pos(pos)
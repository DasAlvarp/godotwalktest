extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	var pos = get_node("Control/Char").get_pos()
	get_node("Control/PosInfo").set_text(str(pos.x) + ", " + str(pos.y))

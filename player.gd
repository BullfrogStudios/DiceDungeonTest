extends CharacterBody2D

#playerstate
const STUNNED = false
const DIRECTIONLOCK = false
func StunPlayer(Seconds:int):
	print("hello")
#movement
const SPEED = 150
const SPRINTMULTIPLIER = 1.5

#actionhandler
@onready var action_handler: Node2D = $ActionHandler
@onready var indicator: Sprite2D = $ActionHandler/Indicator

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	#movement
	velocity = Input.get_vector("a","d","w","s") * SPEED
	move_and_slide()
	
	#actionhandler
	action_handler.look_at(get_global_mouse_position())

extends CharacterBody2D

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

#playerstate
var STUNNED = false
var DIRECTIONLOCK = false
func Roll():
	DIRECTIONLOCK = true
	ROLLSPEED = 3.4
	await wait(0.2)
	DIRECTIONLOCK = false
	ROLLSPEED = 1
	StunPlayer(0.5)
	
func StunPlayer(Seconds:int):
	STUNNED = true
	await wait(Seconds)
	STUNNED = false
var direction = Vector2(0,0)
var ROLLSPEED = 1
const SPEED = 150
const SPRINTMULTIPLIER = 1.5

#actionhandler
var actioncooldown = 0
func ActCDInitiate(seconds: int):
	actioncooldown = seconds
	await wait(seconds)
	actioncooldown = 0

@onready var action_handler: Node2D = $ActionHandler
@onready var indicator: Sprite2D = $ActionHandler/Indicator

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	#movement
	if Input.is_action_just_pressed("Spacebar"):
		if DIRECTIONLOCK == false and STUNNED == false and actioncooldown == 0:
			Roll()
	
	if DIRECTIONLOCK == false:
		direction = Input.get_vector("a","d","w","s")
	if STUNNED == true:
		direction = Vector2(0,0)
	
	velocity = direction * SPEED * ROLLSPEED
	move_and_slide()
	
	#actionhandler
	action_handler.look_at(get_global_mouse_position())
	
	
#movement func

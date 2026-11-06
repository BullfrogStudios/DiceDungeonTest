extends CharacterBody2D

const SPEED = 150


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	velocity = Input.get_vector("a","d","w","s") * SPEED
	
	move_and_slide()

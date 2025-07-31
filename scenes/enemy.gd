extends CharacterBody2D
class_name Enemy

const SPEED = 50.0


func _physics_process(delta: float) -> void:
    var player = get_tree().get_first_node_in_group("player")
    
    velocity = position.direction_to(player.position) * SPEED
    
    move_and_slide()

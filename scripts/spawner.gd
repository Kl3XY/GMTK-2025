extends Path2D

@export var enemies: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    
    
    if get_tree().get_node_count_in_group("enemies") >= 64:
        return
    
    if randi_range(0, 100) > 50:
        return
        
    var point: Vector2 = self.curve.samplef(randf() * 4) + get_parent().position
    
    var enemy: Node2D = enemies.pick_random().instantiate() 
    
    enemy.position = point

    enemy.add_to_group("enemies")

    get_parent().get_parent().add_child(
        enemy
    )
    

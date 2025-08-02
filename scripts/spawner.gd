extends Path2D

@export var enemies: Array[PackedScene]

var difficulty = 2.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()  



func _on_difficulty_increaser_timeout() -> void:
    difficulty += 1;

func _on_spawn_timer_timeout() -> void:
    $SpawnTimer.wait_time = max(2 - difficulty / 100, 0.05);
    print("Spawn Time: " + str(max(2 - difficulty / 100, 0.05)))
    print("difficulty: " + str(difficulty))
    print("red time: " + str(difficulty / 100))
    $SpawnTimer.start()
    if get_tree().get_node_count_in_group("enemies") >= 128:
        return

    var point: Vector2 = self.curve.samplef(randf() * 4) + get_parent().position
    
    var enemy: Node2D = enemies.pick_random().instantiate() 
    
    enemy.position = point

    enemy.add_to_group("enemies")

    get_parent().get_parent().add_child(
        enemy
    )

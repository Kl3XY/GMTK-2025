extends Path2D

@export var enemies: Array[SceneWeight]

var rng = RandomNumberGenerator.new();
var difficulty = 2.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()  

func get_enemy() -> PackedScene:
    rng.randomize();
    
    var weighted_sum = 0;
    
    for n in enemies:
        weighted_sum += n.weight;
    
    var chosen_weight = rng.randi_range(0, weighted_sum)
    
    for entry in enemies:
        if chosen_weight <= entry.weight:
            if entry != null:
                return entry.scene;
            else:
                return null;
        chosen_weight -= entry.weight;
    
    return null;


func _on_difficulty_increaser_timeout() -> void:
    difficulty += 1;

func _on_spawn_timer_timeout() -> void:
    #$SpawnTimer.wait_time = max(2 - difficulty / 100, 0.001);
    $SpawnTimer.start()
    
    if get_tree().get_node_count_in_group("enemies") >= 512:
        return

    var point: Vector2 = self.curve.samplef(randf() * 4) + get_parent().position
    
    var enemy: Node2D = get_enemy().instantiate();

    enemy.difficulty = difficulty;
    
    enemy.position = point

    enemy.add_to_group("enemies")

    get_parent().get_parent().add_child(
        enemy
    )

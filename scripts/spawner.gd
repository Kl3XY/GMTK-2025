extends Path2D

@export var enemies: Array[SceneWeight]
var DIFFICULTY = preload("res://Difficulty/difficulty.tres")
var rng = RandomNumberGenerator.new();

var enemyList: Array[Node2D] = [];

func preload_enemy_list(amount: int):
    print("PRELOADING ENEMIES");
    for n in range(amount):
        enemyList.append(get_enemy().instantiate())

func retrieve_enemy() -> Node2D:
    return enemyList.pop_front();

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
    DIFFICULTY.difficulty += 1;

func _on_spawn_timer_timeout() -> void:
    if enemyList.is_empty():
        preload_enemy_list(5000);
    
    $SpawnTimer.wait_time = max(2 - DIFFICULTY.difficulty / 100, 0.001);
    $SpawnTimer.start()

    var point: Vector2 = self.curve.samplef(randf() * 4) + get_parent().position
    
    var enemy: Node2D = retrieve_enemy();

    enemy.difficulty = DIFFICULTY.difficulty;
    
    enemy.position = point

    enemy.add_to_group("enemies")

    get_parent().get_parent().add_child(
        enemy
    )

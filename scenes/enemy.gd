extends Enemy

const GEM = preload("res://scenes/Gems/Gem.tscn")
const DAMAGE_NUMBER_POOL = preload("res://Pools/damageNumberPool.tres")
var difficulty = 0;
const SPEED = 50.0
const DAMAGE_NUMBER = preload("res://scenes/UI/DamageNumber.tscn")
const XP_ORB = preload("res://scenes/XPOrbs/XPOrb.tscn")
signal TookDamage(damage: int, damage_from: CharacterBody2D)
var PLAYER_ENEMIES_KILLED = preload("res://Statistics/Statistics/Stats/Resources/player_enemies_killed.tres")
var DIFFICULTY = preload("res://Difficulty/difficulty.tres")
func _ready():
    $HealthComponent.Max_Health += difficulty / 3;
    $HealthComponent.Health = $HealthComponent.Max_Health;

func _process(delta: float) -> void:
    _enemy_physics_process(delta);

func _enemy_physics_process(delta: float):
    var player = get_tree().get_first_node_in_group("player")
    
    velocity = position.direction_to(player.position) * SPEED
    
    move_and_slide()

func _on_took_damage(damage: int, damage_from: CharacterBody2D) -> void:
    if self.is_queued_for_deletion():
        return
    
    if $Timer.time_left == 0.0:
        if get_tree().get_node_count_in_group("damage_numbers") < 32:
            var dmgNumInst = DAMAGE_NUMBER_POOL.retrieve();
            dmgNumInst.position.y -= 8;
            dmgNumInst.damage = damage;
            add_child(dmgNumInst);
            
            if damage > $HealthComponent.Health:
                dmgNumInst.reparent(get_tree().current_scene)
            
        $HealthComponent.Health -= damage;
        
        if damage_from != null:
            position += damage_from.position.direction_to(global_position) * 15
        $Timer.start();

func _on_health_component_health_depleted() -> void:
    PLAYER_ENEMIES_KILLED.enemies_killed += 1;

    if DIFFICULTY.difficulty > 200 :
        var ran = randi_range(0, 100)
        if randi_range(0, 100) <= 40:
            var inst = XP_ORB.instantiate();
            inst.position = global_position;
            inst.xp_amount = 100;
            inst.scale = Vector2(2, 2)
            get_tree().current_scene.call_deferred("add_child", inst);
    else:
        var inst = XP_ORB.instantiate();
        inst.position = position;
        get_tree().current_scene.call_deferred("add_child", inst);
    
    if randi_range(0, 1000) <= 20:
        var inst = GEM.instantiate();
        inst.position = global_position;
        get_tree().current_scene.add_child(inst);
    
    call_deferred("queue_free")


func _on_health_component_health_changed(Health: float) -> void:
    var health = $HealthComponent;
    if health.Health != health.Max_Health:
        $TextureProgressBar.visible = true;
    
    var perc = (health.Health / health.Max_Health) * 100;
    $TextureProgressBar.value = perc;


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        body.TakeDamage.emit(15)

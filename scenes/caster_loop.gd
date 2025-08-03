extends Enemy
const DAMAGE_NUMBER_POOL = preload("res://Pools/damageNumberPool.tres")
var difficulty = 0;
const SPEED = 50.0
const DAMAGE_NUMBER = preload("res://scenes/UI/DamageNumber.tscn")
const XP_ORB = preload("res://scenes/XPOrbs/XPOrb.tscn")
signal TookDamage(damage: int, damage_from: CharacterBody2D)
var PLAYER_ENEMIES_KILLED = preload("res://Statistics/Statistics/Stats/Resources/player_enemies_killed.tres")

var CASTERLOOP_PROJ = preload("res://scenes/casterloopProj.tscn")

func _process(delta: float) -> void:
    _caster_loop_process(delta);

func _caster_loop_process(delta: float):
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
    var inst = XP_ORB.instantiate();
    inst.position = position;
    get_tree().current_scene.call_deferred("add_child", inst);
    call_deferred("queue_free")


func _on_health_component_health_changed(Health: float) -> void:
    var health = $HealthComponent;
    if health.Health != health.Max_Health:
        $TextureProgressBar.visible = true;
    
    var perc = (health.Health / health.Max_Health) * 100;
    $TextureProgressBar.value = perc;

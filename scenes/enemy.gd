extends CharacterBody2D
class_name Enemy

const SPEED = 50.0
const DAMAGE_NUMBER = preload("res://scenes/UI/DamageNumber.tscn")
const XP_ORB = preload("res://scenes/XPOrbs/XPOrb.tscn")
signal TookDamage(damage: int, damage_from: CharacterBody2D)
var PLAYER_ENEMIES_KILLED = preload("res://Statistics/Statistics/Stats/Resources/player_enemies_killed.tres")

func _physics_process(delta: float) -> void:
    var player = get_tree().get_first_node_in_group("player")
    
    velocity = position.direction_to(player.position) * SPEED
    
    move_and_slide()

func _on_took_damage(damage: int, damage_from: CharacterBody2D) -> void:
    if self.is_queued_for_deletion():
        return
    
    if $Timer.time_left == 0.0:
        $HealthComponent.Health -= damage;
        position += damage_from.position.direction_to(global_position) * 15
        $Timer.start();
        
        var dmgNumInst = DAMAGE_NUMBER.instantiate();
        dmgNumInst.position.y -= 8;
        add_child(dmgNumInst);

func _on_health_component_health_depleted() -> void:
    PLAYER_ENEMIES_KILLED.enemies_killed += 1;
    if randi_range(0, 100) < 50:
        var inst = XP_ORB.instantiate();
        inst.position = position;
        get_tree().current_scene.call_deferred("add_child", inst);
    queue_free()


func _on_health_component_health_changed(Health: float) -> void:
    var health = $HealthComponent;
    if health.Health != health.Max_Health:
        $TextureProgressBar.visible = true;
    
    var perc = (health.Health / health.Max_Health) * 100;
    $TextureProgressBar.value = perc;
    
    

extends Projectile

const DAMAGE_NUMBER = preload("res://scenes/UI/DamageNumber.tscn")

func _on_damage_area_body_entered(body: Node2D):
    if body is Enemy:
        body.TookDamage.emit(damage, get_tree().get_first_node_in_group("player"));
        queue_free();

func _ready() -> void:
    rotation = direction.angle();

func _process(delta: float) -> void:
    _base_mage_wand_projectile(delta)

func _base_mage_wand_projectile(delta: float):
    position += direction * 300.0 * delta;

func modify(stats: PlayerStats):
    damage = stats.attack;

func _on_timer_timout():
    call_deferred("queue_free")

extends Projectile

var player;
var angle = 0;
var distance = 0;


func _ready():
    player = get_tree().get_first_node_in_group("player");

func modify(stats: PlayerStats):
    damage = stats.attack * 3

func _process(delta: float) -> void:
    position = player.position + Vector2.RIGHT.rotated(angle) * distance;
    distance += 15 * delta;
    angle += 5 * delta
    scale -= Vector2(0.25 * delta, 0.25 * delta);
    if scale.x <= 0.1:
        queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Enemy:
        body.TookDamage.emit(damage, null)

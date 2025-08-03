extends Projectile

var player;
var angle = 0;
var distance = 0;

func _ready():
    player = get_tree().get_first_node_in_group("player");

func _process(delta: float) -> void:
    position = player.position + Vector2.RIGHT.rotated(angle) * distance;
    distance += 15 * delta;
    angle += 5 * delta

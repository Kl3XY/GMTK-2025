extends Node2D

var follow_player = false;

var player;
var speed = 30;
var xp_amount = 10;

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        follow_player = true;

func _ready() -> void:
    player = get_tree().get_first_node_in_group("player");

func _process(delta: float) -> void:
    if follow_player:
        var dir = position.direction_to(player.position);
        speed += 600 * delta;
        position += dir * speed * delta
        $AnimatedSprite2D.rotation += 30 * delta;
        
func _on_player_collision_body_entered(body: Node2D) -> void:
    if body is Player:
        var xp = player.get_node("Components").get_node("XP") as XPComponent;
        xp.XP += xp_amount;
        queue_free();

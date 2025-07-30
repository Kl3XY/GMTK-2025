extends Sprite2D
class_name Attack

@export var direction: Vector2;
@export var speed: float = 300;

func _process(delta: float) -> void:
	position += direction * delta * speed;


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.queue_free();
		queue_free();

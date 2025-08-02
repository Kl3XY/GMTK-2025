extends Projectile

func _process(delta: float) -> void:
    position += direction * 60 * delta;


func _ready():
    rotation = randi_range(0, 360);


func _on_area_2d_body_entered(body: Node2D) -> void:
    
     if body is Enemy:
        body.TookDamage.emit(damage, null);

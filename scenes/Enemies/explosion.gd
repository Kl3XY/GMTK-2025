extends ColorRect

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:        
    _explosion_physics_process(delta);

func _explosion_physics_process(delta: float):
    var material: ShaderMaterial = self.material
    time += delta
    material.set_shader_parameter("time", time)
    
    if time > 2:
        $Area2D/CollisionShape2D.disabled = true;
    
    if time > 12:
        self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        var plr = body as Player;
        plr.TakeDamage.emit(50)

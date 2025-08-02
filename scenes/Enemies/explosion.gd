extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if time == 0:
        var bodies = $Area2D.get_overlapping_bodies();
        
        for body in bodies:
            if body is Player:
                pass # TODO
            elif body is FrootBomb:
                body.explode()
                
    
    var material: ShaderMaterial = self.material
    time += delta
    material.set_shader_parameter("time", time)
    
    if time > 12:
        self.queue_free()

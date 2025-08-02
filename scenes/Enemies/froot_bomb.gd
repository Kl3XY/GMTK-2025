extends Node2D
class_name FrootBomb

@export var explosion: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func explode() -> void:
    var exp = explosion.instantiate()
    exp.global_position = self.global_position - Vector2(20, 24)
    get_parent().add_child(exp)
    self.queue_free()

func _on_timer_timeout() -> void:
    self.explode()

extends Node2D
class_name FrootBomb

@export var explosion: PackedScene

func explode() -> void:
    var exp = explosion.instantiate()
    exp.global_position = self.global_position - Vector2(20, 24)
    get_parent().add_child(exp)
    self.queue_free()

func _on_timer_timeout() -> void:
    self.explode()

extends Node

@export var bomb: PackedScene

func _on_health_component_health_depleted() -> void:
    var inst = bomb.instantiate()
    inst.global_position = self.get_parent().global_position
    self.get_parent().get_parent().add_child(inst)

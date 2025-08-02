extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

@export var bomb: PackedScene

func _on_health_component_health_depleted() -> void:
    var inst = bomb.instantiate()
    inst.global_position = self.get_parent().global_position
    self.get_parent().get_parent().add_child(inst)

extends Node2D
class_name HealthComponent

signal health_depleted;
signal health_changed(Health: float)

@export var Health: float = 100.0 :
    set(val):
        if val > Max_Health:
            val = Max_Health;
        if val <= 0:
            health_depleted.emit();
        Health = val;
        health_changed.emit(Health)
@export var Max_Health: float = 100.0;

func _ready() -> void:
    # Emit damit sich alles auf die Base Health updaten kann.
    health_changed.emit(Health)

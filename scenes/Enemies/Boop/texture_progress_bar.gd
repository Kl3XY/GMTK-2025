extends TextureProgressBar
@onready var health_component: HealthComponent = $"../../HealthComponent"

func _ready() -> void:
    max_value = health_component.Max_Health;

func _on_health_component_health_changed(Health: float) -> void:
    if health_component != null:
        max_value = health_component.Max_Health;
        value = Health;

extends Control

@export var damage = 40;

@onready var label: Label = $Label

var speed = 300.0;

func _ready() -> void:
    label.text = "-" + str(damage)

func _process(delta: float) -> void:
    _damage_number_process(delta);

func _damage_number_process(delta: float):
    label.scale = lerp(label.scale, Vector2(0.65, 0.65), 13.0 * delta)
    speed = lerp(speed, 0.0, 20.0 * delta)
    position.y -= speed * delta;

func _on_timer_timeout() -> void:
    queue_free()

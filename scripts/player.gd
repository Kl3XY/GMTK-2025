extends CharacterBody2D

const SPEED = 80.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
    var direction := Input.get_vector("left", "right", "up", "down")
    if direction != Vector2.ZERO:
        velocity = direction * SPEED
        sprite.play("default")
    else:
        velocity = velocity.move_toward(Vector2.ZERO, SPEED)
        sprite.stop()

    if velocity.x != 0:
        sprite.flip_h = velocity.x > 0

    move_and_slide()

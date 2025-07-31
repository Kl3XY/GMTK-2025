extends CharacterBody2D

const SPEED = 80.0

enum CharacterType {
    Wizard,
    Archer,
    Warrior
}

@onready var sprite = $AnimatedSprite2D
@export var character_type: CharacterType

func cycle():
    match self.character_type:
        CharacterType.Wizard:
            self.character_type = CharacterType.Warrior
        CharacterType.Warrior:
             self.character_type = CharacterType.Archer
        CharacterType.Archer:
             self.character_type = CharacterType.Wizard
            
    sprite.play(self.get_animation())
    sprite.stop()

func get_animation() -> String:
    match self.character_type:
        CharacterType.Wizard:
            return "wizard"
        CharacterType.Warrior:
            return "warrior"
        CharacterType.Archer:
            return "archer"
            
    return "default"
    
func _ready() -> void:
    sprite.play(self.get_animation())
    sprite.stop()

func _physics_process(delta: float) -> void:
    var direction := Input.get_vector("left", "right", "up", "down")
    if direction != Vector2.ZERO:
        velocity = direction * SPEED
        sprite.play(self.get_animation())
    else:
        velocity = velocity.move_toward(Vector2.ZERO, SPEED)
        sprite.stop()

    if velocity.x != 0:
        sprite.flip_h = velocity.x > 0

    move_and_slide()
    
    if Input.is_action_just_pressed("cycle"):
        self.cycle()


func _on_health_component_health_changed(Health: float) -> void:
    $"UI placeholder/Label".text = "Health: " + str(Health);

func _on_health_component_health_depleted() -> void:
    # kill das game wie den spieler pog.
    get_tree().quit();

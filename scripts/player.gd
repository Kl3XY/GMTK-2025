extends CharacterBody2D
class_name Player;

const SPEED = 80.0
var Level = 1;

@onready var sprite = $AnimatedSprite2D
@onready var attacks = $Attacks
@export var wand: PackedScene
    
func get_animation() -> String:
    return "wizard"
    
func _ready() -> void:
    sprite.play(self.get_animation())
    sprite.stop()
    
    self.global_position = get_tree().get_first_node_in_group("world").player_spawn_pos()

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
    
    if Input.is_action_just_pressed("ui_down") && attacks.get_child_count() > 0:
        attacks.get_child(0).queue_free()
        
    if Input.is_action_pressed("ui_up"):
        attacks.add_child(wand.instantiate())
        
    if Input.is_action_just_pressed("Toggle Pause Menu"):
        if $"Pause Menu".visible == false:
            $"Pause Menu".show();
            Engine.time_scale = 0.0;
        else:
            $"Pause Menu".hide();
            Engine.time_scale = 1.0;

func _on_health_component_health_changed(Health: float) -> void:
    $"UI placeholder/Label".text = "Health: " + str(Health);

func _on_health_component_health_depleted() -> void:
    # kill das game wie den spieler pog.
    get_tree().quit();


func _on_xp_xp_change(xp: float) -> void:
    var XP = %XP as XPComponent;

    var perc = (XP.XP / XP.Max_XP) * 100;
    $"UI placeholder/TextureProgressBar".value = perc;
    
func _on_xp_level_up() -> void:
    Level += 1;
    $"UI placeholder/Label2".text = "Level\n" + str(Level)

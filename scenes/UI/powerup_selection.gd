extends Control

@export var PowerUpManager: PowerupManager;
var PowerUp: Powerup;

func _ready():
    PowerUp = PowerUpManager.get_powerup();
    
    if PowerUp == null:
        queue_free();
    else: 
        $Button.text = str(PowerUp)

func _on_button_pressed() -> void:
    PowerUp.apply(get_tree().get_first_node_in_group("player"));

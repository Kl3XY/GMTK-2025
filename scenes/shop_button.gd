extends Button

var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")
var SHOP = preload("res://Achievements/Achievements/shop.tres")

#@export var powerup_to_sell: PowerUpWeight;
@export var item_icon: Texture2D;
@export var item_name: String = "";
@export var gem_price: int = 0;

func _ready() -> void:
    $"Item Icon".texture = item_icon
    $"Item Name".text = item_name;
    $Gem.text = str(gem_price) + "x"
    
    #if GENERIC_POWERUPS.powerups.has(powerup_to_sell):
     #   queue_free();

func _on_pressed() -> void:
    #GENERIC_POWERUPS.powerups.append(powerup_to_sell);
    PLAYER_COLLECTED_GEMS.gems -= gem_price;
    SHOP.hasUnlocked = true;
    queue_free()

extends Resource
class_name PowerupManager

@export var Powerups: Array[Powerup]

var rng = RandomNumberGenerator.new();

func get_powerup() -> Powerup:
    return Powerups.pick_random()

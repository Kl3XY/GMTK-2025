extends Resource
class_name PowerupManager

@export var powerups: Array[PowerUpWeight];

var rng = RandomNumberGenerator.new();

func get_powerup() -> Powerup:
    rng.randomize();
    
    var weighted_sum = 0;
    
    for n in powerups:
        weighted_sum += n.weight;
    
    var chosen_weight = rng.randi_range(0, weighted_sum)
    
    for entry in powerups:
        if chosen_weight <= entry.weight:
            if entry.powerup != null:
                return entry.powerup;
            else:
                return null;
        chosen_weight -= entry.weight;
    
    return null;

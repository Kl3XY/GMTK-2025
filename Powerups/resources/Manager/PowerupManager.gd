extends Resource
class_name PowerupManager

@export var PowerupWeights: Array[PowerupWeight]

var rng = RandomNumberGenerator.new();

func get_powerup() -> Powerup:
    rng.randomize();
    
    var weighted_sum = 0;
    
    for n in PowerupWeights:
        weighted_sum += n.weight;
    
    var chosen_weight = rng.randi_range(0, weighted_sum)
    
    for entry in PowerupWeights:
        if chosen_weight <= entry.weight:
            if entry != null:
                return entry.powerup;
            else:
                return null;
        chosen_weight -= entry.weight;
    
    return PowerupWeights[0].powerup

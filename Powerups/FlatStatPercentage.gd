extends Powerup
class_name FlatStatPercentage

@export var statAdd: PlayerStats;

func _to_string() -> String:
    var str = "";
    str += name
    str += "\n"
    str += "- Stat Boost (%) -"
    str += "\n"
    str += description
    return str;

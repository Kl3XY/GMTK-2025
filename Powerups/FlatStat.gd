extends Powerup
class_name FlatStat

@export var statAdd: PlayerStats;

func apply(player: Player):
    player.stats.add(statAdd);

func _to_string() -> String:
    var str = "";
    str += name
    str += "\n"
    str += "- Stat Boost -"
    str += "\n"
    str += description
    return str;

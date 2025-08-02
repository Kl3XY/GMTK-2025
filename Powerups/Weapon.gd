extends Powerup
class_name Weapon

@export var instantiated_weapon: PackedScene;

func apply(player: Player):
    var attacks = player.get_node("Attacks");
    var inst = instantiated_weapon.instantiate();
    attacks.add_child(inst);

func _to_string() -> String:
    var str = "";
    str += name
    str += "\n"
    str += "- Weapon -"
    str += "\n"
    str += description
    return str;

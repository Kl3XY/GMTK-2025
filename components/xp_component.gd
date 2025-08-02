extends Node2D
class_name XPComponent

signal level_up()
signal xp_change(xp: float)

@export var XP: float = 0.0 :
    set(val):
        if val > Max_XP:
            val -= Max_XP;
            level_up.emit();
            Max_XP += 300;
        xp_change.emit(XP)
        print(XP)
        XP = val;
@export var Max_XP: float = 100.0;

func _ready() -> void:
    # Emit damit sich alles auf die Base Health updaten kann.
    xp_change.emit(XP)

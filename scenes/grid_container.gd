extends GridContainer

@onready var power_up_menu: Control = $"../../.."

func _ready():
    for button in get_children():
        var _b = button;
        _b.get_node("Button").pressed.connect(select_skill)

func select_skill():
    $"../../..".queue_free();
    Engine.time_scale = 1.0;

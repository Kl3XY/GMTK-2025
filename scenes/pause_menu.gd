extends CanvasLayer


func _ready():
    _on_visibility_changed(); # im initial stand starten

func _on_visibility_changed() -> void:
    $"anim container".position.x = -500
    if visible == false:
        Engine.max_fps = 999;
    else:
        Engine.max_fps = 60;
        # Da Engine.time_scale = 0.0 jegliche nutzung von delta nutzlos macht force ich die fps in menüs auf 60.

func _process(delta: float) -> void:
    if $"anim container".position.x < -0.1:
        $"anim container".position.x = lerp($"anim container".position.x, 0.0, 0.083);
        print($"anim container".position.x);
            

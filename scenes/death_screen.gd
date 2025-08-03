extends CanvasLayer

const PLAYER_ENEMIES_KILLED = preload("res://Statistics/Statistics/Stats/Resources/player_enemies_killed.tres")

func _process(delta: float) -> void:
    if visible:
        var plr = get_tree().get_first_node_in_group("player") as Player;
        $ColorRect.color.a = lerp($ColorRect.color.a, 0.6, 0.085)
        $Title2.text = "";
        $Title2.text += "- PLAYER STATS -\n";
        $Title2.text += "DAMAGE: " + str(plr.stats.attack) + "\n";
        $Title2.text += "KILLS: " + str(PLAYER_ENEMIES_KILLED.enemies_killed) + "\n";
        $Title2.text += "TIME SURVIVED: " + $"../UI placeholder/Timer".text + "\n";
        $Title2.text += "LEVEL: " + str(plr.Level) + "\n";
        

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")

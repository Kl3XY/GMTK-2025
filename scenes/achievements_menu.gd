extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")

func _process(delta: float) -> void:
    if visible == false:
        reload_info = true;
    else:
        if reload_info == true:
            var str = "";
            for achievement in HANDLER.Achievements:
                if achievement.hasUnlocked == true:
                    str += achievement.name + " - " + achievement.short_desc;
                else:
                    str += "[color=darkgray]" + achievement.name + " - " + achievement.short_desc + "[/color]"
                str += "\n"
            $AchievementList.text = str
            
func _on_texture_button_pressed() -> void:
    visible = false;
    $"../Locker".visible = false;

            

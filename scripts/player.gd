extends CharacterBody2D
class_name Player;

var isDead = false;
var Level = 1;
var DIFFICULTY = preload("res://Difficulty/difficulty.tres")
var PLAYER_ENEMIES_KILLED = preload("res://Statistics/Statistics/Stats/Resources/player_enemies_killed.tres")
var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")
const POWER_UP_MENU = preload("res://scenes/Power Up Menu.tscn")
@onready var health_component: HealthComponent = $Components/HealthComponent
var A_LIKE_SUPREME = preload("res://Achievements/Achievements/a_like_supreme.tres")
@export var stats: PlayerStats;
@onready var sprite = $AnimatedSprite2D
@onready var attacks = $Attacks
const DEATH_AOE = preload("res://scenes/Attacks/DeathAOE.tscn")
var death_anim_state = 0;
var death_anim_state_2_wait = 100;

var total_time_in_secs: int = 0;

var tookDamage = false;
signal TakeDamage(damage: int);

func get_animation() -> String:
    return "wizard"
    
func _ready() -> void:
    sprite.play(self.get_animation())
    sprite.stop()
    
    self.global_position = get_tree().get_first_node_in_group("world").player_spawn_pos()

func _player_physics_process(delta: float):
    if isDead != true:
        var m = int(total_time_in_secs / 60.0);
        var s = total_time_in_secs - m * 60;
        $"UI placeholder/Timer".text = str(m) + ":" + str(s) 
        $"UI placeholder/LevelDisplay".text = "LVL: " + str(Level);
        $"UI placeholder/KillCounter".text = "KILLS: " + str(PLAYER_ENEMIES_KILLED.enemies_killed);
        var direction := Input.get_vector("left", "right", "up", "down")
        if direction != Vector2.ZERO:
            velocity = direction * stats.speed
            sprite.play(self.get_animation())
        else:
            velocity = velocity.move_toward(Vector2.ZERO, stats.speed)
            sprite.stop()

        if velocity.x != 0:
            sprite.flip_h = velocity.x > 0

        move_and_slide()
        
        for n in $Attacks.get_children():
            n.playerStats = stats;
        
        if Input.is_action_just_pressed("Toggle Pause Menu"):
            if $"Pause Menu".visible == false:
                $"Pause Menu".show();
                Engine.time_scale = 0.00001;
            else:
                $"Pause Menu".hide();
                Engine.time_scale = 1.0;
    else:
        match death_anim_state:
            0:
                if is_instance_valid(attacks):
                    attacks.queue_free();
                Engine.time_scale = lerp(Engine.time_scale, 0.2, 4.0 * delta);
                $Camera2D.zoom = lerp($Camera2D.zoom, Vector2(6.0, 6.0), 4.0 * delta);
                if Engine.time_scale <= 0.3:
                    death_anim_state = 1;
            1:
                Engine.time_scale = lerp(Engine.time_scale, 1.0, 8.0 * delta);
                $Camera2D.zoom = lerp($Camera2D.zoom, Vector2(3.0, 3.0), 25.0 * delta);
                var aoe = DEATH_AOE.instantiate();
                aoe.position = global_position;
                get_tree().current_scene.add_child(aoe);
                if get_tree().get_node_count_in_group("enemies") < 10:
                    if death_anim_state_2_wait <= 0:
                        death_anim_state = 2;
                    else:
                        death_anim_state_2_wait -= 50 * delta;
                    
            2:
                $DeathScreen.visible = true;
        

func _process(delta: float) -> void:
    _player_physics_process(delta)

func _on_health_component_health_changed(Health: float) -> void:
    $HealthBar.value = Health;

func _on_health_component_health_depleted() -> void:
    isDead = true;


func _on_xp_xp_change(xp: float) -> void:
    var XP = %XP as XPComponent;

    var perc = (XP.XP / XP.Max_XP) * 100;
    $"UI placeholder/TextureProgressBar".value = perc;
    
func _on_xp_level_up() -> void:
    Level += 1;
    
    # hier beachten das frequent pause und unpausing performance issues caused.
    
    var inst = POWER_UP_MENU.instantiate();
    get_tree().current_scene.add_child(inst)
    Engine.time_scale = 0.1;
    
    $"UI placeholder/LevelDisplay".text = "LVL: " + str(Level);
    health_component.Health += 3;


func _on_take_damage(damage: int) -> void:
    tookDamage = true;
    if $Invinicibilty.time_left == 0.0:
        $Invinicibilty.start();
        health_component.Health -= damage
        $HurtFlash/ColorRect.color.a = 0.8;




func _on_take_damage_area_body_entered(body: Node2D) -> void:
    if body is Enemy:
        TakeDamage.emit(5)


func _on_alikesupremetimer_timeout() -> void:
    A_LIKE_SUPREME.hasUnlocked = true;


func _on_timer_2_timeout() -> void:
    total_time_in_secs += 1;

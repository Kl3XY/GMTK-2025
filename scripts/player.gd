extends CharacterBody2D
class_name Player;

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

var tookDamage = false;
signal TakeDamage(damage: int);

func get_animation() -> String:
    return "wizard"
    
func _ready() -> void:
    sprite.play(self.get_animation())
    sprite.stop()
    
    self.global_position = get_tree().get_first_node_in_group("world").player_spawn_pos()

func _player_physics_process(delta: float):
    $"UI placeholder/LevelDisplay".text = "LVL: " + str(Level);
    $"UI placeholder/KillCounter".text = "KILLS: " + str(PLAYER_ENEMIES_KILLED.enemies_killed);
    $"UI placeholder/GemCounter".text = "GEMS: " + str(PLAYER_COLLECTED_GEMS.gems);
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

func _process(delta: float) -> void:
    _player_physics_process(delta)

func _on_health_component_health_changed(Health: float) -> void:
    $HealthBar.value = Health;

func _on_health_component_health_depleted() -> void:
    $DeathScreen.visible = true;
    Engine.time_scale = 0.0;


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


func _on_take_damage(damage: int) -> void:
    print("OOF!")
    tookDamage = true;
    if $Invinicibilty.time_left == 0.0:
        print("YOUCH!")
        $Invinicibilty.start();
        health_component.Health -= damage




func _on_take_damage_area_body_entered(body: Node2D) -> void:
    if body is Enemy:
        TakeDamage.emit(5, body)


func _on_alikesupremetimer_timeout() -> void:
    if tookDamage == false:
        A_LIKE_SUPREME.hasUnlocked = true;

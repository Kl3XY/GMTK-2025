extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    self.layout()

const ROTATION_MULTIPLIER = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    self.rotation += delta * ROTATION_MULTIPLIER
    
    for child in self.get_children():
        child.rotation -= delta * ROTATION_MULTIPLIER

func layout(_e = null):
    var children = self.get_children()
    var n = children.size()
    
    var angle = 2 * PI / n
    
    for i in range(n):
        var direction = Vector2.UP.rotated(angle * i)
        var distance = 8 / sin(angle / 2)
        
        var child = children.get(i)
        
        child.position = direction * distance
        child.rotation = 0
    
        

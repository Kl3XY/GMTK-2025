extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    self.layout()

const ROTATION_SPEED_MULTIPLIER = 3

# Each frame, we rotate the parent, so that all weapons are moved along the circle.
# The weapons themselves are rotated in the opposite direction, so that they remain level.
func _process(delta: float) -> void:
    _attack_process(delta);

func _attack_process(delta: float):
    self.rotation += delta * ROTATION_SPEED_MULTIPLIER
    
    for child in self.get_children():
        child.rotation -= delta * ROTATION_SPEED_MULTIPLIER

# Calculates how many weapons can be put into the nth ring.
# The circumference of any ring is 2 * ℼ * r.
# The radius of the ring is 16 * n, so that the weapons are equally spaced.
# Therefore the circumgerece is 2 * ℼ * 16 * n.
# Because weapons are also equally spaced among the circle, 
# the number of weapons per ring is the circumference divided by 16.
# This yields 2 * ℼ * 16 * n / 16 = 2 * ℼ * n.
# To get an int result we floor the result.
func weapons_in_ring(n: int) -> int:
    return floor(2 * PI * n)

func layout(_e = null):
    var all_weapons = self.get_children()
    
    var weapons_already_taken = 0
    var current_ring = 1
    
    while weapons_already_taken < all_weapons.size():
        # While there are weapons remaining, 
        # we take as many as can fit in the current ring.
        var ring_capacity = weapons_in_ring(current_ring)
        var weapons = all_weapons.slice(
            weapons_already_taken, 
            weapons_already_taken + ring_capacity
        )
        
        # We then add the amount of taken weapons so we dont take them again.
        weapons_already_taken += ring_capacity
        
        # To equally space the weapons among the ring, 
        # we divide the ring into how many weapons we have.
        var angle = 2 * PI / weapons.size()
        
        for i in range(weapons.size()):
            # We position each weapon 16 * the current ring away from the player, 
            # rotated by the angle.
            var direction = Vector2.UP.rotated(angle * i)
            var distance = 16 * current_ring
            
            var child = weapons.get(i)
            
            child.position = direction * distance
            
            # The rotation of the element is the inverse of the parents rotation,
            # so that it appears level.
            child.rotation = -rotation
    
        # At the end we advance to the next ring.
        current_ring += 1
        

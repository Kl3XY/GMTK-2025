extends Resource
class_name Pool;

@export var item_to_pool: PackedScene;
@export var items_to_preload: int;

var pool: Array[Object] = [];

func _init() -> void:
    _preload();

func _preload():
    for n in range(items_to_preload):
        pool.append(item_to_pool.instantiate());
        
func retrieve() -> Object:
    if pool.is_empty():
        _preload();
    
    return pool.pop_front();

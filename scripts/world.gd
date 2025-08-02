extends Node2D

@onready var floor: TileMapLayer = $Floor
@onready var cliffs: TileMapLayer = $Cliffs
@onready var props: TileMapLayer = $Props
@onready var player: CharacterBody2D = $Player
@export var noise: FastNoiseLite

const CHUNK_SIZE = 16
const CHUNKS_TO_LOAD = 3

const PIXELS_PER_CELL = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()
    noise.seed = randi()
      
var spawn_pos = null
          
func player_spawn_pos() -> Vector2:
    if spawn_pos != null:
        return spawn_pos
    
    var x := 0
    
    while self.noise.get_noise_2d(x, 0) < -0.3:
        x += 3
        
    spawn_pos = Vector2(x * 8, 0)
    
    return spawn_pos
    

func is_chunk_generated(cell) -> bool:
    return $Floor.get_cell_source_id(cell) != -1
    
func get_chunk_master_cell(cell: Vector2i) -> Vector2i:
    return cell / CHUNK_SIZE * CHUNK_SIZE
    
func chunk_offset_to_player(pin: Vector2, chunk_delta: Vector2i) -> Vector2:
    var player_cell_pos = pin / PIXELS_PER_CELL
    var chunk_pos = get_chunk_master_cell(player_cell_pos) \
        + chunk_delta * CHUNK_SIZE
        
    return chunk_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    _world_process(delta)

func _world_process(delta: float):
    for dx in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD):
        for dy in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD):
            var chunk_delta = Vector2i(dx, dy)
            var master_cell = chunk_offset_to_player(player.global_position, chunk_delta)
            
            if !is_chunk_generated(master_cell):
                generate_chunk(master_cell)
      
const GRASS = Vector2i(1, 0)
const TREE = Vector2i(1, 4)
const STONE = Vector2i(2, 4)
const OBELISK = Vector2i(4, 3)
const AIR = Vector2i(1, 2)
            
func generate_chunk(master_cell: Vector2i):
    var cliffs = []
    
    for dx in range(CHUNK_SIZE):
        for dy in range(CHUNK_SIZE):
            var cell = master_cell + Vector2i(dx, dy)
            
            $Floor.set_cell(cell, 0, GRASS)
            
            var random = randi() % 700
            
            if random == 0:
                $Props.set_cell(cell, 0, OBELISK)
            elif random < 15:
                $Props.set_cell(cell, 0, TREE)
            elif random < 20:
                $Props.set_cell(cell, 0, STONE)
                
            if noise.get_noise_2d(cell.x, cell.y) < -0.3:
                cliffs.push_back(cell)
                
    $Cliffs.set_cells_terrain_connect(cliffs, 0, 0, false)
                

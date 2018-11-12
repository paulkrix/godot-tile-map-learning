extends Node

var preScript = preload("res://Scripts/softnoise.gd")
var softnoise
var grid
var grid_size = Vector2( 60, 30 )

func _ready():
  grid = []
  createTileGrid()

func createTileGrid(): 

  #Random
  # softnoise = preScript.SoftNoise.new()
  #Passing a seed
  softnoise = preScript.SoftNoise.new(2)
  
  for x in range( grid_size[0] ):
    grid.append([])
    for y in range( grid_size[1] ):
      var result = scaleSimplex( softnoise.openSimplex2D( sqrt(x), sqrt(y)) )
      
      grid[x].append(0)
      if result < 0.35:
        grid[x][y] = 1
  for x in range( len( grid ) ):
    for y in range( len( grid[x] ) ):
      var walls = 0
      if grid[x][y] == 1:
        $TileMap.set_cellv( Vector2(x,y), 15 )
      else:
        if y > 0 and grid[x][y-1] == 1:
          walls |= 1
        if x < len(grid)-1 and grid[x+1][y] == 1:
          walls |= 2
        if y < len(grid[x])-1 and grid[x][y+1] == 1:
          walls |= 4
        if x > 0 and grid[x-1][y] == 1:
          walls |= 8

        $TileMap.set_cellv( Vector2(x,y), walls )

func scaleSimplex( simplexValue ):
  return (1.0 + simplexValue) / 2.0

func showRange( center, _range ):
  

  var frontier = []
  frontier.append( center )
  var distance = {}
  distance[center] = 0

  while not frontier.empty():
    var current = frontier.pop_front()
    if distance[current] < _range:
      for next in getNeighbors(current):
        if not distance.has(next):
          frontier.append(next)
          distance[next] = 1 + distance[current]

  $MapUI.resetRangeHighlight()
  for tile in distance.keys():
    $MapUI.registerRangeHighlight( tile, Color( 0.75, 0, 0, 1 ), Color( 0.5, 0, 0, 0.25 ) )

func getNeighbors( tile ):
  var neighbors = []
  if tile[0] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( -1, 0 )) 
  if tile[0] + 1 < grid_size[0]:
    neighbors = appendPathable( neighbors, tile + Vector2( 1, 0 ))
  if tile[1] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, -1 ))
  if tile[1] + 1 < grid_size[1]:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, 1 ))
  return neighbors


func appendPathable( array, tile ):
  if isPathable( tile ):
    array.append( tile )
  return array

func isPathable( tile_index ):
  var cellv = $TileMap.get_cellv( tile_index )
  if cellv == 15 or cellv == -1:
    return false
  return true

func _on_Area2D_mouse_exited():
  pass


func _on_Area2D_input_event(viewport, event, shape_idx):
  var hoverTilePosition = $TileMap.world_to_map( event.position ); 
  $MapUI.registerMouseHighlight( hoverTilePosition, Color(1,1,1,0.7), Color(1,1,1,0.1 ) )

func updateUI():
  $MapUI.update()
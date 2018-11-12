extends Node

var preScript = preload("res://Scripts/softnoise.gd")
var softnoise
var grid
var gridSize = Vector2( 60, 30 )

func _ready():
  grid = []
  createTileGrid()

func createTileGrid(): 

  #Random
  # softnoise = preScript.SoftNoise.new()
  #Passing a seed
  softnoise = preScript.SoftNoise.new(2)
  
  for x in range( gridSize[0] ):
    grid.append([])
    for y in range( gridSize[1] ):
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

func getNeighbors( tile ):
  var neighbors = []
  if tile[0] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( -1, 0 )) 
  if tile[0] + 1 < gridSize[0]:
    neighbors = appendPathable( neighbors, tile + Vector2( 1, 0 ))
  if tile[1] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, -1 ))
  if tile[1] + 1 < gridSize[1]:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, 1 ))
  return neighbors

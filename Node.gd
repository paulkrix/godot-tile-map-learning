extends Node

var preScript = preload("res://Scripts/softnoise.gd")
var softnoise
var world
var worldSize = Vector2( 23, 14 )
var turn = 1

func _ready():
  world = []
  createMap()
  $Dude.setMap( $TileMap )
  showRange( $Dude )

func createMap(): 

  #Random
  #  softnoise = preScript.SoftNoise.new()
  #Passing a seed
  softnoise = preScript.SoftNoise.new(2)
  
  for x in range( worldSize[0] ):
    world.append([])
    for y in range( worldSize[1] ):
      var result = scaleSimplex( softnoise.openSimplex2D( sqrt(x), sqrt(y)) )
      
      world[x].append(0)
      if result < 0.35:
        world[x][y] = 1
  for x in range( len( world ) ):
    for y in range( len( world[x] ) ):
      var walls = 0
      if world[x][y] == 1:
        $TileMap.set_cellv( Vector2(x,y), 15 )
      else:
        if y > 0 and world[x][y-1] == 1:
          walls |= 1
        if x < len(world)-1 and world[x+1][y] == 1:
          walls |= 2
        if y < len(world[x])-1 and world[x][y+1] == 1:
          walls |= 4
        if x > 0 and world[x-1][y] == 1:
          walls |= 8

        $TileMap.set_cellv( Vector2(x,y), walls )


func scaleSimplex( simplexValue ):
  return (1.0 + simplexValue) / 2.0

func showRange( dude ):
  var center = dude.getTile()
  var _range = dude.getMoves()

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

  $Highlights.resetRangeHighlight()
  for tile in distance.keys():
    $Highlights.registerRangeHighlight( tile, Color( 0.75, 0, 0, 1 ), Color( 0.5, 0, 0, 0.25 ) )

func getNeighbors( tile ):
  var neighbors = []
  if tile[0] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( -1, 0 )) 
  if tile[0] + 1 < worldSize[0]:
    neighbors = appendPathable( neighbors, tile + Vector2( 1, 0 ))
  if tile[1] - 1 >= 0:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, -1 ))
  if tile[1] + 1 < worldSize[1]:
    neighbors = appendPathable( neighbors, tile + Vector2( 0, 1 ))
  return neighbors


func appendPathable( array, tile ):
  if $TileMap.isPathable( tile ):
    array.append( tile )
  return array


func _input( event ):
  # Mouse in viewport coordinates
  if event is InputEventMouseMotion:
    var hoveredTile = $TileMap.world_to_map(event.position)
    $Highlights.registerMouseHighlight( hoveredTile, Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0.25 ) )    

func _process(delta):
  # I beleive this is better as we can very easily control whether it's a click, drag or release
  if Input.is_action_just_released( "left_mouse_button" ):
    var position = get_viewport().get_mouse_position()

  if Input.is_action_just_pressed( "ui_up" ):
    $Dude.move( Vector2(0,-1) )
    showRange( $Dude )
  if Input.is_action_just_pressed( "ui_down" ):
    $Dude.move( Vector2(0,1) )
    showRange( $Dude )
  if Input.is_action_just_pressed( "ui_left" ):
    $Dude.move( Vector2(-1,0) )
    showRange( $Dude )
  if Input.is_action_just_pressed( "ui_right" ):
    $Dude.move( Vector2(1,0) )
    showRange( $Dude )

func end_turn():
  turn = turn + 1
  $Dude.end_turn()
  $Turn.set_text("Turn " + str(turn) )
  showRange( $Dude )

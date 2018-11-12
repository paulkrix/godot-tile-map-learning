extends Node2D

var moves = 5

func getMoves():
  return moves

func getTile( map ):
  return map.world_to_map( self.get_position() )

func move( direction, grid ):
  var map = grid.getMap()
  if moves == 0:
    return
  var tile = getTile( map )
  if grid.isPathable( tile + direction ):
    var new_position = map.map_to_world( tile + direction )
    self.set_position( new_position )
    moves = moves - 1
    update()
  grid.showRange( getTile( map ), moves )
#func _process(delta):
#  # Called every frame. Delta is time since last frame.
#  # Update game logic here.
#  pass


func resetTurn( grid ):
  moves = 5
  grid.showRange( getTile( grid.getMap() ), moves )

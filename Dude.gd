extends Node2D

var map
var moves = 5

func setMap( _map ):
  map = _map

func getMoves():
  return moves

func getTile():
  return map.world_to_map( self.get_position() )

func move( direction ):
  var tile = getTile()
  if map.isPathable( tile + direction ):
    var new_position = map.map_to_world( tile + direction )
    self.set_position( new_position )
    update()
#func _process(delta):
#  # Called every frame. Delta is time since last frame.
#  # Update game logic here.
#  pass

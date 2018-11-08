extends TileMap

func isPathable( tileIndex ):
  var cellv = self.get_cellv( tileIndex )
  if cellv == 15:
    return false
  if cellv == -1:
    return false
  return true
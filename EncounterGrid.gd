extends Node2D

const UI_FROM_BOTTOM = 200 # This needs to live somewhere global. Used in multiple places

func _ready():
  var grid_size = get_viewport().size - Vector2( 0, UI_FROM_BOTTOM )
  var area_position = self.get_position() + grid_size/2
  $Area2D.set_position( area_position  )
  $Area2D/CollisionShape2D.get_shape().set_extents( grid_size/2 )

func isPathable( tile_index ):
  return $TileManager.isPathable( tile_index )

func getMap():
  return $TileManager/TileMap

func getTileManager():
  return $TileManager

func showRange( position, _range ):
  $TileManager.showRange( position, _range )
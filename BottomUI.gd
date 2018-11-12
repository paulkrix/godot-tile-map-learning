extends Node2D

const UI_BOTTOM_HEIGHT = 200
var shape

func _ready():
  shape = Vector2( get_viewport().size.x-1, UI_BOTTOM_HEIGHT )
  self.set_position( Vector2( 0, get_viewport().size.y - UI_BOTTOM_HEIGHT ) )
  $SelectedInfo.updateShape( Vector2(0,0), shape )
  $TurnInfo.updateShape( Vector2( shape[0]/2 ,0 ), shape )

func _draw():
  var position = Vector2( 0, 0 )
  var UIShape = Rect2( position, shape )
  #draw_rect( UIShape, Color( 0.7, 0.7, 0.7, 1 ), true )
  #draw_rect( UIShape, Color( 1, 1, 1, 1 ), false )

#func handleHover( event ):
#  if $SelectedInfo.handleHover( event ):
#    return true
#  if $TurnInfo.handleHover( event ):
#    return true  
#  return false

#func inBounds( event ):
#  var position = self.get_position()
#  if (event.position[0] > position[0] and
#      event.position[1] > position[1] and
#      event.position[0] < position[0] + shape[0] and
#      event.position[1] < position[1] + shape[1]):
#        return true
#  return false
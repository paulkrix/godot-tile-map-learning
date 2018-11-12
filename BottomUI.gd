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

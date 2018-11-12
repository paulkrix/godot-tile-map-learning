extends Node2D

var size
var color = Color( 0, .1, 0, 1 )
var highlight_color = Color( 0, .3, 0, 1 )
var highlighted = false

func _ready():
  size = Vector2( 0, 0 )

func updateShape( _position, parent_size ):
  self.set_position( _position )
  size = Vector2( parent_size[0]/2, parent_size[1] )

  $Area2D.set_position( size/2  )
  $Area2D/CollisionShape2D.get_shape().set_extents( size/2 )
    
  update()

func _draw():
  var UIShape = Rect2( Vector2(0, 0), size )
  var draw_color = color
  if highlighted:
    draw_color = highlight_color
  draw_rect( UIShape, draw_color, true )
  draw_rect( UIShape, Color( 0.7, 1, 0.7, 1 ), false )   
  
func _on_Area2D_mouse_entered():
  highlighted = true
  update()


func _on_Area2D_mouse_exited():
  highlighted = false
  update()



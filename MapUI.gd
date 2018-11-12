extends Node2D

# class member variables go here, for example:
var tileSize = Vector2( 64, 64 )
var mouseHighlight
var rangeHighlights = [];

func _draw():
  if mouseHighlight:
    var rect = Rect2( mouseHighlight[0]*tileSize, tileSize-Vector2(1,1) )
    draw_rect( rect, mouseHighlight[2] )
    draw_rect( rect, mouseHighlight[1], false )
  for highlight in rangeHighlights:
    var rect = Rect2( highlight[0]*tileSize, tileSize-Vector2(1,1) )
    draw_rect( rect, highlight[2] )
    draw_rect( rect, highlight[1], false )

 
func registerMouseHighlight( tile, outline, fill ):
  mouseHighlight = [ tile, outline, fill ]
  update()

func removeMouseHighlight():
  mouseHighlight = null
  update()

func resetRangeHighlight():
  rangeHighlights.clear()

func registerRangeHighlight( tile, outline, fill ):
  rangeHighlights.append(
    [ tile, outline, fill ]
  )
  update()
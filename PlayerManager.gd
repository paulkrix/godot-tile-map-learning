extends Node

var dude
var grid

func _ready():
  dude = $Dude


func setGrid( _grid ):
  grid = _grid
  grid.showRange( dude.getTile( grid.getMap() ), dude.getMoves() )

func _process(delta):
  if Input.is_action_just_pressed( "ui_up" ):
    $Dude.move( Vector2(0,-1), grid )

  if Input.is_action_just_pressed( "ui_down" ):
    $Dude.move( Vector2(0,1), grid )

  if Input.is_action_just_pressed( "ui_left" ):
    $Dude.move( Vector2(-1,0), grid )

  if Input.is_action_just_pressed( "ui_right" ):
    $Dude.move( Vector2(1,0), grid )

extends Node

var grid
var ui
var turn = 1;

func _ready():
  pass
  
func setGrid( _grid ):
  grid = _grid
  $PlayerManager.setGrid( grid )

func setUI( _ui ):
  ui = _ui
  ui.get_node("BottomUI/TurnInfo/ResetTurnButton").connect("pressed", self, "resetTurn")

func resetTurn():
  turn = turn + 1
  ui.setTurn( turn )
  $PlayerManager/Dude.resetTurn( grid )


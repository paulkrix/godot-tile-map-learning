extends Node

var unit_manager

func _ready():
  pass

func setUnitManager( _unit_manager ):
  unit_manager = _unit_manager  

func setTurn( turn ):
  $BottomUI/TurnInfo.setTurn( turn )
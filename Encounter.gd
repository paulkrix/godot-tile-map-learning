extends Node

func _ready():
  $UnitManager.setGrid( $Grid )
  $UnitManager.setUI( $EncounterUI )
  $EncounterUI.setUnitManager($UnitManager )
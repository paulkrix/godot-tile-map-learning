extends Node

var encounter_path = "res://Encounter.tscn"

func _ready():
  var encounter_resource = load( encounter_path )
  # Remove current level 
  changeScene( encounter_resource.instance() )


func changeScene( level ):
  # Remove current level
  var current_level = self.get_child(0)
  print( current_level )
  self.remove_child( current_level )
  # Add new level
  self.add_child( level )
extends Node


var scenes : Dictionary = {"Menu" : "res://Scenes/level_1.tscn", 
						"Level1" : "res://Scenes/level_2.tscn"}
						
func transition_to_scene(level : String):
	print("Transition requested for level: " + level)
	if scenes.has(level):
		var scene_path : String = scenes[level]
		print("Scene path found: " + scene_path)
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene(scene_path)
	else:
		print("Error: Scene not found for level: " + level)

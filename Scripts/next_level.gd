extends Area2D

var players_in_area = {}
var player_count = 0


		
func _on_body_exited(body):
	if body.is_in_group("Players"):
		players_in_area.erase(body)
		
func _on_body_entered(body):
	if body.is_in_group("Players"):
		players_in_area[body] = true
	if players_in_area.size() >= 2:
		
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		var next_level_path = "res://Scenes/level_" + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)



extends Area3D
class_name Dropper_Tuc

func _on_body_entered(body):
	if body is Player:
		Events.emit_signal("tuc_touched_player")

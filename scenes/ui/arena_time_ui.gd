extends CanvasLayer

@export var arena_time_manager: Node
@onready var label: Label = %Label

func _process(delta: float) -> void:
	if !arena_time_manager: return
	
	var time_elapsed = arena_time_manager.get_time_elapsed()
	label.text = format_timer(time_elapsed)

func format_timer(seconds: float):
	var minutes = floor(seconds/60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(int(minutes)) + ":" + str(int(remaining_seconds))

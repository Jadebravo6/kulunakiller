@tool
extends CanvasModulate
## Cycle jour / crépuscule / nuit pour stage_02 (partage DayCycleData de stages/_base).

enum DayTimes { DAY, SUNSET, NIGHT }

@export var day_cycle_data: DayCycleData

@export var _color_day := Color(1, 0.972549, 0.917647, 1):
	set(value):
		_color_day = value
		color = _color_day
@export var _color_sunset := Color(0.776471, 0.458824, 0.407843, 1):
	set(value):
		_color_sunset = value
		color = _color_sunset
@export var _color_night := Color(0.278431, 0.211765, 0.478431, 1):
	set(value):
		_color_night = value
		color = _color_night

@export var _preview_time := DayTimes.DAY: set = _set_preview_time


func _ready() -> void:
	_on_twilight_changed()
	if day_cycle_data:
		QuiverEditorHelper.connect_between(day_cycle_data.twilight_changed, _on_twilight_changed)


func _on_twilight_changed() -> void:
	if day_cycle_data == null:
		return
	if day_cycle_data.twilight_transition < 0.5:
		var progress := smoothstep(0.0, 0.5, day_cycle_data.twilight_transition)
		color = _color_day.lerp(_color_sunset, progress)
	else:
		var progress := smoothstep(0.5, 1.0, day_cycle_data.twilight_transition)
		color = _color_sunset.lerp(_color_night, progress)


func _set_preview_time(value: DayTimes) -> void:
	_preview_time = value
	match _preview_time:
		DayTimes.DAY:
			color = _color_day
		DayTimes.SUNSET:
			color = _color_sunset
		DayTimes.NIGHT:
			color = _color_night

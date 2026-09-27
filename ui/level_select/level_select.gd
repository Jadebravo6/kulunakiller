class_name LevelSelect
extends Control
## Overlay de sélection de stage (même pattern que HowToPlay).

signal level_select_closed
signal level_chosen(scene_path: String)

const FADE_DURATION := 0.3

const STAGE_01 := "res://stages/stage_01/stage_01.tscn"
const STAGE_02 := "res://stages/stage_02/stage_02.tscn"

var _tween: Tween

@onready var _stage_1 := %Stage1 as Button
@onready var _stage_2 := %Stage2 as Button
@onready var _back := %Back as Button


func _ready() -> void:
	hide()
	modulate.a = 0.0
	if QuiverEditorHelper.is_standalone_run(self):
		open_level_select()


func open_level_select() -> void:
	show()
	_stage_1.grab_focus()
	if _tween:
		_tween.kill()
	_tween = create_tween()
	@warning_ignore("return_value_discarded")
	_tween.tween_property(self, "modulate:a", 1.0, FADE_DURATION)


func close_level_select() -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	@warning_ignore("return_value_discarded")
	_tween.tween_property(self, "modulate:a", 0.0, FADE_DURATION)
	@warning_ignore("return_value_discarded")
	_tween.tween_callback(_on_close_finished)


func _on_close_finished() -> void:
	hide()
	level_select_closed.emit()


func _on_stage_1_pressed() -> void:
	level_chosen.emit(STAGE_01)


func _on_stage_2_pressed() -> void:
	level_chosen.emit(STAGE_02)


func _on_back_pressed() -> void:
	close_level_select()

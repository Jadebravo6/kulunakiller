extends Control

## Menu principal avec sélection de stage visible (Stage 1 / Stage 2).

signal transition_started

const STAGE_01 := "res://stages/stage_01/stage_01.tscn"
const STAGE_02 := "res://stages/stage_02/stage_02.tscn"

@onready var _button_how_to_play := $MenuButtons/HowToPlay as TextureButton
@onready var _button_start := $MenuButtons/Start as TextureButton
@onready var _how_to_play := $HowToPlay as HowToPlay
@onready var _level_select := $LevelSelect
@onready var _animator := $AnimationPlayer as AnimationPlayer

var _pending_scene := STAGE_01
var _is_starting := false


func _ready() -> void:
	BackgroundLoader.load_resource(STAGE_01)
	BackgroundLoader.load_resource(STAGE_02)
	ScreenTransitions.fade_out_transition()
	_button_start.grab_focus()


func _on_start_pressed() -> void:
	_level_select.open_level_select()


func _on_stage_1_pressed() -> void:
	_start_stage(STAGE_01)


func _on_stage_2_pressed() -> void:
	_start_stage(STAGE_02)


func _on_level_select_level_chosen(scene_path: String) -> void:
	_start_stage(scene_path)


func _start_stage(scene_path: String) -> void:
	if _is_starting or _animator.assigned_animation == "game_started":
		return
	_is_starting = true
	_pending_scene = scene_path
	if _level_select.visible:
		_level_select.hide()
	_animator.play("game_started")
	await transition_started
	ScreenTransitions.transition_to_scene(_pending_scene)


func _on_level_select_level_select_closed() -> void:
	_button_start.grab_focus()


func _start_transition() -> void:
	transition_started.emit()


func _on_how_to_play_pressed() -> void:
	_how_to_play.open_how_to_play()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_how_to_play_closed() -> void:
	_button_how_to_play.grab_focus()

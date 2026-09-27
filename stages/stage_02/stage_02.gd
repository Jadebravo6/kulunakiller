extends BaseStage
## Stage 02 — squelette technique (sans décor), 5 fight rooms.
## Place tes sprites dans Background / Foreground / Level/Objects au fur et à mesure.

const NEXT_SCENE_ON_CLEAR := ""  # ex: "res://stages/stage_03/stage_03.tscn" plus tard

@onready var _fight_room_2 := %FightRoom2 as QuiverFightRoom


func _ready() -> void:
	super()


func _on_fight_2_spawner_all_waves_completed() -> void:
	var has_completed_all_waves := true
	for spawner in get_tree().get_nodes_in_group("fight_2_spawner"):
		if not (spawner as QuiverEnemySpawner).is_completed:
			has_completed_all_waves = false
			break
	if has_completed_all_waves:
		_fight_room_2.setup_after_fight_room()


func _on_final_spawner_all_waves_completed() -> void:
	if NEXT_SCENE_ON_CLEAR.is_empty():
		_end_screen.open_end_screen(true)
	else:
		ScreenTransitions.transition_to_scene(NEXT_SCENE_ON_CLEAR)

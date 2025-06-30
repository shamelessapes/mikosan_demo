extends Control

func _ready() -> void:
	$start.pressed.connect(start_game)
	$manual.pressed.connect(manual)
	$option.pressed.connect(option)
	$exit.pressed.connect(exit_game)
	$Window.hide()
	$Window2.hide()
	$Window.close_requested.connect(window_close)
	$Window2.close_requested.connect(window_close)
	
	
	await Global.fade_in(Color.BLACK)  # ← 最初のフェードインを待つ
	await get_tree().create_timer(2.0).timeout  # ← 2秒待機
	await Global.fade_out(Color.BLACK, 2.0)  # ← フェードアウトを待つ
	$madeby.hide()
	await Global.fade_in(Color.BLACK, 1.0)  # ← 再びフェードインを待つ
	$AudioStreamPlayer2D.play()
	
func start_game():
	SoundManager.play_se_by_path("res://se/決定ボタンを押す24.mp3")
	$AudioStreamPlayer2D.stop()
	await Global.change_scene_with_fade("res://tscn/demo_prorogue.tscn" , Color.WHITE)
	
func manual():
	SoundManager.play_se_by_path("res://se/blip03.mp3")
	$Window.show()
	
func exit_game():
	get_tree().quit()
	
func option():
	SoundManager.play_se_by_path("res://se/blip03.mp3")
	$Window2.show()

func window_close():
	$Window.hide()
	$Window2.hide()
	
func stop_bgm_with_fade(player: AudioStreamPlayer, duration: float = 2.0) -> void:
	var tween = create_tween()
	tween.tween_property(player, "volume_db", -80, duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	player.stop()

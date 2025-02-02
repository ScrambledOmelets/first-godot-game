extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$messageTimer.start()

func show_game_over():
	show_message("Game Over")
	#waiting for message timer to count down
	await $messageTimer.timeout
	#resetting text to title screen
	$Message.text = "creature dodging."
	$Message.show()
	#makes oneshot timer and waits for it to finish
	await get_tree().create_timer(1.0).timeout
	$startButton.show()
	
func update_score(score):
	$scoreLabel.text = str("score: ", score)
	
func update_coinScore(coinScore):
	$coinLabel.text = str(coinScore, ":gems")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	pass # Replace with function body.
	$startButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	pass # Replace with function body.
	$Message.hide()
	

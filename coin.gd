extends RigidBody2D

#when coin is picked up
signal grabbed 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$coinSprite.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass # Replace with function body.
	queue_free()
	


#func _on_body_entered(body: Node) -> void:
	#pass # Replace with function body.
	#
	#hide() #hide coin
	#print("coin has been hit!")
	#grabbed.emit()
	

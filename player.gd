extends Area2D
#custom signal for player collisions
signal hit
signal coin_grab

@export var speed = 400 #in pixels/sec
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screen_size = get_viewport_rect().size
	hide()

#something to reset the player when they begin the game
#but idk where to put it lmao
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	var v  = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		v.x += 1
	if Input.is_action_pressed("move_left"):
		v.x -= 1
	if Input.is_action_pressed("move_down"):
		v.y += 1
	if Input.is_action_pressed("move_up"):
		v.y -= 1
	
	if v.length() > 0:
		v = v.normalized() * speed
		#the $ is short for get_node
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	#updating position and locking player to screen borders w/ clamp function
	position += v * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if v.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = v.x < 0
	elif v.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = v.y > 0


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	if body.is_in_group("mobs"):
		hide() #player disappears after being hit
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true) #deferred to prevent the hit triggering more than once
		print("has collided with  ", body.name)
	else:
		coin_grab.emit()
		$CollisionShape2D.set_deferred("disabled", true)
		print("has collided with  ", body.name)
	

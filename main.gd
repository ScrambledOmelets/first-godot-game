extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	pass # Replace with function body.
	$music.stop()
	$deathSound.play()
	$scoreTimer.stop()
	$mobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	$music.play() #plays music
	score = 0
	#makes all the mobs delete themselves just b4 a new game
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("prepare yourself...")
	$Player.start($startPosition.position)
	$startTimer.start()
	
	


func _on_mob_timer_timeout() -> void:
	pass # Replace with function body.
	var mob = mob_scene.instantiate() #new mob scene instance
	
	#random spawn location
	var mob_spawn_location = $mobPath/mobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#setting mobs direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI/2
	
	#setting mob position to random location
	mob.position = mob_spawn_location.position
	
	#directional randomness
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	#mob velocity
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#spawns mob by adding it as a child to main scene
	add_child(mob)
	

func _on_score_timer_timeout() -> void:
	pass # Replace with function body.
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	pass # Replace with function body.
	$mobTimer.start()
	$scoreTimer.start()
	
	

extends CharacterBody2D
signal hit

@export var speed = 400
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size



func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	move_and_collide(velocity * delta)


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)



func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

extends CharacterBody2D

var health = 100

@onready var anim_player = $AnimatedSprite2D
var is_attacking = false
var is_hurting = false

func _ready():
	$HealthBar.value = health
	anim_player.play("idle")
	
func play_animation(animation):
	if animation == "attack" and not is_attacking:
		trigger_attack()
	if animation == "hurt" and not is_hurting:
		trigger_hurt()

func trigger_attack():
	# Set the flag to when attack is in progress
	is_attacking = true
	anim_player.play("attack")
	await get_tree().create_timer(1.0).timeout
	is_attacking = false
	anim_player.play("idle")

func trigger_hurt():
	# Set the flag to when hurt is in progress
	is_hurting = true
	anim_player.play("hurt")
	await get_tree().create_timer(0.6).timeout
	is_hurting = false
	anim_player.play("idle")

func take_damage(amount):
	health -= amount
	$HealthBar.value = health
	if health <= 0:
		die()
	
func die():
	anim_player.play("death")
	await get_tree().create_timer(1.0).timeout
	anim_player.pause()

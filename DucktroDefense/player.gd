extends CharacterBody2D

signal health_depleted

var health = 100.0

func _physics_process(delta):
	move_and_slide()
	%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()

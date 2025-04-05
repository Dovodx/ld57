extends Node

@export var health = 1.0
@export var maxhealth = 1.0
@export var team = 0
@export var dead = false

signal died

func hurtbox_hit(area: Area2D):
	if dead or area.get("team") == null: return
	if area.team != team:
		take_damage(area.damage)
		area.was_hit.emit()

func take_damage(damage):
	if dead: return
	print("taking damage, amount: " + str(damage))
	health -= damage
	if health <= 0:
		die()

func die():
	dead = true
	died.emit()

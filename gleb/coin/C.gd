extends Node2D


func _ready():
	pass 

func _on_Area2D_body_entered(body):
	if "2" in body.name:
		body.die()
		

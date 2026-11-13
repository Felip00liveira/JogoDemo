#refazer mais tarde essa parte, não gostei muito como ficou
extends StaticBody2D

var dano_total: int = 0

func receber_dano(quantidade: int) -> void:
	dano_total += quantidade
	
	
	modulate = Color.RED
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.15)

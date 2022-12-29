extends Area2D

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	$Label.text = str(random.randi_range(-50, 50))

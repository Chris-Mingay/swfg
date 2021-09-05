extends StaticBody2D
class_name Brick

const BREAK_THRESHOLD = 125

enum TYPES { STANDARD, NEEDS_FAST, NEEDS_SLOW }

export(TYPES) var Type :  = TYPES.STANDARD

func _ready():
	match Type:
		TYPES.STANDARD:
			$Sprite.frame = 1
		TYPES.NEEDS_FAST:
			$Sprite.frame = 2
		TYPES.NEEDS_SLOW:
			$Sprite.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

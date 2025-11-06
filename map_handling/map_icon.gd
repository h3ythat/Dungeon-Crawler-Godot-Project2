extends AnimatedSprite2D
@export var mapIconResource: MapIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	if(mapIconResource != null):
		var iconType: MapIcon.IconType = mapIconResource.icon_type
		if(iconType == MapIcon.IconType.ORIGIN):
			self.set_frame_and_progress(1, 0)
		if(iconType == MapIcon.IconType.LOADED):
			self.set_frame_and_progress(2, 0)
		if(iconType == MapIcon.IconType.UNLOADED):
			self.set_frame_and_progress(3, 0)
		if(iconType == MapIcon.IconType.CONNECTION):
			var connectFrame = mapIconResource.connection
			var frame: int
			match connectFrame:
				1: frame = 5
				2: frame = 6
				3: frame = 7
				4: frame = 8
			self.set_frame_and_progress(frame, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

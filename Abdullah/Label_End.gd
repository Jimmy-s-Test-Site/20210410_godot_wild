extends Label

var my_visible_characters = 0.1
var limit = 0

export (float) var speed = .3
export (int) var time_between = 1
var my_phrase = 1
var max_phrases = 3
var waiting = false
var done = false

func text_crawl():
	if my_visible_characters <= limit:
		my_visible_characters+= speed
		self.visible_characters = self.my_visible_characters
	else:
		if (self.waiting == false) and (self.done == false):
			$Timer.start(time_between)
			self.waiting = true


func _ready():
	$Timer.start(.1)


func _process(delta):
	self.text_crawl()



func _on_Timer_timeout():
	waiting = false
	
	
	if my_phrase == 1:
		self.my_visible_characters = 0
		self.limit = 40
		self.set_text(
			"Epic Sauce Dude! You Did it"
		)
	
	
	if my_phrase == 2:
		self.my_visible_characters = 0
		self.limit = 100
		$ColorRect2.visible = true
		self.set_text(
			"The door to heaven is open now. Be free yah hussy"
		)
	
	if my_phrase == 3:
		self.my_visible_characters = 0
		self.limit = 6
		self.set_text(
			"Peace"
		)
	
	if my_phrase == self.max_phrases:
		self.done = true
	
	self.my_phrase += 1
	$Timer.stop()
